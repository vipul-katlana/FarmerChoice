

import UIKit

protocol ContactUsDisplayLogic: class {
    func didReceiveContactUsResponse(response: ContactUs.ViewModel?, message: String, successCode: Int)
}

class ContactUsViewController: BaseViewController {
    
    @IBOutlet weak var imgLogo: UIImageView!
    
    //MARK: IBOutlet & Constant
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblWebSite: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnCallUs: UIButton!
    @IBOutlet weak var btnWhatsApp: UIButton!
    @IBOutlet weak var frstCnstrnt: NSLayoutConstraint!
    
    @IBOutlet weak var vwAarea: UIView!
    var interactor: ContactUsBusinessLogic?
    var router: (NSObjectProtocol & ContactUsRoutingLogic & ContactUsDataPassing)?
    
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
        let interactor = ContactUsInteractor()
        let presenter = ContactUsPresenter()
        let router = ContactUsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //MARK: ClassInstance
    class func instance() -> ContactUsViewController? {
        return UIStoryboard(name: "ContactUs", bundle: nil).instantiateViewController(withIdentifier: "ContactUsViewController") as? ContactUsViewController
    }
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLayout()
    }
    
    //MARK: ClassMethod
    func setUpLayout() {
        self.navigationItem.title = "Contact Us"
        self.btnCallUs.layer.cornerRadius = 7
        self.btnCallUs.layer.borderWidth = 1
        self.btnCallUs.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        self.btnWhatsApp.layer.cornerRadius = 7
        self.btnWhatsApp.layer.borderWidth = 1
        self.btnWhatsApp.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        interactor?.callContactUsAPI()
    }
    
    //MARK: IBAction
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnWebsiteAction(_ sender: Any) {
        self.openLink(link: self.lblWebSite.text ?? "")
    }
    
    @IBAction func btnMobileAction(_ sender: Any) {
        self.callNumber(phoneNumber: self.lblPhoneNumber.text ?? "")
    }
    
    @IBAction func btnEmailAction(_ sender: Any) {
        self.sendEmail(emailAddress: self.lblEmail.text ?? "")
    }
    
    @IBAction func btnCallUsAction(_ sender: Any) {
        self.callNumber(phoneNumber: self.lblPhoneNumber.text ?? "")
    }
    
    @IBAction func btnWhatsAction(_ sender: Any) {
        self.callWhatsApp(phoneNumber: self.lblPhoneNumber.text ?? "")

    }
    
    
}


extension ContactUsViewController: ContactUsDisplayLogic {
    func didReceiveContactUsResponse(response: ContactUs.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                self.lblAddress.text = "\(data.contact?[0].address_line1 ?? "")\n\(data.contact?[0].address_line2 ?? "")\n\(data.contact?[0].address_line3 ?? "")"
                self.lblWebSite.text = data.contact?[0].website ?? ""
                self.lblTime.text = data.contact?[0].time ?? ""
                self.lblPhoneNumber.text = data.contact?[0].phone ?? ""
                self.lblEmail.text = data.contact?[0].email ?? ""
                self.imgLogo.setImage(with: "\(data.contact?[0].image ?? "")",placeHolder: UIImage(named: ""))
                if "\(data.contact?[0].address_line1 ?? "")\(data.contact?[0].address_line2 ?? "")\(data.contact?[0].address_line3 ?? "")" == "" {
                    self.vwAarea.isHidden = true
                    self.frstCnstrnt.isActive = false
                }
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    
}
