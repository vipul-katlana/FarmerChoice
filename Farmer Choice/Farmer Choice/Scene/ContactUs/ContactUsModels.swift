

import UIKit

enum ContactUs {
    
    class ViewModel: WSResponseData {
        var contact: [Contact]?
        
        enum CodingKeys: String, CodingKey {
            case contact
        }
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            contact = try values.decodeIfPresent([Contact].self, forKey: .contact)
        }
    }
    
    class Contact: Codable {
        var address_line1 : String?
        var address_line2: String?
        var address_line3: String?
        var email: String?
        var phone: String?
        var website: String?
        var call: String?
        var time: String?
        var image: String?
        
        enum CodingKeys: String, CodingKey {
            case address_line1
            case address_line2
            case address_line3
            case email
            case phone
            case website
            case call
            case time
            case image
        }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            address_line1 = try values.decodeIfPresent(String.self, forKey: .address_line1)
            address_line2 = try values.decodeIfPresent(String.self, forKey: .address_line2)
            address_line3 = try values.decodeIfPresent(String.self, forKey: .address_line3)
            email = try values.decodeIfPresent(String.self, forKey: .email)
            phone = try values.decodeIfPresent(String.self, forKey: .phone)
            website = try values.decodeIfPresent(String.self, forKey: .website)
            call = try values.decodeIfPresent(String.self, forKey: .call)
            time = try values.decodeIfPresent(String.self, forKey: .time)
            image = try values.decodeIfPresent(String.self, forKey: .image)
            
        }
        
    }
}

