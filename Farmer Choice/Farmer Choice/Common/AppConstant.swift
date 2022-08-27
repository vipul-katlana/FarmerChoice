
import Foundation
import UIKit

struct AppConstant {
    
    static let appDelegate = UIApplication.shared.delegate  as? AppDelegate ?? AppDelegate()
    static let appGreenColor = UIColor(named: "appGreenColor")
    static let viewBorderColor = UIColor.gray
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    static let razorpayKey = "rzp_live_XHItAkfBjgyxAo"
    
//https://www.farmerchoice.in/
    
    //https://www.farmerchoice.in/iosFreshhaat/index.php?view=city_list
    static let baseUrl = "https://www.farmerchoice.in/iosFreshhaat/index.php?view="
    static let TCURL = "https://www.farmerchoice.in/terms-and-conditions.html"
    static let enableEncryption = false
    static var currLatitude = 0.0
    static var currLongitude = 0.0
    static var appUsed = false
    
}


struct AppInfo {
    static let kAppName = "Farmer Choice"
    /// App Version
    static let kAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    /// App Build version
    static let kAppBuildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1.0"
    /// App Bundle identifier
    static let kBundleIdentifier = Bundle.main.bundleIdentifier
    /// App Store ID
    static let kAppstoreID = "1604716686"
    
    static let googlKey = "AIzaSyB0jMWmi6zLXfIcZPQk9Qx8tkve6_I1BrQ"
}

struct GuestUser {
    static var isUserGuest = false
    static var guestUserMessage = "Please Login/Signup to access \(AppInfo.kAppName)"
}
