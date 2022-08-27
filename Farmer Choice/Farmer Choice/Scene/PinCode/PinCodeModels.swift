
import UIKit

enum PinCode {
    
    struct Request {
        var areaId: String
    }
    
    class ViewModel: WSResponseData {
        var area_list : [Area_list]?
        var pincode_list : [Pincode_list]?
        
        enum CodingKeys: String, CodingKey {
            
            case area_list = "area_list"
            case pincode_list = "pincode_list"
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            area_list = try values.decodeIfPresent([Area_list].self, forKey: .area_list)
            pincode_list = try values.decodeIfPresent([Pincode_list].self, forKey: .pincode_list)
        }
        
    }
    
    struct Pincode_list : Codable {
        let pincodeID : String?
        let name : String?
        
        enum CodingKeys: String, CodingKey {
            
            case pincodeID = "pincodeID"
            case name = "name"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            pincodeID = try values.decodeIfPresent(String.self, forKey: .pincodeID)
            name = try values.decodeIfPresent(String.self, forKey: .name)
        }
        
    }
    struct Area_list : Codable {
        let areaID : String?
        let name : String?
        let shipping : String?
        let on_order : String?
        
        enum CodingKeys: String, CodingKey {
            
            case areaID = "areaID"
            case name = "name"
            case shipping = "shipping"
            case on_order = "on_order"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            areaID = try values.decodeIfPresent(String.self, forKey: .areaID)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            shipping = try values.decodeIfPresent(String.self, forKey: .shipping)
            on_order = try values.decodeIfPresent(String.self, forKey: .on_order)
        }
        
    }
}
