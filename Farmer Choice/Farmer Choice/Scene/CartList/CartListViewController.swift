
import UIKit
import Lottie
import SJSwiftSideMenuController

protocol CartListDisplayLogic: class {
    func didReceiveCartListResponse(response: CartList.ViewModel?, message: String, successCode: Int)
    func didReceiveAddRemoveResponse(response: AddCart.ViewModel?, message: String, successCode: Int)
    func didReceiveDeteleItemResponse(response: AddCart.ViewModel?, message: String, successCode: Int)
    func didReceiveClearCartResponse(response: AddCart.ViewModel?, message: String, successCode: Int)
    
}

class CartListViewController: BaseViewController {
    var interactor: CartListBusinessLogic?
    var router: (NSObjectProtocol & CartListRoutingLogic & CartListDataPassing)?
    
    @IBOutlet weak var viewNorecord: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var imgCart: UIImageView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblSavePrice: UILabel!
    @IBOutlet weak var viewSpclInst: UIView!
    @IBOutlet weak var txtViewSpecialInst: UITextView!
    @IBOutlet weak var lblSpecialInst: UILabel!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblAboveMessage: UILabel!
    
    @IBOutlet weak var tblHeightCons: NSLayoutConstraint!
    var cartData = [CartList.CartItemList]()
    var selectedIndex = 0
    var cartType = ""
    
    var updateCart = false
    var minCartValue = 0.0
    var minLabelShow = false
    
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
        let interactor = CartListInteractor()
        let presenter = CartListPresenter()
        let router = CartListRouter()
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
        interactor?.callCartListApi()
        // self.imgCart.changePngColorTo(color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        self.viewSpclInst.setBorderWithColor(color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.4009683099))
        self.lblAmount.text = "₹\(UserDefaultsManager.getCartAmount())"
        self.lblSavePrice.text = "\(UserDefaultsManager.getCartCount()) Item"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //self.tblHeightCons.constant = UIScreen.main.bounds.height - 293.0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
    class func instance() -> CartListViewController? {
        return UIStoryboard(name: "CartList", bundle: nil).instantiateViewController(withIdentifier: "CartListViewController") as? CartListViewController
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let _ = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                self.bottomConstraint.constant =  0
                UIView.animate(withDuration: 0.25, animations: { () -> Void in self.view.layoutIfNeeded() })
            }
        }
    }
    @objc func keyboardWillShow(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                self.bottomConstraint.constant = keyboardHeight
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @IBAction func btnStartShoppingAction(_ sender: Any) {
        self.redirectToHome()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEmptyCartAction(_ sender: Any) {
        self.displayAlert(msg: "Are you sure you want to empty cart?", ok: "Yes", cancel: "No", okAction: {
            self.interactor?.callClearCartApi()
            
        }, cancelAction: nil)
    }
    
    @IBAction func btnPlaceOrderAction(_ sender: Any) {
        
        if self.cartData.count > 0 {
            let checkObject = self.cartData.filter{$0.item_notes != ""}
            if checkObject.count > 0 {
                self.showTopMessage(message: "Please update/remover product in cart", type: .Error)
            }else {
                if let VC = DeliveryAddressViewController.instance() {
                    VC.spclInst = self.txtViewSpecialInst.text ?? ""
                    self.navigationController?.pushViewController(VC, animated: true)
                }
            }
        }else {
            self.showTopMessage(message: "Please add product in cart", type: .Error)
        }
    }
    
    @IBAction func btnMessageTappedAction(_ sender: Any) {
        if let VC = CategoryViewController.instance() {
            SJSwiftSideMenuController.pushViewController(VC, animated: true)
        }
    }
}

extension CartListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartListTableViewCell", for: indexPath) as! CartListTableViewCell
        cell.setData(data: self.cartData[indexPath.row])
        
        cell.addClouser = {
            self.selectedIndex = indexPath.row
            self.cartType = "PLUS"
//            let request = CartList.Request(cartID: self.cartData[indexPath.row].cartID ?? "", type: "PLUS")
//            self.interactor?.callAddRemoveApi(request: request)
            
            
            if let VC = QuantityBoxViewController.instance() {
                let currProd = QuantityBox(imgProduct: self.cartData[indexPath.row].cart_image ?? "", englishTitle: self.cartData[indexPath.row].product_name ?? "", hindiTitle: self.cartData[indexPath.row].product_information ?? "", price: "₹\(self.cartData[indexPath.row].product_price ?? "")", weight: self.cartData[indexPath.row].weight ?? "", currentQty: self.cartData[indexPath.row].product_qty ?? "",productID: self.cartData[indexPath.row].cartID ?? "",priceID: "",type: "PLUS",maxQty: "\(self.cartData[indexPath.row].maxQty ?? 0)")
                VC.currentProduct = currProd
                VC.delegate = self
                VC.modalPresentationStyle = .overCurrentContext
                self.present(VC, animated: false, completion: nil)
            }
            
            
        }
        
        cell.removeClouser = {
            if Int(self.cartData[indexPath.row].product_qty ?? "") ?? 0 > 1 {
                self.cartType = "MINUS"
                self.selectedIndex = indexPath.row
                let request = CartList.Request(cartID: self.cartData[indexPath.row].cartID ?? "", type: "MINUS", qty: "")
                self.interactor?.callAddRemoveApi(request: request)
            }
            
        }
        
        cell.deleteClouser = {
            self.selectedIndex = indexPath.row
            self.displayAlert(msg: "Are you sure you want to remove this product?", ok: "Yes", cancel: "No", okAction: {
                let request = CartList.Request(cartID: self.cartData[indexPath.row].cartID ?? "", type: "", qty: "")
                self.interactor?.callDeleteItemApi(request: request)
                
            }, cancelAction: nil)
        }
        
        
        cell.productRemoveClouser = {
            self.selectedIndex = indexPath.row
            if (self.cartData[indexPath.row].btn_name ?? "") == "Remove"{
                let request = CartList.Request(cartID: self.cartData[indexPath.row].cartID ?? "", type: "", qty: "")
                self.interactor?.callDeleteItemApi(request: request)
            }else {
                self.cartType = "PLUS"
                self.updateCart = true
                let request = CartList.Request(cartID: self.cartData[indexPath.row].cartID ?? "", type: "UPDATE", qty: "")
                self.interactor?.callAddRemoveApi(request: request)
            }
            
        }
        return cell
    }
    
}


