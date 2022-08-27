
import UIKit

class DashBoardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewImageBanner: UIView!
    @IBOutlet weak var imgIocn: UIImageView!
    @IBOutlet weak var clctnBanner: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var clctnView: UICollectionView!
    @IBOutlet weak var vwOfferList: UIView!
    @IBOutlet weak var clctnOfferList: UICollectionView!
    
    @IBOutlet weak var vwOldDesign: UIView!
    @IBOutlet weak var vwOldHeader: UIView!
    var data = [DashBoardList.Category_products]()
    var bannerData = [DashBoardList.OfferBanner]()
    
    var newcatdata = [DashBoardList.SubCategoryList]()
    
    var offerArray = [DashBoard.Offer_banner]()
    
    var viewClouser: (()->())?
    var favType = ""
    var cartType = ""
    var selectedIndex = 999
    var cartDelegate: AddCartQty?
    
    var redirectDele: RedirectToDetails?
    var catDelegate: RedirectToCat?
    
    var cartUpdatedQty = ""
    
    @IBOutlet weak var vwNewDesign: UIView!
    @IBOutlet weak var llNewDesignTitle: UILabel!
    @IBOutlet weak var clctnNewDesign: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clctnView.delegate = self
        self.clctnView.dataSource = self
        self.clctnBanner.delegate = self
        self.clctnBanner.dataSource = self
        
        self.clctnNewDesign.delegate = self
        self.clctnNewDesign.dataSource = self
        
        self.clctnOfferList.delegate = self
        self.clctnOfferList.dataSource = self
        
    }
    
    func setData(data: DashBoardList.Home_category_products) {
        self.vwOfferList.isHidden = true
        self.vwOldDesign.isHidden = false
        self.vwOldHeader.isHidden = false
        self.vwNewDesign.isHidden = true
        self.lblTitle.text = data.category_name ?? ""
        self.data = data.category_products!
        self.clctnView.reloadData()
        self.clctnBanner.reloadData()
        
        if data.category_banner ?? "" == "" {
            self.viewImageBanner.isHidden = true
        }else {
            self.viewImageBanner.isHidden = false
            self.imgIocn.setImage(with: "\(data.category_banner ?? "")",placeHolder: UIImage(named: ""))
        }
    }
    
    
    func setNewDesign(data: DashBoardList.categoy_master_listArray) {
        self.vwOfferList.isHidden = true
        self.vwNewDesign.isHidden = false
        self.viewImageBanner.isHidden = true
        self.vwOldDesign.isHidden = true
        self.vwOldHeader.isHidden = true
        self.llNewDesignTitle.text = data.category_name ?? ""
        if let tm = data.sub_category_list {
            self.newcatdata = tm
        }
        self.clctnNewDesign.reloadData()
    }
    
    
    func setOfferData(data: [DashBoard.Offer_banner]) {
        self.vwOfferList.isHidden = false
        self.vwNewDesign.isHidden = true
        self.viewImageBanner.isHidden = true
        self.vwOldDesign.isHidden = true
        self.vwOldHeader.isHidden = true
        self.offerArray = data
        self.clctnOfferList.reloadData()
    }
    
    @IBAction func btnViewAllAction(_ sender: Any) {
        if viewClouser != nil {
            viewClouser!()
        }
    }
    
}

