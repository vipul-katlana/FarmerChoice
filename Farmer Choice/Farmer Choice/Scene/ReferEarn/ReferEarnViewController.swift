

import UIKit
import MessageUI

protocol ReferEarnDisplayLogic: class {
    func didReceiveReferEarnResponse(response: ReferEarn.ViewModel?, message: String, successCode: Int)
}

class ReferEarnViewController: BaseViewController {
    var interactor: ReferEarnBusinessLogic?
    var router: (NSObjectProtocol & ReferEarnRoutingLogic & ReferEarnDataPassing)?
    
    
    @IBOutlet weak var imgDiaplay: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var vwCd: UIView!
    
    
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
        let interactor = ReferEarnInteractor()
        let presenter = ReferEarnPresenter()
        let router = ReferEarnRouter()
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
        self.vwCd.layer.borderWidth = 1
        self.vwCd.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
    }
    
    func setUpLayout() {
        interactor?.callReferEarnAPI()
    }
    
    func configureMailComposer() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setSubject("\(AppInfo.kAppName)")
        mailComposeVC.setMessageBody("\("\(AppInfo.kAppName) Share Your Code \(lblCode.text ?? "")")", isHTML: false)
        return mailComposeVC
    }
    
    class func instance() -> ReferEarnViewController? {
        return UIStoryboard(name: "ReferEarn", bundle: nil).instantiateViewController(withIdentifier: "ReferEarnViewController") as? ReferEarnViewController
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCopyCodeAction(_ sender: Any) {
        UIPasteboard.general.string = self.lblCode.text ?? ""
        self.showTopMessage(message: "Refer Link Copied", type: .Success)
    }
    
    @IBAction func btnWhatsAppShareAction(_ sender: Any) {
        let msg = "\(AppInfo.kAppName) Share Your Code \(lblCode.text ?? "")"
        let urlWhats = "whatsapp://send?text=\(msg)"
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.openURL(whatsappURL as URL)
                } else {
                    print("please install watsapp")
                }
            }
        }
    }
    
    @IBAction func btnFacebookShareAction(_ sender: Any) {
        
    }
    
    @IBAction func btnMailShareAction(_ sender: Any) {
        
        let mailComposeViewController = configureMailComposer()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            print("Can't send email")
        }
    }
    
    @IBAction func btnMoreShareAction(_ sender: Any) {
        let atext = "\(AppInfo.kAppName) Share Your Code \(lblCode.text ?? "")"
        let activityVC = UIActivityViewController(activityItems: [atext], applicationActivities: nil)
        activityVC.setValue("\(AppInfo.kAppName) Code", forKey: "subject")
        present(activityVC, animated: true, completion: nil)
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

extension ReferEarnViewController: ReferEarnDisplayLogic {
    func didReceiveReferEarnResponse(response: ReferEarn.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                self.imgDiaplay.setImage(with: data.shareData?[0].image ?? "")
                self.lblTitle.text = "\(data.shareData?[0].you_get ?? "") and \(data.shareData?[0].you_friend_get ?? "")"
                self.lblCode.text = (data.shareData?[0].ref_key ?? "")
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    
}

extension ReferEarnViewController {
    override func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
