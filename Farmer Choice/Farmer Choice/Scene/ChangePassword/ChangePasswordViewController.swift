

import UIKit

protocol ChangePasswordDisplayLogic: class {
    func displaySomething(viewModel: ChangePassword.Something.ViewModel)
}

class ChangePasswordViewController: BaseViewController {
    
    //MARK: IBOutlet & Constants
    @IBOutlet weak var viewOldPassword: UIView!
    @IBOutlet weak var txtFieldOldPassword: UITextField!
    @IBOutlet weak var viewNewPassword: UIView!
    @IBOutlet weak var txtFieldNewPassword: UITextField!
    @IBOutlet weak var viewConfirmPassword: UIView!
    @IBOutlet weak var txtFieldConfirmPassword: UITextField!
    
    var interactor: ChangePasswordBusinessLogic?
    var router: (NSObjectProtocol & ChangePasswordRoutingLogic & ChangePasswordDataPassing)?
    
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
        let interactor = ChangePasswordInteractor()
        let presenter = ChangePasswordPresenter()
        let router = ChangePasswordRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //MARK: ClassInstance
    class func instance() -> ChangePasswordViewController? {
        UIStoryboard(name: "ChangePassword", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordViewController") as? ChangePasswordViewController
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLayout()
    }
    
    //MARK: Class Method
    func setUpLayout() {
        self.navigationItem.title = "Change Password"
        self.viewOldPassword.setRoundBorder(radius: 5,color: AppConstant.viewBorderColor)
        self.viewNewPassword.setRoundBorder(radius: 5,color: AppConstant.viewBorderColor)
        self.viewConfirmPassword.setRoundBorder(radius: 5,color: AppConstant.viewBorderColor)
    }
    
    //MARK: IBAction
    @IBAction func btnSubmitAction(_ sender: Any) {
        
    }
}


extension ChangePasswordViewController: ChangePasswordDisplayLogic {
    func displaySomething(viewModel: ChangePassword.Something.ViewModel) {
        print("")
    }
    
    
}
