
import Foundation

struct UserDefaultsManager {
    
    static let applicationDefaults = UserDefaults.standard
    
    static private var userDetails: Login.UserDetails?
    static func setLoggedUserDetails(userDetail: Login.UserDetails) {
        let encoder = JSONEncoder()
        let encodedData = try? encoder.encode(userDetail)
        applicationDefaults.setValue(encodedData, forKey: UserDefaultsKey.userDetail)
        applicationDefaults.synchronize()
    }
    
    
    static func logoutUser() {
        userDetails = nil
        UserDefaultsManager.setCartCount(count: "0")
        UserDefaultsManager.setCartAmount(amount: "0")
        applicationDefaults.removeObject(forKey: UserDefaultsKey.userDetail)
    }
    
    
    static func getLoggedUserDetails() -> Login.UserDetails? {
        if let decoded = applicationDefaults.object(forKey: UserDefaultsKey.userDetail) as? Data {
            let decoder = JSONDecoder()
            let decodedUser = try? decoder.decode(Login.UserDetails.self, from: decoded)
            userDetails = decodedUser
        }
        return userDetails
    }
    
    static func selectCityId(id: String) {
        applicationDefaults.set(id, forKey: "city_id")
    }
    
    static func getCityId() -> String {
        return applicationDefaults.string(forKey: "city_id") ?? ""
    }
    
    
    static func intoAdd(id: String) {
        applicationDefaults.set(id, forKey: "introAdded")
    }
    
    static func intoAdded() -> String {
        return applicationDefaults.string(forKey: "introAdded") ?? ""
    }
    
    
    
    static func selectCityName(name: String) {
        applicationDefaults.set(name, forKey: "city_name")
    }
    
    static func getCityName() -> String {
        return applicationDefaults.string(forKey: "city_name") ?? ""
    }
    
    
    static func selectAreaId(areaId: String) {
        applicationDefaults.set(areaId, forKey: "area_ID")
    }
    
    static func getAreaId() -> String {
        return applicationDefaults.string(forKey: "area_ID") ?? ""
    }
    
    static func setCartCount(count: String) {
        applicationDefaults.set(count, forKey: "cart_Count")
    }
    
    static func getCartCount() -> String {
        return applicationDefaults.string(forKey: "cart_Count") ?? "0"
    }
    
    
    static func setCartAmount(amount: String) {
        applicationDefaults.set(amount, forKey: "cart_Amount")
    }
    
    static func getCartAmount() -> String {
        return applicationDefaults.string(forKey: "cart_Amount") ?? "0.0"
    }
    
    
    static func appLaunshFirst(launch: String) {
        applicationDefaults.set(launch, forKey: "app_launch_frts")
    }
    
    static func getAppLaunshFirst() -> String {
        return applicationDefaults.string(forKey: "app_launch_frts") ?? "0"
    }
    
    
    static func setMapAccess(launch: String) {
        applicationDefaults.set(launch, forKey: "app_mapAccess")
    }
    
    static func getMapAccess() -> String {
        return applicationDefaults.string(forKey: "app_mapAccess") ?? "0"
    }
    
    static var deviceToken: String {
        get {
            return applicationDefaults.string(forKey: UserDefaultsKey.deviceTokenKey) ?? "Error:\("")"
        }
        set {
            applicationDefaults.setValue(newValue, forKey: UserDefaultsKey.deviceTokenKey)
        }
    }
    
}


struct UserDefaultsKey {
    static let deviceTokenKey = "deviceTokenKey"
    static let ws_token = "ws_token"
    static let userDetail = "user_detail"
    static let notificationEnable = "notification_enable"
    
}
