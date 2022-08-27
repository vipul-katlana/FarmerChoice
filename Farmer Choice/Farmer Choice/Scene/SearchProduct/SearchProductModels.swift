

import UIKit

enum SearchProduct {
    
    struct Request {
        var pageCount: Int
    }
    class ViewModel: WSResponseData {
        var search_list : [SearchList]?
        
        enum CodingKeys: String, CodingKey {
            case search_list = "search_list"
            
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            search_list = try values.decodeIfPresent([SearchList].self, forKey: .search_list)
        }
        
    }
    
    struct SearchList : Codable {
        let ID : String?
        let name : String?
        let type : String?
        
        
        enum CodingKeys: String, CodingKey {
            
            case ID = "ID"
            case name = "name"
            case type = "type"
            
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            ID = try values.decodeIfPresent(String.self, forKey: .ID)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            type = try values.decodeIfPresent(String.self, forKey: .type)
            
        }
        
    }
    
    
}
