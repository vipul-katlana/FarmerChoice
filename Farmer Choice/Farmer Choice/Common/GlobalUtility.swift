

import UIKit
import Lottie

@objc class GlobalUtility: NSObject {
    
    static let shared: GlobalUtility = {
        let instance = GlobalUtility()
        return instance
    }()
    
    //var cartCount = ""
    var OrderSuccess = false
    var paytmMoneyAdd = false
    
    static func showHud() {
        let aStoryboard = UIStoryboard(name: "Loader", bundle: nil)
        let aVCObj = aStoryboard.instantiateViewController(withIdentifier: "LoaderVC") as! LoaderVC
        let aParent = AppConstant.appDelegate.window
        aVCObj.view.frame = UIScreen.main.bounds
        aVCObj.view.tag  = 10000
        aParent?.addSubview(aVCObj.view)
    }
    
    
    static func hideHud() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        let aParent = AppConstant.appDelegate.window
        for view in (aParent?.subviews)! {
            if view.tag == 10000 {
                view.removeFromSuperview()
            }
        }
    }
    
    
    func currentTopViewController() -> UIViewController {
        var topVC: UIViewController? = AppConstant.appDelegate.window?.rootViewController
        while ((topVC?.presentedViewController) != nil) {
            topVC = topVC?.presentedViewController
        }
        return topVC!
    }
    
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
}
