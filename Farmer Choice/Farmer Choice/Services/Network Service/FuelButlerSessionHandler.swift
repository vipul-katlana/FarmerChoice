

import Foundation

class SessionConstant {
    static let DEVICE_TOKEN: String = "push_device_token"
    static let USER_DATA: String = "user_details"
    static let WS_TOKEN: String = "ws_token"
}

open class FuelButlerSessionHandler: NSObject {
    
    let applicationDefaults = UserDefaults.standard
    var userId: String {
        return  "0"

    }
    
    static let shared = FuelButlerSessionHandler()
    
    var deviceToken: String {
        if let token = applicationDefaults.value(forKey: SessionConstant.DEVICE_TOKEN) as? String {
            return token
        }
        return ""
    }
    
    var wsToken: String {
        if let token = applicationDefaults.value(forKey: SessionConstant.WS_TOKEN) as? String {
            return token
        }
        return ""
    }
    
   
    
    func removeUserDefaultsWhileLoggedOut() {
        applicationDefaults.removeObject(forKey: SessionConstant.DEVICE_TOKEN)
        applicationDefaults.removeObject(forKey: SessionConstant.USER_DATA)
        //BLSessionHandler.shared.userId = "0";
    }
    
    func saveDeviceToken(token: String) {
        applicationDefaults.setValue(token, forKey: SessionConstant.DEVICE_TOKEN)
        applicationDefaults.synchronize()
    }
    
    func setWSToken(token: String) {
        applicationDefaults.setValue(token, forKey: SessionConstant.WS_TOKEN)
        applicationDefaults.synchronize()
    }
    
    func getDeviceToken() -> String? {
        if let token = applicationDefaults.value(forKey: SessionConstant.DEVICE_TOKEN) as? String {
            return token
        }
        return ""
    }
}
