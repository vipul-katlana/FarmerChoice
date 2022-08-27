

import UIKit

protocol ProductDetailsDisplayLogic: class {
    func didReceiveProductDetailsResponse(response: ProductDetails.ViewModel?, message: String, successCode: Int)
    func didReceiverelatedProductDetailsResponse(response: RelatedProduct.ViewModel?, message: String, successCode: Int)
    func didReceiveAddRemoveResponse(response: AddCart.ViewModel?, message: String, successCode: Int)
}

class ProductDetailsViewController: BaseViewController {
    var interactor: ProductDetailsBusinessLogic?
    var router: (NSObjectProtocol & ProductDetailsRoutingLogic & ProductDetailsDataPassing)?
    @IBOutlet weak var lblMprTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblSoldOut: UILabel!
    @IBOutlet weak var vwDesc: UIView!
    
    @IBOutlet weak var vwTpConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var clctnView: UICollectionView!
    var productId = ""
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var lblTitleEnglish: UILabel!
    @IBOutlet weak var lblTitleHindi: UILabel!
    @IBOutlet weak var lblOffPercent: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblMainPrice: UILabel!
    @IBOutlet weak var viewAdd: UIView!
    @IBOutlet weak var viewQty: UIView!
    @IBOutlet weak var lblQTY: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    
    @IBOutlet weak var viewCart: UIView!
    @IBOutlet weak var lblCartCount: UILabel!
    
    @IBOutlet weak var imgCart: UIImageView!
    @IBOutlet weak var lblCartAmoount: UILabel!
    @IBOutlet weak var viewCategory: UIView!
    
    @IBOutlet weak var btnAA: UIButton!
    @IBOutlet weak var btMM: UIButton!
    var relatedProduct = [RelatedProduct.CategoryProducts]()
    var responseData: ProductDetails.ViewModel?
    
    var cartType = ""
    var selectedIndex = 999
    var isTop = false
    var favType = ""
    var isRelatedProduct = false
    
    var cartUpdatedQty = ""
    
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
        let interactor = ProductDetailsInteractor()
        let presenter = ProductDetailsPresenter()
        let router = ProductDetailsRouter()
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
        self.setUpLayout()
        
        self.btMM.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        self.btMM.layer.borderWidth = 1
        self.btMM.layer.cornerRadius = 5
        
        self.btnAA.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        self.btnAA.layer.borderWidth = 1
        self.btnAA.layer.cornerRadius = 5
        
