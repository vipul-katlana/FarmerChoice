
import UIKit
import CFSDK
import Razorpay
import Alamofire

protocol AddMoneyDisplayLogic: class {
    func didReceivePayTmDetails(response: [PaytmIntegration.ViewModel]?,message: String, successCode: Int)
    func didReceivePayTmOrder(response: PaytmOrderResult.ViewModel?,message: String, successCode: Int)
    
    
}

class AddMoneyViewController: UIViewController {
    var interactor: AddMoneyBusinessLogic?
    var router: (NSObjectProtocol & AddMoneyRoutingLogic & AddMoneyDataPassing)?
    
    @IBOutlet weak var imgIcon: UIImageView!
    
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var lblWalletAmount: UILabel!
    @IBOutlet weak var viewFirst: UIView!
    @IBOutlet weak var viewSecond: UIView!
    @IBOutlet weak var viewThird: UIView!
    @IBOutlet weak var viewFourth: UIView!
    var walletAmount = ""
    var paytmSdkMessage = ""
    var paytmStatus = ""
    
    
    var razorpay: RazorpayCheckout!
    var responseObj: PaytmIntegration.ViewModel?
    
    
    //    var txnController = PGTransactionViewController()
    //    var serv = PGServerEnvironment()
    
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
        let interactor = AddMoneyInteractor()
        let presenter = AddMoneyPresenter()
        let router = AddMoneyRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    func setUp() {
        self.viewFirst.setBorderWithColor(color: AppConstant.appGreenColor!)
        self.viewSecond.setBorderWithColor(color: AppConstant.appGreenColor!)
        self.viewThird.setBorderWithColor(color: AppConstant.appGreenColor!)
        self.viewFourth.setBorderWithColor(color: AppConstant.appGreenColor!)
        self.lblWalletAmount.text = "₹\(walletAmount)"
        
        
       // razorpay = RazorpayCheckout.initWithKey(AppConstant.razorpayKey, andDelegate: self)
        
        razorpay =  RazorpayCheckout.initWithKey(AppConstant.razorpayKey, andDelegateWithData: self)
        
        
    }
    
    func callAPI() {
        let request = PaytmIntegration.Request(amount: self.txtField.text ?? "")
        interactor?.callPaytmDetailsAPI(request: request)
    }
    
    class func instance() -> AddMoneyViewController? {
        return UIStoryboard(name: "WalletHistory", bundle: nil).instantiateViewController(withIdentifier: "AddMoneyViewController") as? AddMoneyViewController
    }
    
    
    @IBAction func btnBAckAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFirstAction(_ sender: Any) {
        self.txtField.text = "100"
        self.callAPI()
        
        
    }
    
    @IBAction func btnSecondAction(_ sender: Any) {
        self.txtField.text = "200"
        self.callAPI()
    }
    
    @IBAction func btnThirdAction(_ sender: Any) {
        self.txtField.text = "500"
        self.callAPI()
    }
    
    @IBAction func btnFourthAction(_ sender: Any) {
        self.txtField.text = "1000"
        self.callAPI()
    }
    
    @IBAction func btnPaytmAction(_ sender: Any) {
        if txtField.text == "" {
            self.showTopMessage(message: "Please enter amount", type: .Error)
        }else {
            self.callAPI()
        }
    }
    
    
    
    func cashFreePayment(data: PaytmIntegration.ViewModel) {
        CFPaymentService().doWebCheckoutPayment(
            params: getPaymentParams(data: data),
            env: data.cashfree_Mode ?? "",
            callback: self)
    }
}

extension AddMoneyViewController: AddMoneyDisplayLogic {
    
    func didReceivePayTmDetails(response: [PaytmIntegration.ViewModel]?,message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                //self.getCheckSumAPICall(checkSumKey: data.checkSum ?? "", data: data)
            }
        }else if successCode == 5 {
            if let dataRes = response {
                if let frstObj = dataRes.first {
                    self.cashFreePayment(data: frstObj)
                }
                
            }
            
        }else if successCode == 7 {
            if let dataRes = response {
                if let frstObj = dataRes.first {
                    self.responseObj = frstObj
                    self.openRazorpayCheckout(data: frstObj)
                }
                
            }
            
        }
        else {
            self.showTopMessage(message: message, type: .Error)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    func didReceivePayTmOrder(response: PaytmOrderResult.ViewModel?,message: String, successCode: Int) {
        if successCode == 0 {

        }
        
    }
    
}



//CASH FREE PAYMENT
extension AddMoneyViewController:  ResultDelegate {
    
