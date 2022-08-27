

import UIKit

enum Brand {
    // MARK: Use cases
    
    struct Request {
        var pageCode: Int
    }
    
    class ViewModel: WSResponseData {
        
        var brand_list : [Brand_list]?
        
        enum CodingKeys: String, CodingKey {
            
            case brand_list = "brand_list"
            
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            brand_list = try values.decodeIfPresent([Brand_list].self, forKey: .brand_list)
            
        }
        
    }
    
    struct Brand_list : Codable {
        let brandID : String?
        let name : String?
        let image : String?
        
        
        enum CodingKeys: String, CodingKey {
            
            case brandID = "brandID"
            case name = "name"
            case image = "image"
            
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            brandID = try values.decodeIfPresent(String.self, forKey: .brandID)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            image = try values.decodeIfPresent(String.self, forKey: .image)
            
        }
        
    }
    
}