extension DashBoardTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clctnView {
            return data.count
        }else if collectionView == clctnNewDesign {
            return newcatdata.count
        }else if collectionView == clctnOfferList {
            return offerArray.count
        }
        else {
            return 3
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == clctnView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailsCollectionViewCell", for: indexPath) as! ProductDetailsCollectionViewCell
            cell.setData(data: data[indexPath.row])
            
            cell.addFavClouser = {
                if GuestUser.isUserGuest {
                    let topVC = GlobalUtility.shared.currentTopViewController()
                    topVC.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                        if let VC = AuthenticationViewController.instance() {
                            let navVC = UINavigationController(rootViewController: VC)
                            AppConstant.appDelegate.window?.rootViewController = navVC
                        }
                    }, cancelAction: nil)
                }else {
                    if self.data[indexPath.row].wishlist == "No" {
                        self.favType = "ADD"
                        self.selectedIndex = indexPath.row
                        let request = AddRemoveWishList.Request(productId: self.data[indexPath.row].productID ?? "", pageType: "add_wishlist", wishId: "")
                        self.callAddRemoveWishListAPI(request: request)
                        
                    }else {
                        self.favType = "REMOVE"
                        self.selectedIndex = indexPath.row
                        let request = AddRemoveWishList.Request(productId: self.data[indexPath.row].productID ?? "", pageType: "add_wishlist", wishId: "")
                        self.callAddRemoveWishListAPI(request: request)
                    }
                }
                
            }
            
            cell.addClouser = {
                if GuestUser.isUserGuest {
                    let topVC = GlobalUtility.shared.currentTopViewController()
                    topVC.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                        if let VC = AuthenticationViewController.instance() {
                            let navVC = UINavigationController(rootViewController: VC)
                            AppConstant.appDelegate.window?.rootViewController = navVC
                        }
                    }, cancelAction: nil)
                }else {
                    
                    self.cartType = "PLUS"
                    self.selectedIndex = indexPath.row
                    
//                    let request = AddCart.Request(productId: self.data[indexPath.row].productID ?? "", priceID: self.data[indexPath.row].price_list?[self.data[indexPath.row].selectedProduct ?? 0].price_ID ?? "", qtyType: "PLUS", cartQty: "cartQty")
//                    self.callAddRemoveAPI(request: request)
//
                    
                    if let VC = QuantityBoxViewController.instance() {
                        let currProd = QuantityBox(imgProduct: self.data[indexPath.row].image ?? "", englishTitle: self.data[indexPath.row].name ?? "", hindiTitle: self.data[indexPath.row].caption ?? "", price: "₹\(self.data[indexPath.row].price_list?[self.data[indexPath.row].selectedProduct ?? 0].price ?? "")", weight: self.data[indexPath.row].price_list?[self.data[indexPath.row].selectedProduct ?? 0].weight ?? "", currentQty: self.data[indexPath.row].price_list?[self.data[indexPath.row].selectedProduct ?? 0].cart_qty ?? "",productID: self.data[indexPath.row].productID ?? "",priceID: self.data[indexPath.row].price_list?[self.data[indexPath.row].selectedProduct ?? 0].price_ID ?? "",type: "PLUS", maxQty: (self.data[indexPath.row].price_list?[self.data[indexPath.row].selectedProduct ?? 0].maxQty ?? ""))
                        VC.currentProduct = currProd
                        //VC.delegate = self
                        VC.modalPresentationStyle = .overCurrentContext
                        if let topVC = GlobalUtility.shared.currentTopViewController() as? UIViewController {
                            VC.delegate = self
                            topVC.present(VC, animated: false, completion: nil)
                        }
                    }
                    
                    
                }
                
            }
            
            cell.removeClouser = {
                
                if GuestUser.isUserGuest {
                    let topVC = GlobalUtility.shared.currentTopViewController()
                    topVC.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                        if let VC = AuthenticationViewController.instance() {
                            let navVC = UINavigationController(rootViewController: VC)
                            AppConstant.appDelegate.window?.rootViewController = navVC
                        }
                    }, cancelAction: nil)
                }else {
                    self.cartType = "MINUS"
                    self.selectedIndex = indexPath.row
                    
                    let request = AddCart.Request(productId: self.data[indexPath.row].productID ?? "", priceID: self.data[indexPath.row].price_list?[self.data[indexPath.row].selectedProduct ?? 0].price_ID ?? "", qtyType: "MINUS", cartQty: "cartQty")
                    self.callAddRemoveAPI(request: request)
                }
                
            }
            
            cell.dropDownClouser = {
                if GuestUser.isUserGuest {
                    let topVC = GlobalUtility.shared.currentTopViewController()
                    topVC.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                        if let VC = AuthenticationViewController.instance() {
                            let navVC = UINavigationController(rootViewController: VC)
                            AppConstant.appDelegate.window?.rootViewController = navVC
                        }
                    }, cancelAction: nil)
                }else {
                    if let VC = ProductTypeViewController.instance() {
                        VC.modalPresentationStyle = .overCurrentContext
                        VC.dashBoardArray = self.data[indexPath.row]
                        VC.type = "dashboard"
                        VC.cellIndex = indexPath.row
                        VC.delegateChange = self
                        UIApplication.shared.keyWindow?.rootViewController?.present(VC, animated: false, completion: nil)
                    }
                }
            }
            return cell
        }
        else if collectionView == clctnNewDesign {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CateegoryCollectionViewCell", for: indexPath) as! CateegoryCollectionViewCell
            cell.imgIcon.setImage(with: newcatdata[indexPath.row].image ?? "")
            cell.lbblTitle.text = newcatdata[indexPath.row].category_name ?? ""
            cell.vwG.setShadow()
            return cell
        }else if collectionView == clctnOfferList {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCollectionViewCell", for: indexPath) as! DashboardCollectionViewCell
            cell.imgIcon.setImage(with: offerArray[indexPath.row].image ?? "")
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashBoardTabelCollectionViewCell", for: indexPath) as! DashBoardTabelCollectionViewCell
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == clctnNewDesign {
            return CGSize(width: (self.clctnNewDesign.frame.width / 3), height: self.clctnNewDesign.frame.height)
        }else if collectionView == clctnOfferList {
            return CGSize(width: (self.clctnOfferList.frame.width / 1), height: self.clctnOfferList.frame.height)
        }
        else {
            if collectionView != clctnView  {
                return CGSize(width: (100.0), height: 100.0)
            }else {
                return CGSize(width: ((clctnView.frame.width - 15)/2.2), height: clctnView.frame.height)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == clctnView {
            self.redirectDele?.redirect(id: self.data[indexPath.row].productID ?? "")
        }
        
        if collectionView == clctnOfferList {
            self.catDelegate?.redirectCat(id: self.offerArray[indexPath.row].catID ?? "")
        }
        
        
        
        if collectionView == clctnNewDesign {
            self.catDelegate?.redirectCat(id: self.newcatdata[indexPath.row].catID ?? "")
        }
    }
}





extension DashBoardTableViewCell {
    
    func callAddRemoveAPI(request:AddCart.Request) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "cart&userID=\(user?.userId ?? "")&page_type=add_item_cart&productID=\(request.productId)&priceID=\(request.priceID)&qty_type=\(request.qtyType)&cityID=\(UserDefaultsManager.getCityId())&cartQty=\(request.cartQty)"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<AddCart.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                if detail.dictData != nil {
                    var updatedValue = self.data[self.selectedIndex]
                    var newVal = ""
//                    if self.cartType == "PLUS" {
//                        let temp = (updatedValue.price_list?[updatedValue.selectedProduct ?? 0].cart_qty ?? "0")
//                        if temp == "" {
//                            newVal = "1"
//                        }else {
//                            newVal = "\((Int(temp) ?? 0) + 1)"
//                        }
//                    }else {
//                        let temp = (updatedValue.price_list?[updatedValue.selectedProduct ?? 0].cart_qty ?? "0")
//                        if temp == "" {
//                            newVal = ""
//                        }else {
//                            newVal = "\((Int(temp) ?? 1) - 1)"
//                        }
//                    }
                    
                    updatedValue.price_list?[updatedValue.selectedProduct ?? 0].cart_qty = self.cartUpdatedQty
                    self.data[self.selectedIndex] = updatedValue
                    self.cartUpdatedQty = ""
                    UIView.performWithoutAnimation {
                        self.clctnView.reloadItems(at: [IndexPath(item: self.selectedIndex, section: 0)])
                    }
                    
                    
                    UserDefaultsManager.setCartCount(count: detail.dictData?.cart_items ?? "")
                    UserDefaultsManager.setCartAmount(amount: detail.dictData?.cart_amount ?? "")
                    self.cartDelegate?.updateQty()
                }else {
                    GlobalUtility.shared.currentTopViewController().showTopMessage(message: "Stock Not Available.", type: .Error)
                }
                
            }else {
            }
        }
    }
    
    func callAddRemoveWishListAPI(request:AddRemoveWishList.Request ) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "whishlist&userID=\(user?.userId ?? "")&page_type=\(request.pageType)&productID=\(request.productId)&whishID=\(request.wishId)"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<AddRemoveWishList.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                var updatedValue = self.data[self.selectedIndex]
                var new = ""
                
                if self.favType == "ADD" {
                    new = "Yes"
                }else {
                    new = "No"
                }
                updatedValue.wishlist = new
                self.data[self.selectedIndex] = updatedValue
                
                UIView.performWithoutAnimation {
                    self.clctnView.reloadItems(at: [IndexPath(item: self.selectedIndex, section: 0)])
                }
                
            }else {
                
            }
        }
    }
}


extension DashBoardTableViewCell: ChangeProductType {
    func change(index: Int,cellIndex: Int) {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        var temp = self.data[cellIndex]
        temp.selectedProduct = index
        self.data[cellIndex] = temp
        
        UIView.performWithoutAnimation {
            self.clctnView.reloadItems(at: [IndexPath(row: cellIndex, section: 0)])
        }
        
        
    }
    
    
}


extension DashBoardTableViewCell: QuatityBoxUpdate {
    func quantityChanged(qty: String, productID: String, priceId: String, type: String) {
        self.cartUpdatedQty = qty
        let request = AddCart.Request(productId: productID, priceID: priceId, qtyType: type, cartQty: qty)
        self.callAddRemoveAPI(request: request)
        
        
    }
    
    
}
