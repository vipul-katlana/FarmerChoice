
import UIKit

protocol OrderStatusRedirection {
    func redirect(apiData: WSResponse<PlaceOrder.ViewModel>?)
}

class OrderSuccessViewController: BaseViewController {
    
    @IBOutlet weak var vwAnimation: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitile: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var vwSuccessButton: UIView!
    @IBOutlet weak var vwFailButton: UIView!
    @IBOutlet weak var btnBottom: UIButton!
    
    var orderSuccess = false
    var titleOrder = ""
    var message = ""
    var isFromPaytm = false
    
    var orderId = ""
    
    var dele : OrderStatusRedirection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.lblTitile.text = self.titleOrder
        self.lblMessage.text = self.message
        
        if isFromPaytm {
            self.btnBottom.setTitle("WALLET HISTORY", for: .normal)
        }
        
        
        if self.orderSuccess {
            self.imgIcon.image = UIImage(named: "payment_Success_new")
            
            if isFromPaytm {
                self.lblTitile.text = "Your Wallet has been updated"
                self.lblMessage.text = "Money added successfully"
            }else {
                self.lblTitile.text = "Your Order has been accepted"
                self.lblMessage.text = "Your items has been placed and is on it’s way to being processed"
            }
           
            
            self.vwSuccessButton.isHidden = false
            self.vwFailButton.isHidden = true
            
        }else {
            self.imgIcon.image = UIImage(named: "payment_falli_new")
            
            if isFromPaytm {
                self.lblTitile.text = "Your payment has been failed"
                self.lblMessage.text = "Please try again"
            }else {
                self.lblTitile.text = "Your Order has been failed"
                self.lblMessage.text = "Please try again after adding product in your cart"
            }
            
            
        }
        
        if !isFromPaytm {
            if self.orderSuccess {
                self.vwSuccessButton.isHidden = false
                self.vwFailButton.isHidden = true
            }else {
                self.vwSuccessButton.isHidden = true
                self.vwFailButton.isHidden = false
            }
        }else {
            self.vwSuccessButton.isHidden = false
            self.vwFailButton.isHidden = true
        }
        
    }
    
    class func instance() -> OrderSuccessViewController? {
        return UIStoryboard(name: "OrderSuccess", bundle: nil).instantiateViewController(withIdentifier: "OrderSuccessViewController") as? OrderSuccessViewController
    }
    
    @IBAction func btnOrderHistoryAction(_ sender: Any) {
        if isFromPaytm {
            GlobalUtility.shared.paytmMoneyAdd = true
            AppConstant.appDelegate.setRootViewController()
        }else {
            AppConstant.appDelegate.setRootViewController()
        }
        
    }
    
    @IBAction func btnCancelOrderACtion(_ sender: Any) {
        self.callOrderCancelAPI()
    }
    
    @IBAction func bbtnRetryPaymentAction(_ sender: Any) {
        self.callRetryPaymentAPI()
    }
    
}


extension OrderSuccessViewController {
    
    func callOrderCancelAPI() {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "order_list&userID=\(user?.userId ?? "")&page=cancel_order&orderID=\(self.orderId)"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<CancelOrder.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                if detail.status == "0" {
                    self.showTopMessage(message: detail.message ?? "", type: .Success)
                    GlobalUtility.shared.OrderSuccess = true
                    AppConstant.appDelegate.setRootViewController()
                }else {
                    self.showTopMessage(message: detail.message ?? "", type: .Error)
                    AppConstant.appDelegate.setRootViewController()
                }
                
            }else {
                self.showTopMessage(message: response?.message ?? "", type: .Error)
                AppConstant.appDelegate.setRootViewController()
            }
        }
    }
    
    func callRetryPaymentAPI() {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "order_repayment&userID=\(user?.userId ?? "")&orderMasterID=\(self.orderId)&type1=razorpay"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<PlaceOrder.ViewModel>?, message: String?, successCode: Int?) in
            self.dele?.redirect(apiData: response)
        }
        
        
    }
}
