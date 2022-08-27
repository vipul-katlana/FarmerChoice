

import UIKit

enum ReferEarn {
    
    class ViewModel: WSResponseData {
        var shareData: [ShareData]?
        
        enum CodingKeys: String, CodingKey {
            case share_data
        }
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            shareData = try values.decodeIfPresent([ShareData].self, forKey: .share_data)
        }
        public override func encode(to encoder: Encoder) throws {
            try super.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(shareData, forKey: .share_data)
        }
    }
    
    class ShareData: Codable {
        var image : String?
        var message: String?
        var display_message: String?
        var share_image: String?
        var ref_key: String?
        var you_get: String?
        var you_friend_get: String?
        
        enum CodingKeys: String, CodingKey {
            case image
            case message
            case display_message
            case share_image
            case ref_key
            case you_get
            case you_friend_get
        }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            image = try values.decodeIfPresent(String.self, forKey: .image)
            message = try values.decodeIfPresent(String.self, forKey: .message)
            display_message = try values.decodeIfPresent(String.self, forKey: .display_message)
            share_image = try values.decodeIfPresent(String.self, forKey: .share_image)
            ref_key = try values.decodeIfPresent(String.self, forKey: .ref_key)
            you_get = try values.decodeIfPresent(String.self, forKey: .you_get)
            you_friend_get = try values.decodeIfPresent(String.self, forKey: .you_friend_get)
            
        }
        
    }
}

