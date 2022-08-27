

import UIKit

enum UpdateProfile {
    
    struct Request {
        var phone: String
        var email: String
        var name: String
        var lastName: String
        var city: String
        var landMark: String
        var state : String
        var address: String
        var area: String
        var pinCode: String
        var dateofBirth: String
        var marrigeAni: String
        var whatsAppNumber: String
        var areaid: String
        var lat: String
        var long: String
        var mapLocation: String
        var imageData: Data
    }
    
    class ViewModel: WSResponseData {
    }
}
