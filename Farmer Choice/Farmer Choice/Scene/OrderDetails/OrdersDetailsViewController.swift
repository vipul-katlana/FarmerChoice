
import UIKit

protocol SendFeedBack {
    func success()
}

protocol OrdersDetailsDisplayLogic: class {
    func didReceiveOrderDetails(response: OrdersDetails.ViewModel?, message: String, successCode: Int)
    
    func didReceiveReOrder(response: ReOrder.ViewModel?, message: String, successCode: Int)
}

class OrdersDetailsViewController: BaseViewController {
    var interactor: OrdersDetailsBusinessLogic?
    var router: (NSObjectProtocol & OrdersDetailsRoutingLogic & OrdersDetailsDataPassing)?
    
    var orderId = ""
    @IBOutlet weak var lblOtherText: UILabel!
    @IBOutlet weak var lblDiscountText: UILabel!
    
    @IBOutlet weak var lblSubTotalText: UILabel!
    
    @IBOutlet weak var btnreorder: UIButton!
    @IBOutlet weak var viewDiscount: UIView!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblDeliveryTime: UILabel!
    @IBOutlet weak var lblYouHavetoPay: UILabel!
    @IBOutlet weak var lblItemAmount: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblDeliveryCharge: UILabel!
    @IBOutlet weak var lblTotalPayableAmount: UILabel!
    @IBOutlet weak var lblDeliveryAddress: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewTrack: UIView!
    @IBOutlet weak var imgFirst: UIImageView!
    @IBOutlet weak var imgFirstLine: UIImageView!
    @IBOutlet weak var imgSecond: UIImageView!
    @IBOutlet weak var imgSecondNew: UIImageView!
    @IBOutlet weak var imgSecondLine: UIImageView!
    @IBOutlet weak var imgThird: UIImageView!
    @IBOutlet weak var imgThirdNew: UIImageView!
    @IBOutlet weak var imgThirdLine: UIImageView!
    @IBOutlet weak var imgFourth: UIImageView!
    @IBOutlet weak var imgFourthLine: UIImageView!
    
    @IBOutlet weak var lblNewCodTitle: UILabel!
    
    @IBOutlet weak var viewFeedback: UIView!
    
    @IBOutlet weak var viewSupport: UIView!
    
    @IBOutlet weak var viewCancel: UIView!
    
