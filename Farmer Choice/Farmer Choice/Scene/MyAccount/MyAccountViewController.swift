
import UIKit

protocol MyAccountDisplayLogic: class {
    func displaySomething(viewModel: MyAccount.Something.ViewModel)
}

class MyAccountViewController: BaseViewController {
    var interactor: MyAccountBusinessLogic?
    var router: (NSObjectProtocol & MyAccountRoutingLogic & MyAccountDataPassing)?
    
    
    @IBOutlet weak var imgIconFrst: UIImageView!
    @IBOutlet weak var imgIconSecond: UIImageView!
    @IBOutlet weak var imgIconThird: UIImageView!
    
    
    @IBOutlet weak var imgUserprofile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var btnSignOut: UIButton!
    
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
        let interactor = MyAccountInteractor()
        let presenter = MyAccountPresenter()
        let router = MyAccountRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    class func instance() -> MyAccountViewController? {
        return UIStoryboard(name: "MyAccount", bundle: nil).instantiateViewController(withIdentifier: "MyAccountViewController") as? MyAccountViewController
    }
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUserData()
    }
    
    func setUpLayout() {
        self.navigationItem.title = "My Account"
        setUserData()
        
        self.imgIconFrst.image = self.imgIconFrst.image?.withRenderingMode(.alwaysTemplate)
        self.imgIconFrst.tintColor = AppConstant.appGreenColor!
        
        self.imgIconSecond.image = self.imgIconSecond.image?.withRenderingMode(.alwaysTemplate)
        self.imgIconSecond.tintColor = AppConstant.appGreenColor!
        
        self.imgIconThird.image = self.imgIconThird.image?.withRenderingMode(.alwaysTemplate)
        self.imgIconThird.tintColor = AppConstant.appGreenColor!
        
        self.btnSignOut.layer.borderWidth = 1
        self.btnSignOut.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
    }
    
    
    func setUserData() {
        let user = UserDefaultsManager.getLoggedUserDetails()
        self.lblName.text = "\(user?.name ?? "") \(user?.lastname ?? "")"
        self.lblPhone.text = user?.phone ?? ""
        self.imgUserprofile.setImage(with: user?.userimage ?? "",placeHolder: UIImage(named: "user_profile"))
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnProfileAction(_ sender: Any) {
        if let VC = MyAccountDetailsViewController.instance() {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnMyProfileAction(_ sender: Any) {
        if let VC = MyAccountDetailsViewController.instance() {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnMyOrderAction(_ sender: Any) {
        if let VC = OrderHistoryViewController.instance() {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    @IBAction func btnWalletHistoryAction(_ sender: Any) {
        if let VC = WalletHistoryViewController.instance() {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnSignoutAction(_ sender: Any) {
        self.displayAlert(msg: "Are you sure you want to logout?", ok: "Yes", cancel: "No", okAction: {
//            UserDefaultsManager.logoutUser()
//            if let VC = AuthenticationViewController.instance() {
//                let navVC = UINavigationController(rootViewController: VC)
//                AppConstant.appDelegate.window?.rootViewController = navVC
//            }
            
            UserDefaultsManager.logoutUser()
            UserDefaultsManager.selectCityName(name: "")
            UserDefaultsManager.selectAreaId(areaId: "")
            UserDefaultsManager.selectCityId(id: "")
            if let VC = SelectCityViewController.instance() {
                let navVC = UINavigationController(rootViewController: VC)
                AppConstant.appDelegate.window?.rootViewController = navVC
            }
        }, cancelAction: nil)
    }
}

extension MyAccountViewController: MyAccountDisplayLogic {
    func displaySomething(viewModel: MyAccount.Something.ViewModel) {
        print("")
    }
    
    
}
