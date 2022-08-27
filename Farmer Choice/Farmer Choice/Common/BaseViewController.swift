
import UIKit
import SJSwiftSideMenuController
import SafariServices
import MessageUI
import Alamofire
import Lottie


class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupHomeNavigationBar() {
        let image = UIImage().verticalGradientImageWithBounds(bounds: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.size.width)  , height: 90), colors: [(#colorLiteral(red: 0.2980392157, green: 0.6901960784, blue: 0.3137254902, alpha: 1)),(#colorLiteral(red: 0.2980392157, green: 0.6901960784, blue: 0.3137254902, alpha: 0.99))])
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0)]
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        let item = UIBarButtonItem(image: UIImage(), style: .plain, target: nil, action: nil)
        item.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = item
    }
    
    func showLeftMenu() {
        SJSwiftSideMenuController.showLeftMenu()
    }
    
    func openLink(link: String) {
        if let url = URL(string: link) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            vc.modalPresentationStyle = UIModalPresentationStyle.popover
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func callNumber(phoneNumber:String) {
        if !phoneNumber.isEmpty {
            let aNumber = phoneNumber.replacingOccurrences(of: " ", with: "")
            if let phoneCallURL:URL = URL(string:"tel://\(aNumber)") {
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL )) {
                    if #available(iOS 10, *) {
                        application.open(phoneCallURL , options: [:], completionHandler: nil)
                    } else {
                        application.openURL(phoneCallURL);
                    }
                }
            }
        }
    }
    
    func callWhatsApp(phoneNumber:String) {
        if !phoneNumber.isEmpty {
            let aNumber = phoneNumber.replacingOccurrences(of: " ", with: "")
            if let phoneCallURL:URL = URL(string:"https://api.whatsapp.com/send?phone=\(aNumber)") {
                let application:UIApplication = UIApplication.shared
                if application.canOpenURL(phoneCallURL) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
                    }
                    else {
                        application.openURL(phoneCallURL)
                    }
                }
            }
        }
    }
    
    func sendEmail(emailAddress:String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([emailAddress])
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func internetAvailable()-> Bool {
        if !(NetworkReachabilityManager()!.isReachable) {
            self.showTopMessage(message: AlertMessage.InternetError, type: .Error)
            return false
        }else {
            return true
        }
    }
    
    
    func setTopBorderView(view: UIView) {
        view.addBarShadow(to: [.top], radius: 5)
    }
    
    func setBottomBorderView(view: UIView) {
        view.addBarShadow(to: [.bottom], radius: 5)
    }
    
    func redirectToCart() {
        if GuestUser.isUserGuest {
            self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                if let VC = AuthenticationViewController.instance() {
                    let navVC = UINavigationController(rootViewController: VC)
                    AppConstant.appDelegate.window?.rootViewController = navVC
                }
            }, cancelAction: nil)
        }else {
            if let VC = CartListViewController.instance() {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
        
    }
    
    func redirectToHome() {
        AppConstant.appDelegate.setRootViewController()
    }
    
    func redirectToHelp() {
        if let VC = CategoryViewController.instance() {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    func rediretToOrderList() {
        if GuestUser.isUserGuest {
            self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                if let VC = AuthenticationViewController.instance() {
                    let navVC = UINavigationController(rootViewController: VC)
                    AppConstant.appDelegate.window?.rootViewController = navVC
                }
            }, cancelAction: nil)
        }else {
            if let VC = WishListViewController.instance() {
                VC.isFrom = "wishList"
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
        
    }
    
    func redirectToWallet() {
        if let VC = HelpCenterViewController.instance() {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    var animationView : AnimationView!
    
    func getNoDataView (filename: String, view: UIView, size: Int) -> AnimationView {
        animationView = AnimationView(name: filename)
        animationView.contentMode = .scaleAspectFill
        animationView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        animationView.center = CGPoint(x: (UIScreen.main.bounds.width ) / 2, y: ((UIScreen.main.bounds.height + 60 ) - CGFloat(size) ) / 2)
        animationView.loopMode = .loop
        animationView.play { (played) in
            
        }
        return animationView
    }
}

extension BaseViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
