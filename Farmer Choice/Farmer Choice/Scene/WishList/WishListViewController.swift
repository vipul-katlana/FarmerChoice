
import UIKit


protocol QuatityBoxUpdate {
    func quantityChanged(qty: String, productID: String, priceId: String, type: String)
}

protocol ChangeProductType {
    func change(index: Int,cellIndex: Int)
}

protocol CategoryChange {
    func change(id: String)
}
protocol WishListDisplayLogic: class {
    func didReceiveProductListResponse(response: ProductList.ViewModel?, message: String, successCode: Int)
    func didReceiveBrandListResponse(response: ProductList.ViewModel?, message: String, successCode: Int)
    func didReceiveLastChoiceResponse(response: ProductList.ViewModel?, message: String, successCode: Int)
    func didReceiveWishListResponse(response: ProductList.WishListViewModel?, message: String, successCode: Int)
    func didReceiveAddRemoveResponse(response: AddCart.ViewModel?, message: String, successCode: Int)
    func didReceiveAddRemoveWishListResponse(response: AddRemoveWishList.ViewModel?, message: String, successCode: Int)
}

class WishListViewController: BaseViewController {
    
    var interactor: WishListBusinessLogic?
    var router: (NSObjectProtocol & WishListRoutingLogic & WishListDataPassing)?
    
    @IBOutlet weak var imgBottomTableClctn: UIImageView!
    @IBOutlet weak var imgTopTblClctn: UIImageView!
    @IBOutlet weak var viewCart: UIView!
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var clctnView: UICollectionView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var vieTopCategory: UIView!
    @IBOutlet weak var viewTopStack: UIView!
    @IBOutlet weak var viewBottomStack: UIView!
    @IBOutlet weak var viewChange: UIView!
    @IBOutlet weak var lblCatTitle: UILabel!
    @IBOutlet weak var viewNoRecord: UIView!
    
    @IBOutlet weak var viewSubCat: UIView!
    
    
    @IBOutlet weak var clctnSubcategory: UICollectionView!
    
    
    var productList = [ProductList.Product_list]()
    var productData : ProductList.ViewModel?
    
    var nextPageAvailable = true
    var apiCallInprogress = false
    var selectedIndex = 0
    var cartType = ""
    var removeProduct = false
    var favType = ""
    
    var isTableView = true
    var isFrom = ""
    var pageCode = 0
    var catId = ""
    var filterType = ""
    var searchText = ""
    var brandId = ""
    
    
    
    
    var subCatArray = [ProductList.Subcate_list]()
    var subCatIndex = 0
    