    func onPaymentCompletion(msg: String) {
        print("JSON value : \(msg)")
        let inputJSON = "\(msg)"
        let inputData = inputJSON.data(using: .utf8)!
        let decoder = JSONDecoder()
        if inputJSON != "" {
            do {
                let result2 = try decoder.decode(ResultPayment.self, from: inputData)
                
                let request = PaytmOrderResult.Request(orderId: result2.orderId, orderAmount: result2.orderAmount, referenceId: result2.referenceId, txStatus: result2.txStatus, paymentMode: result2.paymentMode, txMsg: result2.txMsg, txTime: result2.txTime, signature: result2.signature, rozerPayId: "")
                AddMoneyWorker.callPaymentStatusAPI(request: request) { (response, message, success) in
                    if success == 0 {
                        if let data = response {
                            if data.payment_status == "Success" {
                                if let VC = OrderSuccessViewController.instance() {
                                    VC.orderSuccess = true
                                    VC.message = data.msg2 ?? ""
                                    VC.titleOrder = data.msg1 ?? ""
                                    VC.isFromPaytm = true
                                    VC.modalPresentationStyle = .overCurrentContext
                                    self.present(VC, animated: true, completion: nil)
                                }
                            }else {
                                if let VC = OrderSuccessViewController.instance() {
                                    VC.orderSuccess = false
                                    VC.message = data.msg2 ?? ""
                                    VC.titleOrder = data.msg1 ?? ""
                                    VC.isFromPaytm = true
                                    VC.modalPresentationStyle = .overCurrentContext
                                    self.present(VC, animated: true, completion: nil)
                                }
                            }
                        }
                    }
                }
                
                
            } catch {
                // handle exception
                print("BDEBUG: Error Occured while retrieving transaction response")
            }
        } else {
            print("BDEBUG: transactionResult is empty")
        }
    }
    
    
    func getPaymentParams(data: PaytmIntegration.ViewModel) -> Dictionary<String, Any> {
        return [
            "orderId": data.orderId ?? "",
            "appId": data.cashfree_clientID ?? "",
            "tokenData" : data.token ?? "",
            "orderAmount": data.orderAmount ?? "",
            "customerName": data.customerName ?? "",
            "orderNote": data.orderNote ?? "",
            "orderCurrency": data.orderCurrency ?? "",
            "customerPhone": data.customerPhone ?? "",
            "customerEmail": data.customerEmail ?? "",
            "notifyUrl": data.notifyUrl ?? "",
            "color1":  "#11823B",
            "color2": "#000000"
        ]
    }
}



struct ResultPayment : Codable {
    let orderId: String
    let referenceId: String
    let orderAmount: String
    let txStatus: String
    let txMsg: String
    let txTime: String
    let paymentMode: String
    let signature: String
    
    enum CodingKeys : String, CodingKey {
        case orderId
        case referenceId
        case orderAmount
        case txStatus
        case txMsg
        case txTime
        case paymentMode
        case signature
    }
}


struct FailResultPayment : Codable {
    let txStatus: String
    let txMsg: String

    
    enum CodingKeys : String, CodingKey {
        case txStatus
        case txMsg
    }
}


extension AddMoneyViewController {
    
    private func openRazorpayCheckout(data: PaytmIntegration.ViewModel) {
        
        let options: [String:Any] = [
            "amount": "\((Int(data.orderAmount ?? "") ?? 0) * 100)",
            "currency": "INR",
            "description": data.orderNote ?? "",
            "order_id":  data.razorpayOrderId ?? "",
            "image": UIImage(named: "login_logo"),
            "name": AppInfo.kAppName,
            "prefill": [
                "contact": UserDefaultsManager.getLoggedUserDetails()?.phone ?? "",
                "email": UserDefaultsManager.getLoggedUserDetails()?.email ?? ""
            ],
            "notes": [
                "merchant_order_id": data.orderId ?? "",
                "master_types": "AddMoney"
            ],
            "theme": [
                "color": "#11823B"
            ]
        ]
        razorpay.open(options)
    }
}


extension AddMoneyViewController: RazorpayPaymentCompletionProtocolWithData {

    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        print("error: ", code)
//        self.showTopMessage(message: str, type: .Error)
//        self.navigationController?.popViewController(animated: true)
        
        
        let request = PaytmOrderResult.Request(orderId: responseObj?.orderId ?? "", orderAmount: responseObj?.orderAmount ?? "", referenceId: "" , txStatus: "fail", paymentMode: "Rozarpay", txMsg: "", txTime: "", signature: "", rozerPayId: "")
        AddMoneyWorker.callPaymentStatusAPI(request: request) { (response, message, success) in
            if success == 0 {
                if let data = response {
                    if data.payment_status == "Success" {
                        if let VC = OrderSuccessViewController.instance() {
                            VC.orderSuccess = true
                            VC.message = data.msg2 ?? ""
                            VC.titleOrder = data.msg1 ?? ""
                            VC.isFromPaytm = true
                            VC.modalPresentationStyle = .overCurrentContext
                            self.present(VC, animated: true, completion: nil)
                        }
                    }else {
                        if let VC = OrderSuccessViewController.instance() {
                            VC.orderSuccess = false
                            VC.message = data.msg2 ?? ""
                            VC.titleOrder = data.msg1 ?? ""
                            VC.isFromPaytm = true
                            VC.modalPresentationStyle = .overCurrentContext
                            self.present(VC, animated: true, completion: nil)
                        }
                    }
                }
            }
    }

    }
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        print("success: ", payment_id)
        print(response)
        
        guard let rPayId = response?["razorpay_payment_id"] as? String else {return}
        guard let rsignature = response?["razorpay_signature"] as? String else { return }
        guard let riddd  = response?["razorpay_order_id"] as? String else { return }
        //razorpay_order_id
        
        let request = PaytmOrderResult.Request(orderId: responseObj?.orderId ?? "", orderAmount: responseObj?.orderAmount ?? "", referenceId: rPayId , txStatus: "success", paymentMode: "Rozarpay", txMsg: "", txTime: "", signature: rsignature, rozerPayId: riddd)
        AddMoneyWorker.callPaymentStatusAPI(request: request) { (response, message, success) in
            if success == 0 {
                if let data = response {
                    if data.payment_status == "Success" {
                        if let VC = OrderSuccessViewController.instance() {
                            VC.orderSuccess = true
                            VC.message = data.msg2 ?? ""
                            VC.titleOrder = data.msg1 ?? ""
                            VC.isFromPaytm = true
                            VC.modalPresentationStyle = .overCurrentContext
                            self.present(VC, animated: true, completion: nil)
                        }
                    }else {
                        if let VC = OrderSuccessViewController.instance() {
                            VC.orderSuccess = false
                            VC.message = data.msg2 ?? ""
                            VC.titleOrder = data.msg1 ?? ""
                            VC.isFromPaytm = true
                            VC.modalPresentationStyle = .overCurrentContext
                            self.present(VC, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
}
