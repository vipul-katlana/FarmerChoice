
import UIKit
import SafariServices

protocol AuthenticationDisplayLogic: class {
    func didReceiveLoginResponse(response: Login.ViewModel?, message: String, successCode: Int)
    func didReceiveSignUpResponse(response: SignUp.ViewModel?, message: String, successCode: Int)
}

class AuthenticationViewController: BaseViewController {
    
    @IBOutlet weak var lblSelectedCity: UILabel!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnSigninBottom: UIButton!
    @IBOutlet weak var btnSignUpBottom: UIButton!
    @IBOutlet weak var viewSignUp: UIView!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var imgSignIn: UIImageView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var imgSignUp: UIImageView!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var viewMobile: UIView!
    @IBOutlet weak var txtFieldMobile: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var viewRefrenceCode: UIView!
    @IBOutlet weak var txtFieldRefrenceCode: UITextField!
    @IBOutlet weak var txtviewTermsCondition: UITextView!
    @IBOutlet weak var viewSignIn: UIView!
    @IBOutlet weak var viewSignInMobile: UIView!
    @IBOutlet weak var txtFieldSignInMobile: UITextField!
    
    
    var interactor: AuthenticationBusinessLogic?
    var router: (NSObjectProtocol & AuthenticationRoutingLogic & AuthenticationDataPassing)?
    
    
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
        let interactor = AuthenticationInteractor()
        let presenter = AuthenticationPresenter()
        let router = AuthenticationRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    class func instance() -> AuthenticationViewController? {
        return UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: "AuthenticationViewController") as? AuthenticationViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    func setUp() {
        self.viewName.setBorder()
        self.viewMobile.setBorder()
        self.viewEmail.setBorder()
        self.viewRefrenceCode.setBorder()
        self.viewSignInMobile.setBorder()
        self.setView(signInView: true)
        self.setUpTermsAndConditionPrivacyLabel()
        //self.btnSigninBottom.addCircularShadow(5)
        //self.btnSignUpBottom.addCircularShadow(5)
        //self.btnSkip.layer.cornerRadius = 5
        
        //self.btnSkip.setBorderWithColor(color: UIColor(named: "appGreenColor")!)
        
        //self.lblSelectedCity.text = "Your selected city is \(UserDefaultsManager.getCityName())"
        
    }
    
    func setView(signInView: Bool) {
        self.view.endEditing(true)
        if signInView {
            self.viewSignIn.isHidden = false
            self.viewSignUp.isHidden = true
            //            self.btnSignIn.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 17.0)
            //            self.btnSignUp.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 16.0)
            self.imgSignIn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.imgSignUp.backgroundColor = .clear
            self.btnSignIn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            self.btnSignUp.setTitleColor(#colorLiteral(red: 0.5921568627, green: 0.6039215686, blue: 0.6039215686, alpha: 1), for: .normal)
        }else {
            self.viewSignIn.isHidden = true
            self.viewSignUp.isHidden = false
            //            self.btnSignIn.titleLabel?.font = UIFont(name: "", size: 16.0)
            //            self.btnSignUp.titleLabel?.font = UIFont(name: "", size: 16.0)
            self.imgSignUp.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.imgSignIn.backgroundColor = .clear
            self.btnSignUp.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            self.btnSignIn.setTitleColor(#colorLiteral(red: 0.5921568627, green: 0.6039215686, blue: 0.6039215686, alpha: 1), for: .normal)
        }
    }
    
    func validateSignInFields() {
        guard self.internetAvailable() else {
            return
        }
        do {
            _ = try txtFieldSignInMobile.validatedText(validationType: ValidatorType.phone,
                                                       visibility: true, optional: false)
            let request = Login.Request(phoneNumber: self.txtFieldSignInMobile.text ?? "")
            interactor?.callLoginAPI(request: request)
            
        } catch(let error) {
            self.showTopMessage(message: (error as? ValidationError)?.message, type: .Error)
        }
    }
    
    func validateSignUpFields() {
        guard self.internetAvailable() else {
            return
        }
        do {
            _ = try txtFieldName.validatedText(validationType: ValidatorType.username,
                                               visibility: true, optional: false)
            
            _ = try txtFieldMobile.validatedText(validationType: ValidatorType.phone,
                                                 visibility: true, optional: false)
            
            //call api here
            let request = SignUp.Request(name: self.txtFieldName.text ?? "", email: self.txtFieldEmail.text ?? "", phone: txtFieldMobile.text ?? "", referCode: self.txtFieldRefrenceCode.text ?? "")
            interactor?.callSignUpAPI(request: request)
            
        } catch(let error) {
            self.showTopMessage(message: (error as? ValidationError)?.message, type: .Error)
        }
    }
    
    func setUpTermsAndConditionPrivacyLabel() {
        txtviewTermsCondition.textContainerInset = .zero
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapLabel(recognizer:)))
        tapGesture.numberOfTapsRequired = 1
        txtviewTermsCondition.addGestureRecognizer(tapGesture)
        txtviewTermsCondition.text = "By Signing up, you agree to our Terms & Conditions"
        let range = (txtviewTermsCondition.text! as NSString).range(of: txtviewTermsCondition.text)
        let underlineAttriString = NSMutableAttributedString(string: txtviewTermsCondition.text!, attributes: nil)
        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Poppins-Light", size: 14.0)!, range: range)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
        
        let range1 = (txtviewTermsCondition.text! as NSString).range(of: "Terms & Conditions")
        underlineAttriString.addAttribute(NSAttributedString.Key(rawValue: "idnum"), value: "1", range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range1)
        
        
        let range3 = (txtviewTermsCondition.text! as NSString).range(of: "Terms & Conditions")
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range3)
        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Poppins-Regular", size: 15.0)!, range: range3)
        