    var cartUpdatedQty = ""
    
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
        let interactor = WishListInteractor()
        let presenter = WishListPresenter()
        let router = WishListRouter()
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
        self.setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setCartCount()
    }
    
    func setCartCount() {
        self.viewCart.isHidden = false
        self.lblCartCount.text = UserDefaultsManager.getCartCount()
    }
    
    func setUp() {
        self.viewChange.setBorderWithColor(color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.4009683099))
        if isFrom == "wishList" {
            self.lblTitle.text = "My Wish List"
            self.viewBottomStack.isHidden = true
            self.vieTopCategory.isHidden = true
            callWishListAPI(showLoader: true)
        }else if isFrom == "lastChoice" {
            self.lblTitle.text = "Last Choice"
            self.viewBottomStack.isHidden = true
            self.vieTopCategory.isHidden = true
            callLastChoiceAPI(showLoader: true)
        }else if isFrom == "brand" {
            self.lblTitle.text = "Brand"
            self.viewBottomStack.isHidden = true
            self.vieTopCategory.isHidden = true
            callBrandListAPI(showLoader: true)
        }else {
            self.lblTitle.text = "\(AppInfo.kAppName)"
            self.viewTopStack.isHidden = true
            self.vieTopCategory.isHidden = false
            callAPI(catId: self.catId, showLoader: true)
        }
        
        if isFrom != "wishList" {
            //self.viewNoRecord.addSubview(self.getNoDataView(filename: "nodata", view: self.viewNoRecord, size: 200))
        }else {
            //self.viewNoRecord.addSubview(self.getNoDataView(filename: "no_order", view: self.viewNoRecord, size: 200))
        }
        
        if searchText != "" {
            self.lblTitle.text = searchText
        }
        
        
    }
    
    func callAPI(catId: String,showLoader: Bool) {
        let request = ProductList.Request(pageCode: "\(pageCode)", catId: catId, search: self.searchText, type: self.filterType)
        interactor?.callProductListApi(request: request, loader: showLoader)
    }
    
    func callWishListAPI(showLoader: Bool) {
        let request = ProductList.WishListRequest(pageCode: "\(self.pageCode)", type: self.filterType)
        interactor?.callWishListApi(request: request, loader: showLoader)
    }
    
    func callLastChoiceAPI(showLoader: Bool) {
        let request = ProductList.LastChoiceRequest(pageCode: "\(self.pageCode)")
        interactor?.callLastChoiceApi(request: request, loader: showLoader)
    }
    
    func callBrandListAPI(showLoader: Bool) {
        let request = ProductList.BrandList(brandId: self.brandId, type: "", pageCode: "\(self.pageCode)")
        interactor?.callBrandListApi(request: request, loader: showLoader)
    }
    
    func setPicker() {
        let actionSheetController = UIAlertController(title: "SORT BY", message: "", preferredStyle: .actionSheet)
        
        let LTH = UIAlertAction(title: "Price - Low to High", style: .default) { action -> Void in
            self.pageCode = 0
            self.filterType = "price_l_h"
            if self.isFrom == "wishList"  {
                self.callWishListAPI(showLoader: true)
            }else if self.isFrom == "lastChoice" {
                self.callLastChoiceAPI(showLoader: true)
            } else {
                self.callAPI(catId: self.catId, showLoader: true)
            }
            
            
        }
        actionSheetController.addAction(LTH)
        
        let HTL = UIAlertAction(title: "Price - High to Low", style: .default) { action -> Void in
            self.pageCode = 0
            self.filterType = "price_h_l"
            if self.isFrom == "wishList"  {
                self.callWishListAPI(showLoader: true)
            }else {
                self.callAPI(catId: self.catId, showLoader: true)
            }
            
        }
        actionSheetController.addAction(HTL)
        
        let NAZ = UIAlertAction(title: "Name - A to Z", style: .default) { action -> Void in
            self.pageCode = 0
            self.filterType = "name_a_z"
            if self.isFrom == "wishList"  {
                self.callWishListAPI(showLoader: true)
            }else {
                self.callAPI(catId: self.catId, showLoader: true)
            }
            
        }
        actionSheetController.addAction(NAZ)
        
        let NZA = UIAlertAction(title: "Name - Z to A", style: .default) { action -> Void in
            self.pageCode = 0
            self.filterType = "name_z_a"
            if self.isFrom == "wishList"  {
                self.callWishListAPI(showLoader: true)
            }else {
                self.callAPI(catId: self.catId, showLoader: true)
            }
            
        }
        actionSheetController.addAction(NZA)
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancel)
        
        DispatchQueue.main.async {
            GlobalUtility.shared.currentTopViewController().present(actionSheetController, animated: true, completion: nil)
        }
        
    }
    
    
    
    class func instance() -> WishListViewController? {
        return UIStoryboard(name: "WishList", bundle: nil).instantiateViewController(withIdentifier: "WishListViewController") as? WishListViewController
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSortAction(_ sender: Any) {
        if isTableView {
            isTableView = false
            self.tblView.isHidden = true
            self.clctnView.isHidden = false
            self.clctnView.reloadData()
            self.imgTopTblClctn.image = UIImage(named: "wishlist_table")
        }else {
            isTableView = true
            self.tblView.isHidden = false
            self.clctnView.isHidden = true
            self.tblView.reloadData()
            self.imgTopTblClctn.image = UIImage(named: "wishlist_collection")
        }
    }
    
    @IBAction func btnBottomChangeTableCollectionAction(_ sender: Any) {
        if isTableView {
            isTableView = false
            self.tblView.isHidden = true
            self.clctnView.isHidden = false
            self.clctnView.reloadData()
            self.imgBottomTableClctn.image = UIImage(named: "wishlist_table")
        }else {
            isTableView = true
            self.tblView.isHidden = false
            self.clctnView.isHidden = true
            self.tblView.reloadData()
            self.imgBottomTableClctn.image = UIImage(named: "wishlist_collection")
        }
    }
    
    
    @IBAction func btnChangeAction(_ sender: Any) {
        if let customPopUp = ChangeCategoryViewController.instance() {
            customPopUp.modalPresentationStyle = .overCurrentContext
            if productData?.cate_list != nil {
                customPopUp.data = (productData?.cate_list)!
            }
            
            customPopUp.catDelegate = self
            self.present(customPopUp, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnAllAction(_ sender: Any) {
        
    }
    
    @IBAction func btnTopSortACtion(_ sender: Any) {
        setPicker()
    }
    
    @IBAction func btnBottomSortAction(_ sender: Any) {
        setPicker()
    }
    
    @IBAction func btnRedirectCartAction(_ sender: Any) {
        self.redirectToCart()
    }
    
    @IBAction func btncategoryAction(_ sender: Any) {
        if let VC = SearchProductViewController.instance(){
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    
}

extension WishListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishListTableViewCell", for: indexPath) as! WishListTableViewCell
        cell.setData(data: productList[indexPath.row])
        if isFrom == "wishList" {
            cell.btnFav.isHidden = true
            cell.btnDelete.isHidden = false
           // cell.imgArrow.isHidden = true
        }else if isFrom == "lastChoice" || isFrom == "brand" {
            cell.btnFav.isHidden = false
            cell.btnDelete.isHidden = true
            //cell.imgArrow.isHidden = false
        } else {
            cell.btnFav.isHidden = false
            cell.btnDelete.isHidden = true
          //  cell.imgArrow.isHidden = false
        }
        
        cell.addClouser = {
            if GuestUser.isUserGuest {
                self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                    if let VC = AuthenticationViewController.instance() {
                        let navVC = UINavigationController(rootViewController: VC)
                        AppConstant.appDelegate.window?.rootViewController = navVC
                    }
                }, cancelAction: nil)
            }else {
                
                self.selectedIndex = indexPath.row
                self.cartType = "PLUS"
//                let request = AddCart.Request(productId: self.productList[indexPath.row].productID ?? "", priceID: self.productList[indexPath.row].price_list?[self.productList[indexPath.row].selectedProduct ?? 0].price_ID ?? "", qtyType: "PLUS")
//                self.interactor?.callAddRemoveApi(request: request)
                
               
                if let VC = QuantityBoxViewController.instance() {
                    let currProd = QuantityBox(imgProduct: self.productList[indexPath.row].image ?? "", englishTitle: self.productList[indexPath.row].name ?? "", hindiTitle: self.productList[indexPath.row].caption ?? "", price: "₹\(self.productList[indexPath.row].price_list?[self.productList[indexPath.row].selectedProduct ?? 0].price ?? "")", weight: self.productList[indexPath.row].price_list?[self.productList[indexPath.row].selectedProduct ?? 0].weight ?? "", currentQty: self.productList[indexPath.row].price_list?[self.productList[indexPath.row].selectedProduct ?? 0].cart_qty ?? "",productID: self.productList[indexPath.row].productID ?? "",priceID: self.productList[indexPath.row].price_list?[self.productList[indexPath.row].selectedProduct ?? 0].price_ID ?? "",type: "PLUS", maxQty: (self.productList[indexPath.row].price_list?[self.productList[indexPath.row].selectedProduct ?? 0].maxQty ?? ""))
                    VC.currentProduct = currProd
                    VC.delegate = self
                    VC.modalPresentationStyle = .overCurrentContext
                    self.present(VC, animated: false, completion: nil)
                }
            }
            
        }
        
        cell.removeClouser = {
            if GuestUser.isUserGuest {
                self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                    if let VC = AuthenticationViewController.instance() {
                        let navVC = UINavigationController(rootViewController: VC)
                        AppConstant.appDelegate.window?.rootViewController = navVC
                    }
                }, cancelAction: nil)
            }else {
                self.cartType = "MINUS"
                self.selectedIndex = indexPath.row
                let request = AddCart.Request(productId: self.productList[indexPath.row].productID ?? "", priceID: self.productList[indexPath.row].price_list?[self.productList[indexPath.row].selectedProduct ?? 0].price_ID ?? "", qtyType: "MINUS", cartQty: "cartQty")
                self.interactor?.callAddRemoveApi(request: request)
            }
            
        }
        
        cell.addFavClouser = {
            if GuestUser.isUserGuest {
                self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                    if let VC = AuthenticationViewController.instance() {
                        let navVC = UINavigationController(rootViewController: VC)
                        AppConstant.appDelegate.window?.rootViewController = navVC
                    }
                }, cancelAction: nil)
            }else {
                self.selectedIndex = indexPath.row
                if self.productList[indexPath.row].wishlist ?? "" == "No" {
                    self.favType = "Add"
                    let request = AddRemoveWishList.Request(productId: self.productList[indexPath.row].productID ?? "", pageType: "add_wishlist", wishId: "")
                    self.interactor?.callAddRemoveWishListApi(request: request)
                }else {
                    self.favType = "Remove"
                    let request = AddRemoveWishList.Request(productId: self.productList[indexPath.row].productID ?? "", pageType: "add_wishlist", wishId: "")
                    self.interactor?.callAddRemoveWishListApi(request: request)
                }
            }
            
        }
        
        cell.deleteClouser = {
            if GuestUser.isUserGuest {
                self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                    if let VC = AuthenticationViewController.instance() {
                        let navVC = UINavigationController(rootViewController: VC)
                        AppConstant.appDelegate.window?.rootViewController = navVC
                    }
                }, cancelAction: nil)
            }else {
                self.selectedIndex = indexPath.row
                self.displayAlert(msg: "Are you sure you want to remove this product?", ok: "Yes", cancel: "No", okAction: {
                    self.removeProduct = true
                    let request = AddRemoveWishList.Request(productId:"", pageType: "item_delete", wishId: self.productList[indexPath.row].whishID ?? "")
                    self.interactor?.callAddRemoveWishListApi(request: request)
                }, cancelAction: nil)
            }
            
        }
        
        
        cell.dropDownClouser = {
            if let VC = ProductTypeViewController.instance() {
                VC.modalPresentationStyle = .overCurrentContext
                VC.dataArray = [self.productList[indexPath.row]]
                VC.cellIndex = indexPath.row
                VC.delegateChange = self
                self.present(VC, animated: false, completion: nil)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let VC = ProductDetailsViewController.instance() {
            VC.productId = self.productList[indexPath.row].productID  ?? ""
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if !apiCallInprogress && (indexPath.row == productList.count - 1) && nextPageAvailable {
            
            apiCallInprogress = true
            self.pageCode += 1
            
            if isFrom == "wishList" {
                self.callWishListAPI(showLoader: false)
            }else if isFrom == "lastChoice"  {
                self.callLastChoiceAPI(showLoader: false)
            }else if isFrom == "brand" {
                self.callBrandListAPI(showLoader: false)
            }else {
                callAPI(catId: self.catId, showLoader: false)
            }
        }
    }
    
    
    
}

extension WishListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clctnSubcategory {
            return subCatArray.count
        }else {
            return productList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == clctnSubcategory {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishListSubCategoryCollectionViewCell", for: indexPath) as! WishListSubCategoryCollectionViewCell
            
            
            if subCatIndex == indexPath.row {
                cell.lblCatTitle.textColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
                cell.vwBG.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.vwBG.layer.borderWidth = 1
                cell.vwBG.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
                
            }else {
                cell.lblCatTitle.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.vwBG.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
                cell.vwBG.layer.borderWidth = 1
                cell.vwBG.layer.borderColor = #colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1)
            }
            
            cell.lblCatTitle.text = subCatArray[indexPath.row].name ?? ""
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishListCollectionViewCell", for: indexPath) as! WishListCollectionViewCell
            
            cell.setData(data: productList[indexPath.row])
            if isFrom == "wishList" {
                cell.btnFav.isHidden = true
                cell.btnDelete.isHidden = false
                cell.lblOff.isHidden = true
                
            }else if isFrom == "lastChoice" || isFrom == "brand" {
                cell.btnFav.isHidden = false
                cell.btnDelete.isHidden = true
            }else {
                cell.btnFav.isHidden = false
                cell.btnDelete.isHidden = true
            }
            
            cell.addClouser = {
                if GuestUser.isUserGuest {
                    self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                        if let VC = AuthenticationViewController.instance() {
                            let navVC = UINavigationController(rootViewController: VC)
                            AppConstant.appDelegate.window?.rootViewController = navVC
                        }
                    }, cancelAction: nil)
                }else {
                    self.selectedIndex = indexPath.row
                    self.cartType = "PLUS"
//                    let request = AddCart.Request(productId: self.productList[indexPath.row].productID ?? "", priceID: self.productList[indexPath.row].price_list?[self.productList[indexPath.row].selectedProduct ?? 0].price_ID ?? "", qtyType: "PLUS", cartQty: "cartQty")
//                    self.interactor?.callAddRemoveApi(request: request)
                    
                    
                    if let VC = QuantityBoxViewController.instance() {
                        let currProd = QuantityBox(imgProduct: self.productList[indexPath.row].image ?? "", englishTitle: self.productList[indexPath.row].name ?? "", hindiTitle: self.productList[indexPath.row].caption ?? "", price: "₹\(self.productList[indexPath.row].price_list?[self.productList[indexPath.row].selectedProduct ?? 0].price ?? "")", weight: self.productList[indexPath.row].price_list?[self.productList[indexPath.row].selectedProduct ?? 0].weight ?? "", currentQty: self.productList[indexPath.row].price_list?[self.productList[indexPath.row].selectedProduct ?? 0].cart_qty ?? "",productID: self.productList[indexPath.row].productID ?? "",priceID: self.productList[indexPath.row].price_list?[self.productList[indexPath.row].selectedProduct ?? 0].price_ID ?? "",type: "PLUS", maxQty: (self.productList[indexPath.row].price_list?[self.productList[indexPath.row].selectedProduct ?? 0].maxQty ?? ""))
                        VC.currentProduct = currProd
                        VC.delegate = self
                        VC.modalPresentationStyle = .overCurrentContext
                        self.present(VC, animated: false, completion: nil)
                    }
                }
                
            }
            
            cell.removeClouser = {
                if GuestUser.isUserGuest {
                    self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                        if let VC = AuthenticationViewController.instance() {
                            let navVC = UINavigationController(rootViewController: VC)
                            AppConstant.appDelegate.window?.rootViewController = navVC
                        }
                    }, cancelAction: nil)
                }else {
                    self.cartType = "MINUS"
                    self.selectedIndex = indexPath.row
                    let request = AddCart.Request(productId: self.productList[indexPath.row].productID ?? "", priceID: self.productList[indexPath.row].price_list?[self.productList[indexPath.row].selectedProduct ?? 0].price_ID ?? "", qtyType: "MINUS", cartQty: "cartQty")
                    self.interactor?.callAddRemoveApi(request: request)
                }
                
            }
            
            cell.addFavClouser = {
                if GuestUser.isUserGuest {
                    self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                        if let VC = AuthenticationViewController.instance() {
                            let navVC = UINavigationController(rootViewController: VC)
                            AppConstant.appDelegate.window?.rootViewController = navVC
                        }
                    }, cancelAction: nil)
                }else {
                    self.selectedIndex = indexPath.row
                    if self.productList[indexPath.row].wishlist ?? "" == "No" {
                        self.favType = "Add"
                        let request = AddRemoveWishList.Request(productId: self.productList[indexPath.row].productID ?? "", pageType: "add_wishlist", wishId: "")
                        self.interactor?.callAddRemoveWishListApi(request: request)
                    }else {
                        self.favType = "Remove"
                        let request = AddRemoveWishList.Request(productId: self.productList[indexPath.row].productID ?? "", pageType: "add_wishlist", wishId: "")
                        self.interactor?.callAddRemoveWishListApi(request: request)
                    }
                }
                
            }
            
            cell.deleteClouser = {
                if GuestUser.isUserGuest {
                    self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                        if let VC = AuthenticationViewController.instance() {
                            let navVC = UINavigationController(rootViewController: VC)
                            AppConstant.appDelegate.window?.rootViewController = navVC
                        }
                    }, cancelAction: nil)
                }else {
                    self.selectedIndex = indexPath.row
                    self.displayAlert(msg: "Are you sure you want to remove this product?", ok: "Yes", cancel: "No", okAction: {
                        self.removeProduct = true
                        let request = AddRemoveWishList.Request(productId:"", pageType: "item_delete", wishId: self.productList[indexPath.row].whishID ?? "")
                        self.interactor?.callAddRemoveWishListApi(request: request)
                    }, cancelAction: nil)
                }
                
            }
            
            cell.dropDownClouser = {
                if let VC = ProductTypeViewController.instance() {
                    VC.modalPresentationStyle = .overCurrentContext
                    VC.dataArray = [self.productList[indexPath.row]]
                    VC.cellIndex = indexPath.row
                    VC.delegateChange = self
                    self.present(VC, animated: false, completion: nil)
                }
            }
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == clctnSubcategory {
            return CGSize(width: 80.0, height: 40.0)
        }else {
            if productList.count == 1 {
                return CGSize(width: ((UIScreen.main.bounds.width - 0) / 2), height: 310.0)
            }else {
                return CGSize(width: ((UIScreen.main.bounds.width - 0) / 2), height: 310.0)
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == clctnSubcategory {
            //callAPI AGAIN
            subCatIndex = indexPath.row
            self.catId = self.subCatArray[indexPath.row].subcatID ?? ""
            self.clctnSubcategory.reloadData()
            self.pageCode = 0
            if isFrom == "wishList" {
                callWishListAPI(showLoader: true)
            }else if isFrom == "lastChoice" {
                callLastChoiceAPI(showLoader: true)
            }else if isFrom == "brand" {
                callBrandListAPI(showLoader: true)
            }else {
                callAPI(catId: self.catId, showLoader: true)
            }
            
        }else {
            if let VC = ProductDetailsViewController.instance() {
                VC.productId = self.productList[indexPath.row].productID  ?? ""
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == clctnSubcategory {
        }else {
            if !apiCallInprogress && (indexPath.row == productList.count - 1) && nextPageAvailable {
                print("API CALL")
                apiCallInprogress = true
                self.pageCode += 1
                
                if isFrom == "wishList" {
                    self.callWishListAPI(showLoader: false)
                }else if isFrom == "lastChoice"  {
                    self.callLastChoiceAPI(showLoader: false)
                }else if isFrom == "brand" {
                    self.callBrandListAPI(showLoader: false)
                } else {
                    callAPI(catId: self.catId, showLoader: false)
                }
            }
        }
        
    }
}

extension WishListViewController: CategoryChange {
    func change(id: String) {
        self.pageCode = 0
        self.subCatIndex = 0
        self.catId = id
        self.filterType = ""
        self.callAPI(catId: id, showLoader: true)
    }
}

extension WishListViewController: ChangeProductType {
    func change(index: Int,cellIndex: Int) {
        self.dismiss(animated: false, completion: nil)
        var temp = self.productList[cellIndex]
        temp.selectedProduct = index
        self.productList[cellIndex] = temp
        
        if isTableView {
            self.tblView.reloadRows(at: [IndexPath(row: cellIndex, section: 0)], with: .none)
        }else {
            self.clctnView.reloadItems(at: [IndexPath(row: cellIndex, section: 0)])
        }
        
    }
    
    
}


extension WishListViewController: WishListDisplayLogic {
    func didReceiveProductListResponse(response: ProductList.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            print(successCode)
            if let data = response {
                self.viewNoRecord.isHidden = true
                
                if self.productData?.cate_list?.count == nil {
                    self.productData = data
                }
                
                if let tem = data.subcate_list {
                    if tem.count != 0 {
                        self.subCatArray = tem
                    }
                    
                }
                if self.subCatArray.count == 0 {
                    self.viewSubCat.isHidden = true
                }else {
                    self.viewSubCat.isHidden = false
                    self.clctnSubcategory.reloadData()
                }
                
                self.lblCatTitle.text = "\(data.cate_name ?? "") (\(data.total_product ?? 0) Items )"
                if data.product_list?.count ?? 0 > 0 {
                    if pageCode == 0 {
                        self.productList = data.product_list!
                    }else {
                        self.productList.append(contentsOf: data.product_list!)
                        self.apiCallInprogress = false
                    }
                }
                self.tblView.reloadData()
                self.clctnView.reloadData()
                
                
                if productList.count == data.total_product ?? 0 {
                    self.nextPageAvailable = false
                }else {
                    self.nextPageAvailable = true
                }
            }else {
                self.lblCatTitle.text = ""
                self.productList.removeAll()
                self.tblView.reloadData()
                self.clctnView.reloadData()
                self.viewNoRecord.isHidden = false
            }
        }else {
            self.lblCatTitle.text = ""
            self.productList.removeAll()
            self.tblView.reloadData()
            self.clctnView.reloadData()
            self.viewNoRecord.isHidden = false
            //self.showTopMessage(message: message, type: .Error)
        }
    }
    
    func didReceiveLastChoiceResponse(response: ProductList.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            print(successCode)
            if let data = response {
                self.viewNoRecord.isHidden = true
                if let tem = data.subcate_list {
                    if tem.count != 0 {
                        self.subCatArray = tem
                    }
                }
                if self.subCatArray.count == 0 {
                    self.viewSubCat.isHidden = true
                }else {
                    self.viewSubCat.isHidden = false
                }
                
                self.clctnSubcategory.reloadData()
                if self.productData?.cate_list?.count == nil {
                    self.productData = data
                }
                self.lblCatTitle.text = "\(data.cate_name ?? "") (\(data.total_product ?? 0) Items )"
                if data.product_list?.count ?? 0 > 0 {
                    if pageCode == 0 {
                        self.productList = data.product_list!
                    }else {
                        self.productList.append(contentsOf: data.product_list!)
                        self.apiCallInprogress = false
                    }
                }
                
                self.tblView.reloadData()
                if productList.count == data.total_product ?? 0 {
                    self.nextPageAvailable = false
                }else {
                    self.nextPageAvailable = true
                }
            }else {
                self.lblCatTitle.text = ""
                self.productList.removeAll()
                self.tblView.reloadData()
                self.viewNoRecord.isHidden = false
            }
        }else {
            self.lblCatTitle.text = ""
            self.productList.removeAll()
            self.tblView.reloadData()
            self.viewNoRecord.isHidden = false
            //self.showTopMessage(message: message, type: .Error)
        }
        
    }
    
    func didReceiveWishListResponse(response: ProductList.WishListViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            print(successCode)
            if let data = response {
                self.viewNoRecord.isHidden = true
                
                
                if data.whish_product_list?.count ?? 0 > 0 {
                    if pageCode == 0 {
                        self.productList = data.whish_product_list!
                    }else {
                        self.productList.append(contentsOf: data.whish_product_list!)
                        self.apiCallInprogress = false
                    }
                }
                
                self.tblView.reloadData()
                if productList.count == data.total_whish_product ?? 0 {
                    self.nextPageAvailable = false
                }else {
                    self.nextPageAvailable = true
                }
            }else {
                self.lblCatTitle.text = ""
                self.productList.removeAll()
                self.tblView.reloadData()
                self.viewNoRecord.isHidden = false
            }
        }else {
            self.lblCatTitle.text = ""
            self.productList.removeAll()
            self.tblView.reloadData()
            self.viewNoRecord.isHidden = false
        }
        
    }
    
    func didReceiveAddRemoveResponse(response: AddCart.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if response != nil {
                var updatedValue = productList[self.selectedIndex]
                var newVal = ""
//                if self.cartType == "PLUS" {
//                    let temp = (updatedValue.price_list?[updatedValue.selectedProduct ?? 0].cart_qty ?? "0")
//                    if temp == "" {
//                        newVal = "1"
//                    }else {
//                        newVal = "\((Int(temp) ?? 0) + 1)"
//                    }
//                }else {
//                    let temp = (updatedValue.price_list?[updatedValue.selectedProduct ?? 0].cart_qty ?? "0")
//                    if temp == "" {
//                        newVal = ""
//                    }else {
//                        newVal = "\((Int(temp) ?? 1) - 1)"
//                    }
//                }
                
                updatedValue.price_list?[updatedValue.selectedProduct ?? 0].cart_qty = self.cartUpdatedQty
                productList[self.selectedIndex] = updatedValue
                self.cartUpdatedQty = ""
                
                if isTableView {
                    self.tblView.reloadRows(at: [IndexPath(row: self.selectedIndex, section: 0)], with: .none)
                }else {
                    self.clctnView.reloadItems(at: [IndexPath(item: self.selectedIndex, section: 0)])
                }
                
                if productList.count == 0 {
                    self.lblCatTitle.text = ""
                    self.tblView.reloadData()
                    self.clctnView.reloadData()
                    self.viewNoRecord.isHidden = false
                }
                
                if let data = response {
                    UserDefaultsManager.setCartCount(count: data.cart_items ?? "")
                    UserDefaultsManager.setCartAmount(amount: data.cart_amount ?? "")
                    self.lblCartCount.text =  data.cart_items ?? ""
                    self.setCartCount()
                }
                NotificationCenter.default.post(name: NSNotification.Name("updateDashboard"), object: nil, userInfo: nil)
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
            
            
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    func didReceiveAddRemoveWishListResponse(response: AddRemoveWishList.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            print(successCode)
            
            if self.removeProduct {
                self.removeProduct = false
                self.productList.remove(at: self.selectedIndex)
                
                if isTableView {
                    self.tblView.reloadData()
                }else {
                    self.clctnView.reloadData()
                }
                
                if productList.count == 0 {
                    self.lblCatTitle.text = ""
                    self.tblView.reloadData()
                    self.clctnView.reloadData()
                    self.viewNoRecord.isHidden = false
                }
            }else {
                var updatedValue = productList[self.selectedIndex]
                var new = ""
                
                if self.favType == "Add" {
                    new = "Yes"
                }else {
                    new = "No"
                }
                updatedValue.wishlist = new
                productList[self.selectedIndex] = updatedValue
                if isTableView {
                    self.tblView.reloadRows(at: [IndexPath(row: self.selectedIndex, section: 0)], with: .none)
                }else {
                    self.clctnView.reloadItems(at: [IndexPath(item: self.selectedIndex, section: 0)])
                }
                NotificationCenter.default.post(name: NSNotification.Name("updateDashboard"), object: nil, userInfo: nil)
            }
            
            
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    func didReceiveBrandListResponse(response: ProductList.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            print(successCode)
            if let data = response {
                self.viewNoRecord.isHidden = true
                
                if self.productData?.cate_list?.count == nil {
                    self.productData = data
                }
                
                self.lblCatTitle.text = "\(data.cate_name ?? "") (\(data.total_product ?? 0) Items )"
                if data.product_list?.count ?? 0 > 0 {
                    if pageCode == 0 {
                        self.productList = data.product_list!
                    }else {
                        self.productList.append(contentsOf: data.product_list!)
                        self.apiCallInprogress = false
                    }
                }
                
                self.tblView.reloadData()
                self.clctnView.reloadData()
                if productList.count == data.total_product ?? 0 {
                    self.nextPageAvailable = false
                }else {
                    self.nextPageAvailable = true
                }
            }else {
                self.lblCatTitle.text = ""
                self.productList.removeAll()
                self.tblView.reloadData()
                self.clctnView.reloadData()
                self.viewNoRecord.isHidden = false
            }
        }else {
            self.lblCatTitle.text = ""
            self.productList.removeAll()
            self.tblView.reloadData()
            self.clctnView.reloadData()
            self.viewNoRecord.isHidden = false
            //self.showTopMessage(message: message, type: .Error)
        }
    }
}


extension WishListViewController : QuatityBoxUpdate {
    
    func quantityChanged(qty: String, productID: String, priceId: String, type: String) {
        let request = AddCart.Request(productId: productID, priceID: priceId, qtyType: type, cartQty: qty)
        self.cartUpdatedQty = qty
        self.interactor?.callAddRemoveApi(request: request)
        self.dismiss(animated: false, completion: nil)
    }
    
}
