

import UIKit

enum Category {
    
    class ViewModel: WSResponseData {
        var categoryList: [CategoryList]?
        
        enum CodingKeys: String, CodingKey {
            case category_list_new
        }
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            categoryList = try values.decodeIfPresent([CategoryList].self, forKey: .category_list_new)
        }
        public override func encode(to encoder: Encoder) throws {
            try super.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(categoryList, forKey: .category_list_new)
        }
    }
    
    class CategoryList: Codable {
        var catID : String?
        var name: String?
        var icon: String?
        var subcat: String?
        var isExpand : Int?
        var subcat_list: [SubCategory]?
        
        enum CodingKeys: String, CodingKey {
            case catID
            case name
            case icon
            case subcat
            case subcat_list
            case isExpand
        }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            catID = try values.decodeIfPresent(String.self, forKey: .catID)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            icon = try values.decodeIfPresent(String.self, forKey: .icon)
            subcat = try values.decodeIfPresent(String.self, forKey: .subcat)
            subcat_list = try values.decodeIfPresent([SubCategory].self, forKey: .subcat_list)
            isExpand = try values.decodeIfPresent(Int.self, forKey: .isExpand)
            
        }
        
    }
    
    struct SubCategory : Codable {
        let catID : String?
        let name : String?
        let icon : String?
        let subcat : String?
        var isExpand: Int?
        var subcat_list: [SubCategorySecond]?
        
        enum CodingKeys: String, CodingKey {
            case catID = "catID"
            case name = "name"
            case icon = "icon"
            case subcat_list = "subsubcat_list"
            case subcat = "subsubcat"
            case isExpand
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            catID = try values.decodeIfPresent(String.self, forKey: .catID)
            icon = try values.decodeIfPresent(String.self, forKey: .icon)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            subcat = try values.decodeIfPresent(String.self, forKey: .subcat)
            isExpand = try values.decodeIfPresent(Int.self, forKey: .isExpand)
            subcat_list = try values.decodeIfPresent([SubCategorySecond].self, forKey: .subcat_list)
        }
    }
    
    struct SubCategorySecond : Codable {
        let catID : String?
        let name : String?
        let icon : String?
        
        
        enum CodingKeys: String, CodingKey {
            case catID = "catID"
            case name = "name"
            case icon = "icon"
            
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            catID = try values.decodeIfPresent(String.self, forKey: .catID)
            icon = try values.decodeIfPresent(String.self, forKey: .icon)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            
        }
    }
}


