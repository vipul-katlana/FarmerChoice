
import UIKit

protocol CategoryDisplayLogic: class {
    func didReceiveCategoryResponse(response: Category.ViewModel?, message: String, successCode: Int)
}

class CategoryViewController: UIViewController {
    var interactor: CategoryBusinessLogic?
    var router: (NSObjectProtocol & CategoryRoutingLogic & CategoryDataPassing)?
    @IBOutlet weak var tblView: UITableView!
    
    var categoryList = [Category.CategoryList]()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = CategoryInteractor()
        let presenter = CategoryPresenter()
        let router = CategoryRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    class func instance() -> CategoryViewController? {
        return UIStoryboard(name: "Category", bundle: nil).instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController
    }
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.callCategoryAPI()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btncategoryAction(_ sender: Any) {
        if let VC = SearchProductViewController.instance(){
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
}


extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        cell.lblTitle.text = categoryList[indexPath.row].name ?? ""
        cell.imgIcon.setImage(with: "\(categoryList[indexPath.row].icon ?? "")",placeHolder: UIImage(named: "common_Placeholder"))
        
        var tm = false
        if categoryList[indexPath.row].isExpand ?? 0 == 1 {
            tm = true
        }
        
        let secondTmp = categoryList[indexPath.row].subcat_list?.filter{$0.subcat == "Yes"}
        let newTm = secondTmp?.filter{$0.isExpand ?? 0 == 1}
        
        cell.setFirstLevelData(data: categoryList[indexPath.row].subcat_list,isExpand: tm, secondLevelCategoryCount: newTm?.count ?? 0)
        
        if categoryList[indexPath.row].isExpand ?? 0 == 1{
            cell.btnExoand.isSelected = true
        }else {
            cell.btnExoand.isSelected = false
        }
        
        if categoryList[indexPath.row].subcat ?? "" == "Yes" {
            cell.btnExoand.isHidden = false
        }else {
            cell.btnExoand.isHidden = true
        }
    
        cell.expandCloser = {
            if cell.btnExoand.isSelected {
                cell.btnExoand.isSelected = false
                let temp = self.categoryList[indexPath.row]
                temp.isExpand = 0
                self.categoryList[indexPath.row] = temp
                self.tblView.reloadData()
            }else {
                cell.btnExoand.isSelected = true
                let temp = self.categoryList[indexPath.row]
                temp.isExpand = 1
                self.categoryList[indexPath.row] = temp
                self.tblView.reloadData()
            }
        }
        
        cell.secondLevelExpandCloser = { secondLevelId, secondIndex in
            var main = self.categoryList[indexPath.row]
            var temp = main.subcat_list
            if temp?[secondIndex].isExpand == 1 {
                temp?[secondIndex].isExpand = 0
            }else {
                temp?[secondIndex].isExpand = 1
            }
            
            main.subcat_list = temp
            self.categoryList[indexPath.row] = main
            self.tblView.reloadData()
        }
        
        cell.firstLevelCategoryAction = { catId in
            if let VC = WishListViewController.instance() {
                VC.isFrom = "category"
                VC.catId = catId
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let VC = WishListViewController.instance() {
            VC.isFrom = "category"
            VC.catId = categoryList[indexPath.row].catID ?? ""
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
}

extension CategoryViewController: CategoryDisplayLogic {
    func didReceiveCategoryResponse(response: Category.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                self.categoryList = data.categoryList!
                self.tblView.reloadData()
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
}