        txtviewTermsCondition.attributedText = underlineAttriString
    }
    
    
    @objc func tapLabel(recognizer: UITapGestureRecognizer) {
        if let textView = recognizer.view as? UITextView {
            var location: CGPoint = recognizer.location(in: textView)
            location.x -= textView.textContainerInset.left
            location.y -= textView.textContainerInset.top
            let charIndex = textView.layoutManager.characterIndex(for: location, in: textView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
            if charIndex < textView.textStorage.length {
                var range = NSRange(location: 0, length: 0)
                if (textView.attributedText?.attribute(NSAttributedString.Key(rawValue: "idnum"), at: charIndex, effectiveRange: &range) as? NSString) != nil {
                    let tappedPhrase = (textView.attributedText.string as NSString).substring(with: range)
                    if tappedPhrase == "Terms & Conditions" {
                        
                        if let url = URL(string: AppConstant.TCURL) {
                            let config = SFSafariViewController.Configuration()
                            config.entersReaderIfAvailable = true
                            
                            let vc = SFSafariViewController(url: url, configuration: config)
                            present(vc, animated: true)
                        }
                    }
                }
                if let desc = textView.attributedText?.attribute(NSAttributedString.Key(rawValue: "desc"), at: charIndex, effectiveRange: &range) as? NSString {
                    print("desc: \(desc)")
                }
            }
        }
    }
    
    @IBAction func btnSignInSelectionAction(_ sender: Any) {
        self.setView(signInView: true)
    }
    
    @IBAction func btnSignUpSelectionAction(_ sender: Any) {
        self.setView(signInView: false)
    }
    
    @IBAction func btnSignUpAction(_ sender: Any) {
        GuestUser.isUserGuest = false
        self.validateSignUpFields()
    }
    
    @IBAction func btnSignInAction(_ sender: Any) {
        GuestUser.isUserGuest = false
        self.validateSignInFields()
    }
    
    @IBAction func btnSkipAction(_ sender: Any) {
        GuestUser.isUserGuest = true
        AppConstant.appDelegate.setRootViewController()
    }
    
}

extension AuthenticationViewController: AuthenticationDisplayLogic {
    func didReceiveLoginResponse(response: Login.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                if data.screen_type == "SIGNUP_SCREEN" {
                    self.showTopMessage(message: message, type: .Error)
                }else {
                    if let VC = OTPViewController.instance() {
                        VC.otp = data.user_detail?[0].otp ?? ""
                        VC.loginData = data.user_detail?[0]
                        self.navigationController?.pushViewController(VC, animated: true)
                    }
                }
                
            }
            else {
                self.showTopMessage(message: message, type: .Error)
            }
            
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    func didReceiveSignUpResponse(response: SignUp.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                if let VC = OTPViewController.instance() {
                    VC.otp = data.user_detail?[0].otp ?? ""
                    VC.loginData = data.user_detail?[0]
                    self.navigationController?.pushViewController(VC, animated: true)
                }
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
            
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
}