        self.viewAdd.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        self.viewAdd.layer.borderWidth = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setCartCount()
    }
    
    func setCartCount() {
        self.viewCart.isHidden = false
        self.lblCartCount.text = UserDefaultsManager.getCartCount()
        self.lblCartAmoount.text = "₹\(UserDefaultsManager.getCartAmount())"
    }
    
    func setUpLayout() {
        let request = ProductDetails.Request(productId: self.productId)
        interactor?.callProductDetailsAPI(request: request)
        self.imgCart.changePngColorTo(color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        self.viewCategory.setBorderWithColor(color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),width: 0.5)
    }
    
    class func instance() -> ProductDetailsViewController? {
        return UIStoryboard(name: "ProductDetails", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController
    }
    
    func setAPIData(data: ProductDetails.ViewModel) {
        self.lblMainTitle.text = data.product?[0].name ?? ""
        self.lblTitleEnglish.text = data.product?[0].name ?? ""
        self.lblTitleHindi.text = data.product?[0].caption ?? ""
        self.lblOffPercent.text = "\(data.product?[0].price_list?[data.product?[0].selectedProduct ?? 0].dis ?? "")% Off"
        
        if (data.product?[0].price_list?[data.product?[0].selectedProduct ?? 0].dis ?? "") == "" || (data.product?[0].price_list?[data.product?[0].selectedProduct ?? 0].dis ?? "") == "0" {
            self.lblOffPercent.isHidden = true
            if lblMprTopConstraint != nil {
                self.lblMprTopConstraint.isActive = false
            }
            
        }else {
            self.lblOffPercent.isHidden = false
            if lblMprTopConstraint != nil {
                self.lblMprTopConstraint.isActive = true
            }
            
        }
        self.lblPrice.text = "₹\(data.product?[0].price_list?[data.product?[0].selectedProduct ?? 0].price ?? "")"
        
        let attrString = NSAttributedString(string: "₹\(data.product?[0].price_list?[data.product?[0].selectedProduct ?? 0].mrp ?? "")", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        lblMainPrice.attributedText = attrString
        
        if (data.product?[0].price_list?[data.product?[0].selectedProduct ?? 0].mrp ?? "") == "" {
            lblMainPrice.isHidden = true
        }else {
            lblMainPrice.isHidden = false
            
        }
        
        self.lblWeight.text = data.product?[0].price_list?[data.product?[0].selectedProduct ?? 0].weight ?? ""
        self.lblDesc.text = data.product?[0].description ?? ""
        if data.product?[0].description ?? "" == "" {
            self.vwDesc.isHidden = true
            if vwTpConstraint != nil {
                self.vwTpConstraint.isActive = false
            }
            
        }else {
            self.vwDesc.isHidden = false
            if vwTpConstraint != nil {
                self.vwTpConstraint.isActive = true
            }
            
        }
        self.imgIcon.setImage(with: "\(data.product?[0].image ?? "")",placeHolder: UIImage(named: "common_Placeholder"))
        self.lblQTY.text = data.product?[0].price_list?[data.product?[0].selectedProduct ?? 0].cart_qty ?? ""
        
        if data.product?[0].sold_out ?? "" == "Yes" {
            self.lblSoldOut.isHidden = false
            self.viewAdd.isHidden = true
            self.viewQty.isHidden = true
        }else {
            self.lblSoldOut.isHidden = true
            if data.product?[0].price_list?[data.product?[0].selectedProduct ?? 0].cart_qty ?? "" == "" || data.product?[0].price_list?[data.product?[0].selectedProduct ?? 0].cart_qty ?? "" == "0" {
                self.viewAdd.isHidden = false
                self.viewQty.isHidden = true
            }else {
                self.viewAdd.isHidden = true
                self.viewQty.isHidden = false
            }
        }
        
        if data.product?[0].price_list?.count == 1 {
            self.viewCategory.isHidden = true
            
        }else {
            self.viewCategory.isHidden = false
        }
        
        if data.product?[0].wishlist == "Yes" {
            self.btnFav.isSelected = true
        }else {
            self.btnFav.isSelected = false
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddQty(_ sender: Any) {
        if GuestUser.isUserGuest {
            self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                if let VC = AuthenticationViewController.instance() {
                    let navVC = UINavigationController(rootViewController: VC)
                    AppConstant.appDelegate.window?.rootViewController = navVC
                }
            }, cancelAction: nil)
        }else {
            self.cartType = "PLUS"
            self.selectedIndex = 999
            //            let request = AddCart.Request(productId:
            //                                            self.responseData?.product?[0].productID ?? "", priceID: self.responseData?.product?[0].price_list?[self.responseData?.product?[0].selectedProduct ?? 0].price_ID ?? "", qtyType: "PLUS", cartQty: "cartQty")
            //            self.interactor?.callAddRemoveApi(request: request)
            
            
            
            if let VC = QuantityBoxViewController.instance() {
                let currProd = QuantityBox(imgProduct: self.responseData?.product?[0].image
                                           ?? "", englishTitle: self.responseData?.product?[0].name ?? "", hindiTitle: self.responseData?.product?[0].caption ?? "", price: "₹\(self.responseData?.product?[0].price_list?[self.responseData?.product?[0].selectedProduct ?? 0].price ?? "")", weight: self.responseData?.product?[0].price_list?[self.responseData?.product?[0].selectedProduct ?? 0].weight ?? "", currentQty: self.responseData?.product?[0].price_list?[self.responseData?.product?[0].selectedProduct ?? 0].cart_qty ?? "",productID: self.responseData?.product?[0].productID ?? "",priceID: self.responseData?.product?[0].price_list?[self.responseData?.product?[0].selectedProduct ?? 0].price_ID ?? "",type: "PLUS", maxQty: (self.responseData?.product?[0].price_list?[self.responseData?.product?[0].selectedProduct ?? 0].maxQty ?? ""))
                VC.currentProduct = currProd
                VC.delegate = self
                VC.modalPresentationStyle = .overCurrentContext
                self.present(VC, animated: false, completion: nil)
            }
        }
        
    }
    
    @IBAction func btnSubQty(_ sender: Any) {
        if GuestUser.isUserGuest {
            self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                if let VC = AuthenticationViewController.instance() {
                    let navVC = UINavigationController(rootViewController: VC)
                    AppConstant.appDelegate.window?.rootViewController = navVC
                }
            }, cancelAction: nil)
        }else {
            self.cartType = "MINUS"
            self.selectedIndex = 999
            let request = AddCart.Request(productId:
                                            self.responseData?.product?[0].productID ?? "", priceID: self.responseData?.product?[0].price_list?[self.responseData?.product?[0].selectedProduct ?? 0].price_ID ?? "", qtyType: "MINUS", cartQty: "cartQty")
            self.interactor?.callAddRemoveApi(request: request)
        }
        
    }
    
    @IBAction func btnAddQuantity(_ sender: Any) {
        if GuestUser.isUserGuest {
            self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                if let VC = AuthenticationViewController.instance() {
                    let navVC = UINavigationController(rootViewController: VC)
                    AppConstant.appDelegate.window?.rootViewController = navVC
                }
            }, cancelAction: nil)
        }else {
            self.cartType = "PLUS"
            self.selectedIndex = 999
//            let request = AddCart.Request(productId:
//                                            self.responseData?.product?[0].productID ?? "", priceID: self.responseData?.product?[0].price_list?[self.responseData?.product?[0].selectedProduct ?? 0].price_ID ?? "", qtyType: "PLUS", cartQty: "cartQty")
//            self.interactor?.callAddRemoveApi(request: request)
            
            
            if let VC = QuantityBoxViewController.instance() {
                let currProd = QuantityBox(imgProduct: self.responseData?.product?[0].image
                                           ?? "", englishTitle: self.responseData?.product?[0].name ?? "", hindiTitle: self.responseData?.product?[0].caption ?? "", price: "₹\(self.responseData?.product?[0].price_list?[self.responseData?.product?[0].selectedProduct ?? 0].price ?? "")", weight: self.responseData?.product?[0].price_list?[self.responseData?.product?[0].selectedProduct ?? 0].weight ?? "", currentQty: self.responseData?.product?[0].price_list?[self.responseData?.product?[0].selectedProduct ?? 0].cart_qty ?? "",productID: self.responseData?.product?[0].productID ?? "",priceID: self.responseData?.product?[0].price_list?[self.responseData?.product?[0].selectedProduct ?? 0].price_ID ?? "",type: "PLUS", maxQty: (self.responseData?.product?[0].price_list?[self.responseData?.product?[0].selectedProduct ?? 0].maxQty ?? ""))
                VC.currentProduct = currProd
                VC.delegate = self
                VC.modalPresentationStyle = .overCurrentContext
                self.present(VC, animated: false, completion: nil)
            }
            
        }
        
    }
    
    @IBAction func btnImageDetails(_ sender: Any) {
        
        if let VC = ImageDetailsViewController.instance() {
            VC.imgStr = self.responseData?.product?[0].image_list?[0].large_image ?? ""
            VC.name = self.lblMainTitle.text ?? ""
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnCheckoutAction(_ sender: Any) {
        self.redirectToCart()
    }
    
    @IBAction func btnCartAction(_ sender: Any) {
        self.redirectToCart()
    }
    
    @IBAction func btncategoryAction(_ sender: Any) {
        if let VC = SearchProductViewController.instance(){
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnDropDownAction(_ sender: Any) {
        if let VC = ProductTypeViewController.instance() {
            self.isTop = true
            VC.modalPresentationStyle = .overCurrentContext
            VC.productDetailsDataArrayTop = self.responseData!
            VC.type = "Productdetailstop"
            VC.cellIndex = 999
            VC.delegateChange = self
            self.present(VC, animated: false, completion: nil)
        }
    }
    
    @IBAction func btnFavAction(_ sender: Any) {
        
        if GuestUser.isUserGuest {
            self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                if let VC = AuthenticationViewController.instance() {
                    let navVC = UINavigationController(rootViewController: VC)
                    AppConstant.appDelegate.window?.rootViewController = navVC
                }
            }, cancelAction: nil)
        }else {
            self.isRelatedProduct = false
            
            if self.responseData?.product?[0].wishlist == "Yes" {
                self.favType = "REMOVE"
                let request = AddRemoveWishList.Request(productId: self.responseData?.product?[0].productID ?? "", pageType: "add_wishlist", wishId: "")
                self.callAddRemoveWishListAPI(request: request)
                
            }else {
                self.favType = "ADD"
                let request = AddRemoveWishList.Request(productId: self.responseData?.product?[0].productID ?? "", pageType: "add_wishlist", wishId: "")
                self.callAddRemoveWishListAPI(request: request)
            }
        }
        
        
    }
    
    func callAddRemoveWishListAPI(request:AddRemoveWishList.Request ) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "whishlist&userID=\(user?.userId ?? "")&page_type=\(request.pageType)&productID=\(request.productId)&whishID=\(request.wishId)"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<AddRemoveWishList.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                if self.isRelatedProduct {
                    var updatedValue = self.relatedProduct[self.selectedIndex]
                    var new = ""
                    
                    if self.favType == "ADD" {
                        new = "Yes"
                    }else {
                        new = "No"
                    }
                    updatedValue.wishlist = new
                    self.relatedProduct[self.selectedIndex] = updatedValue
                    
                    UIView.performWithoutAnimation {
                        self.clctnView.reloadItems(at: [IndexPath(item: self.selectedIndex, section: 0)])
                    }
                    
                }else {
                    let temp = self.responseData
                    var new = ""
                    if self.favType == "ADD" {
                        new = "Yes"
                    }else {
                        new = "No"
                    }
                    temp?.product?[0].wishlist = new
                    self.responseData = temp
                    self.setAPIData(data: temp!)
                }
                
                
            }else {
                
            }
        }
    }
    
}



