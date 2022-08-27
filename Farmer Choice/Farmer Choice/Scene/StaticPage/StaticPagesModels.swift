

import UIKit

enum StaticPages {
    
    class ViewModel: WSResponseData {
        var about : [About]?
        
        enum CodingKeys: String, CodingKey {
            case about = "about"
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            about = try values.decodeIfPresent([About].self, forKey: .about)
        }
    }
    
    struct About : Codable {
        let image : String?
        let text : String?
        let facebook_link : String?
        let google_link : String?
        let linkdin_link : String?
        let twitter_link : String?
        let insta_link : String?
        
        enum CodingKeys: String, CodingKey {
            
            case image = "image"
            case text = "text"
            case facebook_link = "facebook_link"
            case google_link = "google_link"
            case linkdin_link = "linkdin_link"
            case twitter_link = "twitter_link"
            case insta_link = "insta_link"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            image = try values.decodeIfPresent(String.self, forKey: .image)
            text = try values.decodeIfPresent(String.self, forKey: .text)
            facebook_link = try values.decodeIfPresent(String.self, forKey: .facebook_link)
            google_link = try values.decodeIfPresent(String.self, forKey: .google_link)
            linkdin_link = try values.decodeIfPresent(String.self, forKey: .linkdin_link)
            twitter_link = try values.decodeIfPresent(String.self, forKey: .twitter_link)
            insta_link = try values.decodeIfPresent(String.self, forKey: .insta_link)
        }
        
    }
    
}
