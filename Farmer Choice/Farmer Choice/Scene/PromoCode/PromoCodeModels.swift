

import UIKit

enum PromoCode {
    
    class ViewModel: WSResponseData {
        var coupon_list : [Coupon_list]?
        
        enum CodingKeys: String, CodingKey {
            
            case coupon_list = "coupon_list"
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            coupon_list = try values.decodeIfPresent([Coupon_list].self, forKey: .coupon_list)
        }
        
    }
    
    struct Coupon_list : Codable {
        let sr : Int?
        let couponID : String?
        let code : String?
        let msg : String?
        let expire_msg : String?
        
        enum CodingKeys: String, CodingKey {
            
            case sr = "sr"
            case couponID = "couponID"
            case code = "code"
            case msg = "msg"
            case expire_msg = "expire_msg"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            sr = try values.decodeIfPresent(Int.self, forKey: .sr)
            couponID = try values.decodeIfPresent(String.self, forKey: .couponID)
            code = try values.decodeIfPresent(String.self, forKey: .code)
            msg = try values.decodeIfPresent(String.self, forKey: .msg)
            expire_msg = try values.decodeIfPresent(String.self, forKey: .expire_msg)
        }
        
    }
    
}


enum PromoCodeApply {
    struct Request {
        var code: String
    }
    class ViewModel: WSResponseData {
        var coupon_id : String?
        var coupon_value : String?
        var coupon_msg : String?
        
        enum CodingKeys: String, CodingKey {
            
            case coupon_id = "coupon_id"
            case coupon_value = "coupon_value"
            case coupon_msg = "coupon_msg"
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            coupon_id = try values.decodeIfPresent(String.self, forKey: .coupon_id)
            coupon_value = try values.decodeIfPresent(String.self, forKey: .coupon_value)
            coupon_msg = try values.decodeIfPresent(String.self, forKey: .coupon_msg)
        }
    }
    
}
