

import UIKit

protocol SearchProductDisplayLogic: class {
    func didReceiveSearchListResponse(response: SearchProduct.ViewModel?, message: String, successCode: Int)
}

class SearchProductViewController: UIViewController {
    var interactor: SearchProductBusinessLogic?
    var router: (NSObjectProtocol & SearchProductRoutingLogic & SearchProductDataPassing)?
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var srchBar: UISearchBar!
    
    var searchData = [SearchProduct.SearchList]()
    var data = [SearchProduct.SearchList]()
    
    var pageCode = 0
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
        let interactor = SearchProductInteractor()
        let presenter = SearchProductPresenter()
        let router = SearchProductRouter()
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
        let request = SearchProduct.Request(pageCount: self.pageCode)
        GlobalUtility.showHud()
        interactor?.callSearchAPI(request: request)
        tblView.keyboardDismissMode = .onDrag
        srchBar.compatibleSearchTextField.textColor = .black
        srchBar.compatibleSearchTextField.backgroundColor = .white
        srchBar.backgroundImage = UIImage()
        
    }
    
    
    class func instance() -> SearchProductViewController? {
        return UIStoryboard(name: "SearchProduct", bundle: nil).instantiateViewController(withIdentifier: "SearchProductViewController") as? SearchProductViewController
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}



extension SearchProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchProductTableViewCell", for: indexPath) as! SearchProductTableViewCell
        
        if self.searchData[indexPath.row].type == "category" {
            cell.lblTitle.isHidden = true
            cell.viewCategory.isHidden = false
            cell.lblCatTitle.text = self.searchData[indexPath.row].name ?? ""
        }else {
            cell.lblTitle.isHidden = false
            cell.viewCategory.isHidden = true
            cell.lblTitle.text = self.searchData[indexPath.row].name ?? ""
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if GuestUser.isUserGuest {
//            self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
//                if let VC = AuthenticationViewController.instance() {
//                    let navVC = UINavigationController(rootViewController: VC)
//                    AppConstant.appDelegate.window?.rootViewController = navVC
//                }
//            }, cancelAction: nil)
//        }else {
//
//        }
        
        
        if self.searchData[indexPath.row].type == "product" {
            if let VC = ProductDetailsViewController.instance() {
                VC.productId = self.searchData[indexPath.row].ID  ?? ""
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }else if self.searchData[indexPath.row].type == "tag" {
            if let VC = WishListViewController.instance() {
                VC.isFrom = "category"
                VC.searchText = self.srchBar.text ?? ""
                VC.catId = ""
                self.navigationController?.pushViewController(VC, animated: true)
            }
        } else {
            if let VC = WishListViewController.instance() {
                VC.isFrom = "category"
                VC.searchText = self.srchBar.text ?? ""
                VC.catId = self.searchData[indexPath.row].ID  ?? ""
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
    }
    
}

extension SearchProductViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if srchBar.text == "" {
            self.searchData.removeAll()
        }else {
            self.searchData = self.data.filter{ ($0.name ?? "").contains(srchBar.text ?? "")}
        }
        self.tblView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let VC = WishListViewController.instance() {
            VC.isFrom = "category"
            VC.searchText = self.srchBar.text ?? ""
            VC.catId = ""
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
}

extension SearchProductViewController: SearchProductDisplayLogic {
    func didReceiveSearchListResponse(response: SearchProduct.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let resp = response {
                if self.pageCode == 0 {
                    self.data = resp.search_list!
                }else {
                    self.data  = self.data + (resp.search_list!)
                }
                if pageCode == 3 {
                    GlobalUtility.hideHud()
                    self.tblView.reloadData()
                    self.srchBar.becomeFirstResponder()
                }else {
                    
                }
                pageCode += 1
                if pageCode < 3 {
                    let request = SearchProduct.Request(pageCount: pageCode)
                    interactor?.callSearchAPI(request: request)
                }
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    
}


extension UISearchBar {

    // Due to searchTextField property who available iOS 13 only, extend this property for iOS 13 previous version compatibility
    var compatibleSearchTextField: UITextField {
        guard #available(iOS 13.0, *) else { return legacySearchField }
        return self.searchTextField
    }

    private var legacySearchField: UITextField {
        if let textField = self.subviews.first?.subviews.last as? UITextField {
            // Xcode 11 previous environment
            return textField
        } else if let textField = self.value(forKey: "searchField") as? UITextField {
            // Xcode 11 run in iOS 13 previous devices
            return textField
        } else {
            // exception condition or error handler in here
            return UITextField()
        }
    }
}
