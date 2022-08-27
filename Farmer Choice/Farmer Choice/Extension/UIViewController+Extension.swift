
import Foundation
import UIKit
import SwiftMessages

extension UIViewController {
    func showTopMessage(message : String?, type : NotificationType, displayDuration: Double = 2) {
        
        if let _ = message {
            
            
            let view: MessageView = MessageView.viewFromNib(layout: .cardView)
            
            var config = SwiftMessages.defaultConfig
            
            view.configureTheme(type == .Success ? .success : .error )
            
            config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
            config.duration = .seconds(seconds: displayDuration)
            config.dimMode = .none
            
            config.interactiveHide = true
            view.iconImageView?.isHidden = true
            view.iconLabel?.isHidden = true
            view.button?.isHidden = true
            view.titleLabel?.text = AppInfo.kAppName
            view.bodyLabel?.text = message
            
            view.configureDropShadow()
            
            config.preferredStatusBarStyle = .lightContent
            
            SwiftMessages.show(config: config, view: view)
        }
    }
    
    func displayAlert( msg: String?, ok: String, cancel: String, okAction: (() -> Void)? = nil, cancelAction: (() -> Void)? = nil){
        
        let alertController = UIAlertController(title:  AppInfo.kAppName, message: msg, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancel, style: .cancel)
        { (action) in
            if let cancelAction = cancelAction {
                DispatchQueue.main.async(execute: {
                    cancelAction()
                })
            }
        }
        
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: ok, style: .default)
        { (action) in
            if let okAction = okAction {
                DispatchQueue.main.async(execute: {
                    okAction()
                })
            }
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

enum NotificationType : String {
    case Error
    case Success
    case Info
}
