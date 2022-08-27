


import UIKit

protocol HelpCenterDisplayLogic: class {
    func didReceiveSubmitHelpResponse(message: String, successCode: Int)
}

class HelpCenterViewController: BaseViewController {
    
    //MARK: IBOutlet & Constant
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var viewPhoneNumber: UIView!
    @IBOutlet weak var txtFieldPhoneNumber: UITextField!
    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet weak var txtViewMessage: UITextView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var lblPlaceHolder: UILabel!
    
    var interactor: HelpCenterBusinessLogic?
    var router: (NSObjectProtocol & HelpCenterRoutingLogic & HelpCenterDataPassing)?
    
    
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
        let interactor = HelpCenterInteractor()
        let presenter = HelpCenterPresenter()
        let router = HelpCenterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //MARK: ClassInstance
    class func instance() -> HelpCenterViewController? {
        return UIStoryboard(name: "HelpCenter", bundle: nil).instantiateViewController(withIdentifier: "HelpCenterViewController") as? HelpCenterViewController
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLayout()
    }
    
    func setUpLayout() {
        self.title = "Help Center"
        self.viewName.setBorder()
        self.viewEmail.setBorder()
        self.viewPhoneNumber.setBorder()
        self.viewMessage.setBorder()
        
        let user = UserDefaultsManager.getLoggedUserDetails()
        self.txtFieldName.text = user?.name ?? ""
        self.txtFieldPhoneNumber.text = user?.phone ?? ""
        self.txtFieldEmail.text = user?.email ?? ""
        
    }
    
    func validateFields() {
        guard self.internetAvailable() else {
            return
        }
        do {
            _ = try txtFieldName.validatedText(validationType: ValidatorType.username)
            _ = try txtFieldEmail.validatedText(validationType: ValidatorType.email)
            _ = try txtFieldPhoneNumber.validatedText(validationType: ValidatorType.phone)
            
            if txtViewMessage.text == "" {
                self.showTopMessage(message: "Please enter message", type: .Error)
            }else {
                let request = HelpCenter.Request(name: self.txtFieldName.text ?? "", phone: self.txtFieldPhoneNumber.text ?? "", email: self.txtFieldEmail.text ?? "", message: self.txtViewMessage.text)
                           interactor?.callSubmitHelpAPI(request: request)
            }
            
           
        } catch(let error) {
            self.showTopMessage(message: (error as? ValidationError)?.message, type: .Error)
        }
    }
    
    
    //MARK: IBAction
    @IBAction func btnBackACtion(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        validateFields()
    }
    
    @IBAction func btnHomeAction(_ sender: Any) {
        self.redirectToHome()
    }
    
    @IBAction func btnInfoAction(_ sender: Any) {
        self.redirectToHelp()
    }
    
    @IBAction func btnListAction(_ sender: Any) {
        self.rediretToOrderList()
    }
    
    @IBAction func btnWalletAction(_ sender: Any) {
        self.redirectToWallet()
    }
}


extension HelpCenterViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceHolder.isHidden = !txtViewMessage.text.isEmpty
    }
}


extension HelpCenterViewController: HelpCenterDisplayLogic {
    func didReceiveSubmitHelpResponse(message: String, successCode: Int) {
        if successCode == 0 {
            self.showTopMessage(message: message, type: .Success)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.navigationController?.popViewController(animated: true)
            }
            
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
}