extension ProductDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return relatedProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailsCollectionViewCell", for: indexPath) as! ProductDetailsCollectionViewCell
        cell.setProductData(data: relatedProduct[indexPath.row])
        
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
                self.isRelatedProduct = true
                if self.relatedProduct[indexPath.row].wishlist ?? "" == "No" {
                    self.favType = "ADD"
                    let request = AddRemoveWishList.Request(productId: self.relatedProduct[indexPath.row].productID ?? "", pageType: "add_wishlist", wishId: "")
                    self.callAddRemoveWishListAPI(request: request)
                }else {
                    self.favType = "REMOVE"
                    let request = AddRemoveWishList.Request(productId: self.relatedProduct[indexPath.row].productID ?? "", pageType: "add_wishlist", wishId: "")
                    self.callAddRemoveWishListAPI(request: request)
                }
            }
            
            
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
                self.cartType = "PLUS"
                self.selectedIndex = indexPath.row
//                let request = AddCart.Request(productId:
//                                                self.relatedProduct[indexPath.row].productID ??  ""
//                                              , priceID: self.relatedProduct[indexPath.row].price_list?[self.relatedProduct[indexPath.row].selectedProduct ?? 0].price_ID ??  "", qtyType: "PLUS", cartQty: "cartQty")
//                self.interactor?.callAddRemoveApi(request: request)
                
                if let VC = QuantityBoxViewController.instance() {
                    let currProd = QuantityBox(imgProduct: self.relatedProduct[indexPath.row].image
                                               ?? "", englishTitle: self.relatedProduct[indexPath.row].name ?? "", hindiTitle: self.relatedProduct[indexPath.row].caption ?? "", price: "₹\(self.relatedProduct[indexPath.row].price_list?[self.relatedProduct[indexPath.row].selectedProduct ?? 0].price ?? "")", weight: self.relatedProduct[indexPath.row].price_list?[self.relatedProduct[indexPath.row].selectedProduct ?? 0].weight ?? "", currentQty: self.relatedProduct[indexPath.row].price_list?[self.relatedProduct[indexPath.row].selectedProduct ?? 0].cart_qty ?? "",productID: self.relatedProduct[indexPath.row].productID ?? "",priceID: self.relatedProduct[indexPath.row].price_list?[self.relatedProduct[indexPath.row].selectedProduct ?? 0].price_ID ?? "",type: "PLUS", maxQty: (self.relatedProduct[indexPath.row].price_list?[self.relatedProduct[indexPath.row].selectedProduct ?? 0].maxQty ?? ""))
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
                let request = AddCart.Request(productId:
                                                self.relatedProduct[indexPath.row].productID ??  ""
                                              , priceID: self.relatedProduct[indexPath.row].price_list?[self.relatedProduct[indexPath.row].selectedProduct ?? 0].price_ID ??  "", qtyType: "MINUS", cartQty: "cartQty")
                self.interactor?.callAddRemoveApi(request: request)
            }
            
        }
        
        
        cell.dropDownClouser = {
            if let VC = ProductTypeViewController.instance() {
                self.isTop = false
                VC.modalPresentationStyle = .overCurrentContext
                VC.productDetailsDataArray = [self.relatedProduct[indexPath.row]]
                VC.type = "Productdetails"
                VC.cellIndex = indexPath.row
                VC.delegateChange = self
                self.present(VC, animated: false, completion: nil)
            }
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((UIScreen.main.bounds.width - 10) / 2.5), height: 320.0)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.productId = self.relatedProduct[indexPath.row].productID  ?? ""
        let request = ProductDetails.Request(productId: self.productId)
        interactor?.callProductDetailsAPI(request: request)
    }
}