extension CartListViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        lblSpecialInst.isHidden = !txtViewSpecialInst.text.isEmpty
    }
}

extension CartListViewController: CartListDisplayLogic {
    func didReceiveCartListResponse(response: CartList.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                UserDefaultsManager.setCartCount(count: data.cart_items ?? "")
                UserDefaultsManager.setCartAmount(amount: data.cart_amount ?? "")
                self.lblAmount.text = "₹\(UserDefaultsManager.getCartAmount())"
                self.lblSavePrice.text = "\(UserDefaultsManager.getCartCount()) Item"
                self.cartData = data.cart_items_list!
                self.tblView.reloadData()
                
                self.minCartValue = Double(data.area_min_order ?? "") ?? 0.0
                if data.area_ship_charge_msg ?? "" != "" {
                    self.lblAboveMessage.isHidden = false
                    self.minLabelShow = true
                    self.lblAboveMessage.text = data.area_ship_charge_msg ?? ""
                    let tm = self.minCartValue - (Double(data.cart_amount ?? "") ?? 0.0)
                    if tm > 0 {
                        self.lblAboveMessage.text = "Shope more of ₹\(String(format: "%.2f", tm)) to get free delivery"
                    }else {
                        self.lblAboveMessage.text =  ""
                    }
                }else {
                    self.lblAboveMessage.isHidden = true
                }
            }else {
                self.viewNorecord.isHidden = false
                
            }
        }else {
            //self.showTopMessage(message: message, type: .Error)
            self.viewNorecord.isHidden = false
        }
    }
    
    func didReceiveAddRemoveResponse(response: AddCart.ViewModel?, message: String, successCode: Int) {
        
        if successCode == 0 {
            if let resData = response {
                NotificationCenter.default.post(name: NSNotification.Name("updateDashboard"), object: nil, userInfo: nil)
                var updatedValue = self.cartData[self.selectedIndex]
               // var newVal = ""
                
                if updateCart {
                    self.updateCart = false
                    updatedValue.line_total = resData.product_line_total ?? ""
                    updatedValue.item_notes = ""
                    updatedValue.product_price = resData.product_line_single ?? ""
                    cartData[self.selectedIndex] = updatedValue
                }else {
//                    if self.cartType == "PLUS" {
//                        let temp = (updatedValue.product_qty ?? "0")
//                        if temp == "" {
//                            newVal = "1"
//                        }else {
//                            newVal = "\((Int(temp) ?? 0) + 1)"
//                        }
//                    }else {
//                        let temp = (updatedValue.product_qty ?? "0")
//                        if temp == "" {
//                            newVal = ""
//                        }else {
//                            newVal = "\((Int(temp) ?? 1) - 1)"
//                        }
//                    }
                    
                    updatedValue.line_total = resData.product_line_total ?? ""
                    updatedValue.product_qty = cartUpdatedQty
                    updatedValue.product_price = resData.product_line_single ?? ""
                    cartData[self.selectedIndex] = updatedValue
                    cartUpdatedQty = ""
                }
                
                
                self.tblView.reloadData()
                
                UserDefaultsManager.setCartCount(count: resData.cart_items ?? "")
                UserDefaultsManager.setCartAmount(amount: resData.cart_amount ?? "")
                
                
                self.lblAmount.text = "₹\(resData.cart_amount ?? "")"
                self.lblSavePrice.text = "\(resData.cart_items ?? "") Item"
                
                if minCartValue > 0.0 {
                    let tm = minCartValue - (Double(resData.cart_amount ?? "") ?? 0.0)
                    if tm > 0 {
                        self.lblAboveMessage.isHidden = false
                        self.lblAboveMessage.text = "Shope more of ₹\((String(format: "%.2f", tm))) to get free delivery"
                    }else {
                        self.lblAboveMessage.text =  ""
                    }
                }
                
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
            
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    
    func didReceiveDeteleItemResponse(response: AddCart.ViewModel?, message: String, successCode: Int) {
        
        if successCode == 0 {
            if let resData = response {
                NotificationCenter.default.post(name: NSNotification.Name("updateDashboard"), object: nil, userInfo: nil)
                self.cartData.remove(at: selectedIndex)
                self.tblView.reloadData()
                UserDefaultsManager.setCartCount(count: resData.cart_items ?? "")
                UserDefaultsManager.setCartAmount(amount: resData.cart_amount ?? "")
                self.lblAmount.text = "₹ \(resData.cart_amount ?? "")"
                self.lblSavePrice.text = "\(resData.cart_items ?? "") Item"
                
                
                if minCartValue > 0.0 {
                    let tm = minCartValue - (Double(resData.cart_amount ?? "") ?? 0.0)
                    if tm > 0 {
                        self.lblAboveMessage.isHidden = false
                        self.lblAboveMessage.text = "Shope more of ₹\((String(format: "%.2f", tm))) to get free delivery"
                    }else {
                        self.lblAboveMessage.text =  ""
                    }
                }
                
                
                if cartData.count == 0 {
                    self.viewNorecord.isHidden = false
                }else {
                    self.viewNorecord.isHidden = true
                }
                
            }
            else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    func didReceiveClearCartResponse(response: AddCart.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                NotificationCenter.default.post(name: NSNotification.Name("updateDashboard"), object: nil, userInfo: nil)
                UserDefaultsManager.setCartCount(count: data.cart_items ?? "")
                UserDefaultsManager.setCartAmount(amount: data.cart_amount ?? "")
                self.showTopMessage(message: message, type: .Success)
                self.viewNorecord.isHidden = false
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
}


extension CartListViewController : QuatityBoxUpdate {
    
    func quantityChanged(qty: String, productID: String, priceId: String, type: String) {
        if qty == "0" {
            let request = CartList.Request(cartID: productID, type: "", qty: "")
            self.interactor?.callDeleteItemApi(request: request)
            self.dismiss(animated: false, completion: nil)
        }else {
            self.cartUpdatedQty = qty
            let request = CartList.Request(cartID: productID, type: type,qty: qty)
            self.interactor?.callAddRemoveApi(request: request)
            self.dismiss(animated: false, completion: nil)
        }
        
    }
    
}
