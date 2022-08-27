

import UIKit

enum Login {
    
    struct Request {
        var phoneNumber : String
    }
    
    class ViewModel: WSResponseData {
        var user_detail: [UserDetails]?
        var screen_type: String?
        
        enum CodingKeys: String, CodingKey {
            case user_detail
            case screen_type
        }
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            user_detail = try values.decodeIfPresent([UserDetails].self, forKey: .user_detail)
            screen_type = try values.decodeIfPresent(String.self, forKey: .screen_type)
        }
        public override func encode(to encoder: Encoder) throws {
            try super.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(user_detail, forKey: .user_detail)
        }
    }
    
    class UserDetails: Codable {
        var userId : String?
        var phone: String?
        var name: String?
        var lastname: String?
        var email: String?
        var userimage: String?
        var otp: String?
        var mobile_type: String?
        
        
        enum CodingKeys: String, CodingKey {
            case userID
            case phone
            case name
            case lastname
            case email
            case userimage
            case otp
            case mobile_type
            
        }
        
        required init(from decoder: Decoder) throws {
            // try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            userId = try values.decodeIfPresent(String.self, forKey: .userID)
            phone = try values.decodeIfPresent(String.self, forKey: .phone)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            lastname = try values.decodeIfPresent(String.self, forKey: .lastname)
            email = try values.decodeIfPresent(String.self, forKey: .email)
            userimage = try values.decodeIfPresent(String.self, forKey: .userimage)
            otp = try values.decodeIfPresent(String.self, forKey: .otp)
            mobile_type = try values.decodeIfPresent(String.self, forKey: .mobile_type)
            
            
        }
        
        public func encode(to encoder: Encoder) throws {
            //try super.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(userId, forKey: .userID)
            try container.encode(phone, forKey: .phone)
            try container.encode(name, forKey: .name)
            try container.encode(lastname, forKey: .lastname)
            try container.encode(email, forKey: .email)
            try container.encode(userimage, forKey: .userimage)
            try container.encode(otp, forKey: .otp)
            try container.encode(mobile_type, forKey: .mobile_type)
            
        }
    }
}

enum SignUp {
    
    struct Request {
        var name : String
        var email: String
        var phone: String
        var referCode: String
    }
    
    class ViewModel: WSResponseData {
        var user_detail: [Login.UserDetails]?
        
        enum CodingKeys: String, CodingKey {
            case user_detail
        }
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            user_detail = try values.decodeIfPresent([Login.UserDetails].self, forKey: .user_detail)
        }
        public override func encode(to encoder: Encoder) throws {
            try super.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(user_detail, forKey: .user_detail)
        }
    }

}
