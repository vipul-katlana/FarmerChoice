

import UIKit

protocol BrandDisplayLogic: class {
    func didReceiveBrandListResponse(response: Brand.ViewModel?, message: String, successCode: Int)
}

class BrandViewController: UIViewController {
    
    @IBOutlet weak var clctnView: UICollectionView!
    
    var interactor: BrandBusinessLogic?
    var router: (NSObjectProtocol & BrandRoutingLogic & BrandDataPassing)?
    
    
    var dataArray = [Brand.Brand_list]()
    var pageCode = 0
    var nextPageAvailable = true
    var apiCallInprogress = false
    
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
        let interactor = BrandInteractor()
        let presenter = BrandPresenter()
        let router = BrandRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = Brand.Request(pageCode: self.pageCode)
        interactor?.callAPI(request: request, loader: true)
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    class func instance() -> BrandViewController? {
        return UIStoryboard(name: "Brand", bundle: nil).instantiateViewController(withIdentifier: "BrandViewController") as? BrandViewController
    }
}



extension BrandViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCollectionViewCell", for: indexPath) as!  BrandCollectionViewCell
        cell.imgIcon.setImage(with: dataArray[indexPath.row].image ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((UIScreen.main.bounds.width - 20) / 3), height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let VC = WishListViewController.instance() {
            VC.isFrom = "brand"
            VC.brandId = dataArray[indexPath.row].brandID ?? ""
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !apiCallInprogress && (indexPath.row == dataArray.count - 3) && nextPageAvailable {
            apiCallInprogress = true
            self.pageCode += 1
            let request = Brand.Request(pageCode: self.pageCode)
            interactor?.callAPI(request: request,loader: false)
        }
    }
    
}

extension BrandViewController : BrandDisplayLogic {
    func didReceiveBrandListResponse(response: Brand.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                apiCallInprogress = false
                if data.brand_list != nil {
                    if pageCode == 0 {
                        self.dataArray = data.brand_list!
                    }else {
                        self.dataArray.append(contentsOf: data.brand_list!)
                    }
                    self.clctnView.reloadData()
                }
            }
        }else {
            //self.showTopMessage(message: message, type: .Error)
        }
    }
}
