

import UIKit
import SafariServices

protocol StaticPagesDisplayLogic: class {
    func didStaticPageListResponse(response: StaticPages.ViewModel?, message: String, successCode: Int)
}

class StaticPagesViewController: BaseViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnTwitter: UIButton!
    
    var isFromSignIn = false
    var staticPageData: StaticPages.ViewModel?
    
    var interactor: StaticPagesBusinessLogic?
    var router: (NSObjectProtocol & StaticPagesRoutingLogic & StaticPagesDataPassing)?
    
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
        let interactor = StaticPagesInteractor()
        let presenter = StaticPagesPresenter()
        let router = StaticPagesRouter()
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
        if isFromSignIn {
            self.lblTitle.text = "Terms & Conditions"
        }else {
            self.lblTitle.text = "About Us"
            interactor?.callStaticPageAPI()
        }
        
    }
    
    
    class func instance() -> StaticPagesViewController? {
        return UIStoryboard(name: "StaticPage", bundle: nil).instantiateViewController(withIdentifier: "StaticPagesViewController") as? StaticPagesViewController
    }
    
    func openURL(url:String) {
        if let url = URL(string: "\(url)") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func btnFacebookAction(_ sender: Any) {
        self.openURL(url: self.staticPageData?.about?[0].facebook_link ?? "")
    }
    
    @IBAction func btnGoogleAction(_ sender: Any) {
        self.openURL(url: self.staticPageData?.about?[0].google_link ?? "")
    }
    
    @IBAction func btnTwitterAction(_ sender: Any) {
        self.openURL(url: self.staticPageData?.about?[0].twitter_link ?? "")
    }
    
}

extension StaticPagesViewController: StaticPagesDisplayLogic {
    func didStaticPageListResponse(response: StaticPages.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                self.staticPageData = data
//                let htmlString = data.about?[0].text ?? ""
//                let newdata = htmlString.data(using: String.Encoding.unicode)!
//                let attrStr = try? NSAttributedString(
//                    data: newdata,
//                    options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
//                    documentAttributes: nil)
//                
                
                self.lblText.text = data.about?[0].text ?? ""
                
                self.imgIcon.setImage(with: "\(data.about?[0].image ?? "")",placeHolder: UIImage(named: ""))
                
                if data.about?[0].facebook_link ?? "" == "" {
                    btnFacebook.isHidden = true
                }else {
                    btnFacebook.isHidden = false
                }
                
                if data.about?[0].google_link ?? "" == "" {
                    btnGoogle.isHidden = true
                }else {
                    btnGoogle.isHidden = false
                }
                
//                if data.about?[0].twitter_link ?? "" == "" {
//                    btnTwitter.isHidden = true
//                }else {
//                    btnTwitter.isHidden = false
//                }
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
}
