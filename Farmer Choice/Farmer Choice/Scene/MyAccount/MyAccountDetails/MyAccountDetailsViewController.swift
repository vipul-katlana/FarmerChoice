

import UIKit

protocol UpdateProfileAction {
    func Success()
}

protocol MyAccountDetailsDisplayLogic: class {
    func didReceiveMyProfileResponse(response: MyAccountDetails.ViewModel?, message: String, successCode: Int)
}

class MyAccountDetailsViewController: UIViewController {
    
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    var userData : MyAccountDetails.ViewModel?
    var updateUserData = false
    
    var interactor: MyAccountDetailsBusinessLogic?
    var router: (NSObjectProtocol & MyAccountDetailsRoutingLogic & MyAccountDetailsDataPassing)?
    
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
        let interactor = MyAccountDetailsInteractor()
        let presenter = MyAccountDetailsPresenter()
        let router = MyAccountDetailsRouter()
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
        self.btnEditProfile.changeColor(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), image: "edit_image")
        let user = UserDefaultsManager.getLoggedUserDetails()
        let request = MyAccountDetails.Request(userPhone: user?.phone ?? "")
        interactor?.callMyProfileApi(request: request)
        self.lblName.text = "\(user?.name ?? "") \(user?.lastname ?? "")"
    }
    
    class func instance() -> MyAccountDetailsViewController? {
        return UIStoryboard(name: "MyAccount", bundle: nil).instantiateViewController(withIdentifier: "MyAccountDetailsViewController") as? MyAccountDetailsViewController
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEditAction(_ sender: Any) {
        if let VC = UpdateProfileViewController.instance() {
            VC.userData = self.userData
            VC.updateDelegate = self
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    
}

extension MyAccountDetailsViewController: UpdateProfileAction {
    func Success() {
        self.navigationController?.popViewController(animated: true)
        updateUserData = true
        let user = UserDefaultsManager.getLoggedUserDetails()
        let request = MyAccountDetails.Request(userPhone: user?.phone ?? "")
        self.interactor?.callMyProfileApi(request: request)
    }
    
    
}

extension MyAccountDetailsViewController: MyAccountDetailsDisplayLogic {
    func didReceiveMyProfileResponse(response: MyAccountDetails.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                self.userData = data
                if let userDetails = data.get_detail {
                    self.lblEmail.text = userDetails[0].email ?? "-"
                    self.lblPhone.text = userDetails[0].phone ?? "-"
                    self.lblAddress.text = userDetails[0].address ?? "-"
                    self.imgUserProfile.setImage(with: userDetails[0].userimage ?? "",placeHolder: UIImage(named: "user_profile"))
                    if updateUserData {
                        let user = UserDefaultsManager.getLoggedUserDetails()
                        user?.name = userDetails[0].name ?? ""
                        user?.phone = userDetails[0].phone ?? ""
                        user?.lastname =  ""
                        user?.email = userDetails[0].email ?? ""
                        user?.userimage = userDetails[0].userimage ?? ""
                        UserDefaultsManager.setLoggedUserDetails(userDetail: user!)
                        NotificationCenter.default.post(name: NSNotification.Name("updateProfile"), object: nil, userInfo: nil)
                    }
                }
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    
}
