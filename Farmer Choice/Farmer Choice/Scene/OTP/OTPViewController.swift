
import UIKit
import OTPFieldView

protocol OTPDisplayLogic: class {
    func didReceiveOTPResponse(response: OTP.ViewModel?, message: String, successCode: Int)
}

class OTPViewController: UIViewController {
    
    @IBOutlet weak var vwOTP: OTPFieldView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var viewOTP: UIView!
    @IBOutlet weak var txtFieldOTP: CustomTextField!
    var otp = ""
    var loginData : Login.UserDetails?
    var resendOTP = false
    
    var interactor: OTPBusinessLogic?
    var router: (NSObjectProtocol & OTPRoutingLogic & OTPDataPassing)?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    private func setup() {
        let viewController = self
        let interactor = OTPInteractor()
        let presenter = OTPPresenter()
        let router = OTPRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    class func instance() -> OTPViewController? {
        return UIStoryboard(name: "OTP", bundle: nil).instantiateViewController(withIdentifier: "OTPViewController") as? OTPViewController
    }
    
    func setupOtpView(){
        self.vwOTP.fieldsCount = 4
        self.vwOTP.fieldBorderWidth = 2
        self.vwOTP.defaultBorderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        self.vwOTP.filledBorderColor = #colorLiteral(red: 0.06362466514, green: 0.5090826154, blue: 0.2315942347, alpha: 1)
        self.vwOTP.displayType = .circular
        self.vwOTP.fieldSize = 50
        self.vwOTP.separatorSpace = 15
        self.vwOTP.shouldAllowIntermediateEditing = true
        self.vwOTP.delegate = self
        self.vwOTP.initializeUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.setupOtpView()
    }
    
    
    func setUp() {
        //self.viewOTP.setBorder()
        self.btnSend.changeColor(color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), image: "otpNext")
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        if txtFieldOTP.text == "" {
            self.showTopMessage(message: "Please enter OTP", type: .Error)
        }else if txtFieldOTP.text != otp {
            self.showTopMessage(message: "Please enter valid OTP", type: .Error)
        }
        else {
            let request = OTP.Request(userId: self.loginData?.userId ?? "", otp: self.txtFieldOTP.text ?? "", phone: self.loginData?.phone ?? "", page: "verify")
            interactor?.callOTPAPI(request: request)
        }
    }
    
    
    @IBAction func btnResendAction(_ sender: Any) {
        resendOTP = true
        let request = OTP.Request(userId: self.loginData?.userId ?? "", otp: self.txtFieldOTP.text ?? "", phone: self.loginData?.phone ?? "", page: "send_otp")
        interactor?.callOTPAPI(request: request)
    }
    
}

extension OTPViewController: OTPDisplayLogic {
    func didReceiveOTPResponse(response: OTP.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            print(successCode)
            if let data = response {
                print(data)
                if resendOTP {
                    resendOTP = false
                    self.otp = data.user_detail?[0].otp ?? ""
                    self.txtFieldOTP.text = ""
                }else {
                    UserDefaultsManager.setLoggedUserDetails(userDetail: self.loginData!)
                    AppConstant.appDelegate.setRootViewController()
                }
                
            }
            
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }

}

extension OTPViewController: OTPFieldViewDelegate {
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        print(otp)
        self.txtFieldOTP.text = otp
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        return true
    }
    
    
}