    var productList = [OrdersDetails.ProductsList]()
    
    
    
    
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
        let interactor = OrdersDetailsInteractor()
        let presenter = OrdersDetailsPresenter()
        let router = OrdersDetailsRouter()
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
    }
    
    func setUpLayout() {
        //120 + 50
        //self.heightConstraint.constant = CGFloat((120 * 5) + 50)
        let request = OrdersDetails.Request(orderId: self.orderId)
        interactor?.callOrderDetailsAPI(request: request)
        
        
        viewSupport.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        viewSupport.layer.borderWidth = 1
        
        viewCancel.layer.borderColor = UIColor.red.cgColor
        viewCancel.layer.borderWidth = 1
        
    }
    
    class func instance() -> OrdersDetailsViewController? {
        return UIStoryboard(name: "OrderDetails", bundle: nil).instantiateViewController(withIdentifier: "OrdersDetailsViewController") as? OrdersDetailsViewController
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setImages(status: String) {
        if status == "Placed" {
            self.imgFirstLine.image = UIImage(named: "order_check")
            self.imgFirst.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgSecondLine.image = UIImage(named: "order_Uncheck")
            self.imgSecond.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgSecondNew.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgThirdLine.image = UIImage(named: "order_Uncheck")
            self.imgThird.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgThirdNew.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgFourthLine.image = UIImage(named: "order_Uncheck")
            self.imgFourth.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.viewTrack.isHidden = false
            
        }else if status == "Confirmed" {
            self.imgFirstLine.image = UIImage(named: "order_check")
            self.imgFirst.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgSecondLine.image = UIImage(named: "order_check")
            self.imgSecond.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgSecondNew.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgThirdLine.image = UIImage(named: "order_Uncheck")
            self.imgThird.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgThirdNew.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgFourthLine.image = UIImage(named: "order_Uncheck")
            self.imgFourth.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.viewTrack.isHidden = false
            
        }else if status == "OnDelivery" {
            self.imgFirstLine.image = UIImage(named: "order_check")
            self.imgFirst.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgSecondLine.image = UIImage(named: "order_check")
            self.imgSecond.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgSecondNew.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgThirdLine.image = UIImage(named: "order_check")
            self.imgThird.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgThirdNew.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgFourthLine.image = UIImage(named: "order_Uncheck")
            self.imgFourth.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.viewTrack.isHidden = false
            
        }else if status == "Delivered" {
            self.imgFirstLine.image = UIImage(named: "order_check")
            self.imgFirst.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgSecondLine.image = UIImage(named: "order_check")
            self.imgSecond.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgSecondNew.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgThirdLine.image = UIImage(named: "order_check")
            self.imgThird.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgThirdNew.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgFourthLine.image = UIImage(named: "order_check")
            self.imgFourth.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.viewTrack.isHidden = false
        }
    }
    
    @IBAction func btnFeedBackAction(_ sender: Any) {
        if let VC = FeedBackViewController.instance() {
            VC.modalPresentationStyle = .fullScreen
            VC.delegateFeedBack = self
            VC.orderId = self.orderId
            self.present(VC, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btnSupportAction(_ sender: Any) {
        if let VC = ContactUsViewController.instance() {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnCancelAction(_ sender: Any) {
        self.displayAlert(msg: "Are you sure you want to cancel?", ok: "Yes", cancel: "No", okAction: {
            //call API
            self.callOrderCancelAPI()
        }, cancelAction: nil)
    }
    
    @IBAction func btnreorderCTION(_ sender: Any) {
        self.displayAlert(msg: "Are you sure you want to reorder?", ok: "Yes", cancel: "No", okAction: {
            let id = self.orderId
            let request = ReOrder.Request(orderId: String(id.dropFirst()))
            self.interactor?.callReOrderAPI(request: request)
        }, cancelAction: nil)
    }
}


extension OrdersDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailsTableViewCell", for: indexPath) as! OrderDetailsTableViewCell
        cell.setData(data: productList[indexPath.row])
        return cell
    }
    
    
}

extension OrdersDetailsViewController: OrdersDetailsDisplayLogic {
    func didReceiveOrderDetails(response: OrdersDetails.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            print(successCode)
            if let data = response {
                self.heightConstraint.constant = CGFloat((120 * (data.products_list?.count ?? 0)) + 50)
                self.productList = data.products_list!
                self.lblOrderDate.text = data.order_date ?? ""
                self.lblDeliveryTime.text = data.delivery_time_data ?? ""
                self.lblYouHavetoPay.text = data.pay_text ?? ""
                self.lblNewCodTitle.text = data.pay_label ?? ""
                self.lblItemAmount.text = "\(data.item ?? "") Amount ₹\(data.item_amount ?? "")"
                
                if data.final_total_data?.count ?? 0 > 0 {
                    self.lblSubTotal.text = "₹\(data.final_total_data?[0].amount ?? "")"
                    self.lblSubTotalText.text = (data.final_total_data?[0].label ?? "")
                }
                if data.final_total_data?.count ?? 0 > 1 {
                    self.lblDeliveryCharge.text = "₹\(data.final_total_data?[1].amount ?? "")"
                    self.lblOtherText.text = (data.final_total_data?[1].label ?? "")
                }
                if data.final_total_data?.count ?? 0 > 2 {
                    self.viewDiscount.isHidden = false
                    self.lblDiscount.text = "₹\(data.final_total_data?[2].amount ?? "")"
                    self.lblDiscountText.text = (data.final_total_data?[2].label ?? "")
                }
                
                self.lblTotalPayableAmount.text = "₹\(data.total_final_payble_amount ?? "")" 
                self.lblDeliveryAddress.text = data.delivery_address ?? ""
                self.tblView.reloadData()
                
                if data.current_track_status == "Canceled" {
                    self.viewTrack.isHidden = true
                }else {
                    self.viewTrack.isHidden = false
                }
                
                self.setImages(status: data.current_track_status ?? "")
                if data.cancel_btn == "No" {
                    self.viewCancel.isHidden = true
                }else {
                    self.viewCancel.isHidden = false
                }
                
                if data.feedback_btn_heading ?? "" == "" {
                    self.viewFeedback.isHidden = true
                }else {
                    self.viewFeedback.isHidden = false
                    
                }
                
                if data.current_track_status ?? "" == "Confirmed" || data.current_track_status ?? "" == "OnDelivery"  || data.current_track_status ?? "" == "Placed" || data.current_track_status ?? "" == "Delivered" {
                    self.btnreorder.isHidden = false
                }else {
                    self.btnreorder.isHidden = true
                }
                
                // self.orderId = data.displayOrderID ?? ""
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    func didReceiveReOrder(response: ReOrder.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if response != nil {
                UserDefaultsManager.setCartCount(count: response?.cart_items ?? "")
                UserDefaultsManager.setCartAmount(amount: response?.cart_amount ?? "")
                self.redirectToCart()
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
}

extension OrdersDetailsViewController: SendFeedBack {
    
    func success() {
        let request = OrdersDetails.Request(orderId: self.orderId)
        interactor?.callOrderDetailsAPI(request: request)
    }
}


extension OrdersDetailsViewController {
    
    func callOrderCancelAPI() {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "order_list&userID=\(user?.userId ?? "")&page=cancel_order&orderID=\(self.orderId)"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<CancelOrder.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                //completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
                self.showTopMessage(message: detail.message ?? "", type: .Success)
                self.navigationController?.popViewController(animated: true)
            }else {
                //completionHandler(nil,"Error",1)
                self.showTopMessage(message: response?.message ?? "", type: .Error)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