extension ProductDetailsViewController: ProductDetailsDisplayLogic {
    func didReceiveProductDetailsResponse(response: ProductDetails.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                self.responseData = data
                let request = RelatedProduct.Request(productId: self.productId)
                interactor?.callRelatedProductDetailsAPI(request: request)
                
                self.setAPIData(data: data)
                
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    func didReceiverelatedProductDetailsResponse(response: RelatedProduct.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                self.relatedProduct = data.category_products!
                self.clctnView.reloadData()
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    
    func didReceiveAddRemoveResponse(response: AddCart.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if response != nil {
                if self.selectedIndex == 999 {
                  //  var newVal = ""
                    var updatedValue = self.responseData?.product?[0]
//                    if cartType == "PLUS" {
//
//                        let temp = (updatedValue?.price_list?[0].cart_qty ?? "")
//                        if temp == "" {
//                            newVal = "1"
//                        }else {
//                            newVal = "\((Int(temp) ?? 0) + 1)"
//                        }
//
//                    }else {
//                        let temp = (updatedValue?.price_list?[0].cart_qty ?? "")
//                        if temp == "" {
//                            newVal = ""
//                        }else {
//                            newVal = "\((Int(temp) ?? 1) - 1)"
//                        }
//                    }
                    
                    updatedValue?.price_list?[0].cart_qty = cartUpdatedQty
                    self.responseData?.product?[0] = updatedValue!
                    self.lblQTY.text = cartUpdatedQty
                    
                   
                    
                    if cartUpdatedQty == "" || cartUpdatedQty == "0" {
                        self.viewAdd.isHidden = false
                        self.viewQty.isHidden = true
                    }else {
                        self.viewAdd.isHidden = true
                        self.viewQty.isHidden = false
                    }
                    
                    cartUpdatedQty = ""
                    
                }else {
                    
                  //  var newVal = ""
                    var updatedValue = self.relatedProduct[self.selectedIndex]
//                    if cartType == "PLUS" {
//
//                        let temp = (updatedValue.price_list?[updatedValue.selectedProduct ?? 0].cart_qty ?? "")
//                        if temp == "" {
//                            newVal = "1"
//                        }else {
//                            newVal = "\((Int(temp) ?? 0) + 1)"
//                        }
//
//                    }else {
//                        let temp = (updatedValue.price_list?[updatedValue.selectedProduct ?? 0].cart_qty ?? "")
//                        if temp == "" {
//                            newVal = ""
//                        }else {
//                            newVal = "\((Int(temp) ?? 1) - 1)"
//                        }
//                    }
                    
                    updatedValue.price_list?[updatedValue.selectedProduct ?? 0].cart_qty = cartUpdatedQty
                    self.relatedProduct[self.selectedIndex] = updatedValue
                    
                    self.clctnView.reloadData()
                    self.cartUpdatedQty = ""
                }
                
                if let data = response {
                    UserDefaultsManager.setCartCount(count: data.cart_items ?? "")
                    UserDefaultsManager.setCartAmount(amount: data.cart_amount ?? "")
                    
                    self.lblCartCount.text = data.cart_items ?? ""
                    self.setCartCount()
                    self.lblCartAmoount.text = "₹\(data.cart_amount ?? "")"
                }
                
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }
        else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    
    
}


extension ProductDetailsViewController: ChangeProductType {
    func change(index: Int,cellIndex: Int) {
        self.dismiss(animated: false, completion: nil)
        
        if cellIndex == 999 {
            let temp = self.responseData
            temp?.product?[0].selectedProduct = index
            self.responseData = temp
            self.setAPIData(data: self.responseData!)
        }else {
            var temp = self.relatedProduct[cellIndex]
            temp.selectedProduct = index
            self.relatedProduct[cellIndex] = temp
            self.clctnView.reloadItems(at: [IndexPath(row: cellIndex, section: 0)])
        }
    }
}


extension ProductDetailsViewController : QuatityBoxUpdate {
    
    func quantityChanged(qty: String, productID: String, priceId: String, type: String) {
        
        self.cartUpdatedQty = qty
        let request = AddCart.Request(productId:
                                        productID, priceID: priceId, qtyType: type, cartQty: qty)
        self.interactor?.callAddRemoveApi(request: request)
        self.dismiss(animated: false, completion: nil)
    }
    
}
