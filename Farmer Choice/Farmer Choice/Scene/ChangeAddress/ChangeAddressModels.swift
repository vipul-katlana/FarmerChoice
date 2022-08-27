

import UIKit

enum ChangeAddress {
    
    struct Request {
        var name:String
        var phone: String
        var city: String
        var address: String
        var area: String
        var area_id: String
        var pinCode: String
        var email: String
        var lat: String
        var long: String
        var mapLocation : String
        var landMark: String
    }
    
    class ViewModel: WSResponseData {
    }
}
