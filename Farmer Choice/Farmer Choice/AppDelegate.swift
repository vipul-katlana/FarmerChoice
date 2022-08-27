import UIKit
import SJSwiftSideMenuController
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces
import Firebase
import FirebaseMessaging


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
    
    var window: UIWindow?
    var pushDict : [String:Any]? = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        
        GMSServices.provideAPIKey(AppInfo.googlKey)
        GMSPlacesClient.provideAPIKey(AppInfo.googlKey)
        if launchOptions != nil {
            let aDict = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification]
            pushDict = aDict as? [String : Any]
        }
        
        FirebaseApp.configure()
        
        self.registerRemoteNotification()
        
        
        Messaging.messaging().delegate = self
        
        return true
    }
    
    func setRootViewController() {
        let mainVC = SJSwiftSideMenuController()
        if let vc = DashBoardViewController.instance() {
            if let leftVC = SideMenuViewController.instance() {
                SJSwiftSideMenuController.setUpNavigation(rootController: vc, leftMenuController: leftVC, rightMenuController: nil, leftMenuType: .SlideOver, rightMenuType: .SlideOver)
                SJSwiftSideMenuController.enableDimbackground = true
                SJSwiftSideMenuController.enableSwipeGestureWithMenuSide(menuSide: .NONE)
                SJSwiftSideMenuController.leftMenuWidth = UIScreen.main.bounds.width * 0.8
                self.window?.rootViewController = mainVC
            }
        }
        
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcmToken = fcmToken {
            print("Firebase registration token: \(fcmToken)")
            UserDefaultsManager.deviceToken = fcmToken
           // self.updateTokenInBackend(token: fcmToken)
        }
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    
    func registerRemoteNotification(onCompletion: ((Bool) -> Void)? = nil) {
        let application = UIApplication.shared
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            
            guard error == nil else {
                //Display Error.. Handle Error.. etc..
                onCompletion?(false)
                return
            }
            
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
                UNUserNotificationCenter.current().delegate = self
                onCompletion?(true)
            } else {
                //Handle user denying permissions..
                onCompletion?(false)
            }
        }
        
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        //UserDefaultsManager.deviceToken = deviceTokenString
        Messaging.messaging().apnsToken = deviceToken as Data
        
    }
    
    
    
    /// Method is called when push notification is received
    ///
    /// - Parameters:
    ///   - center: Notification center
    ///   - notification: Notification info
    ///   - completionHandler: Completion Handler
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    /// Method is called when user taps on push notification
    ///
    /// - Parameters:
    ///   - center: Notification center
    ///   - response: Notification info
    ///   - completionHandler: Completion Handler
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //Handle the notification
        //self.handlePushNotification(userInfo : response.notification.request.content.userInfo)
        
        let dict = response.notification.request.content.userInfo as! [String:Any]
        let type = dict["type"] as? String
        print(type ?? "")
        pushDict = dict
        
        
    }
    
    /// Method is called when app is in background and user taps on push notification
    ///
    /// - Parameters:
    ///   - application: Application instance
    ///   - userInfo: Notification info
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        self.handlePushNotification(userInfo: userInfo)
    }
    
    /// Method is called when app fails to register push notification
    ///
    /// - Parameters:
    ///   - application: Application object
    ///   - error:Error info
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        UserDefaultsManager.deviceToken = "Error:\("")"
        print("i am not available in simulator \(error)")
    }
    
    /// Method is called to manage push notification data
    ///
    /// - Parameter userInfo: User info received from notification
    func handlePushNotification(userInfo: [AnyHashable : Any]) {
        print(userInfo)
        if UIApplication.shared.applicationState == .active {
            // Refresh screens if opened.
        } else {
            
        }
    }
}

