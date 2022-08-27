
import UIKit

enum MyAccountDetails {
    struct Request {
        var userPhone: String
    }
    
    class ViewModel: WSResponseData {
        var ship_charge_note : String?
        var tomorrow_day : Int?
        var next_days : String?
        var get_detail : [Get_detail]?
        var data : String?
        var time_slot_msg : String?
        var order_note : String?
        var order_time_msg : String?
        
        enum CodingKeys: String, CodingKey {
            
            case ship_charge_note = "ship_charge_note"
            case tomorrow_day = "tomorrow_day"
            case next_days = "next_days"
            case get_detail = "get_detail"
            case data = "data"
            case time_slot_msg = "time_slot_msg"
            case order_note = "order_note"
            case order_time_msg = "order_time_msg"
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            ship_charge_note = try values.decodeIfPresent(String.self, forKey: .ship_charge_note)
            tomorrow_day = try values.decodeIfPresent(Int.self, forKey: .tomorrow_day)
            next_days = try values.decodeIfPresent(String.self, forKey: .next_days)
            get_detail = try values.decodeIfPresent([Get_detail].self, forKey: .get_detail)
            data = try values.decodeIfPresent(String.self, forKey: .data)
            time_slot_msg = try values.decodeIfPresent(String.self, forKey: .time_slot_msg)
            order_note = try values.decodeIfPresent(String.self, forKey: .order_note)
            order_time_msg = try values.decodeIfPresent(String.self, forKey: .order_time_msg)
        }
    }
    
    struct Get_detail : Codable {
        let userimage : String?
        let name : String?
        let phone : String?
        let email : String?
        let flat_no : String?
        let landmark : String?
        let address : String?
        let area : String?
        let area_id : String?
        let city : String?
        let state : String?
        let pincode : String?
        let wallet : String?
        let whatsapp_no : String?
        let date_of_birth : String?
        let mrg_anniversary : String?
        let ship_charge : String?
        let lat : String?
        let longi : String?
        let mapLocation : String?
        var cityID: String?
        
        enum CodingKeys: String, CodingKey {
            
            case userimage = "userimage"
            case name = "name"
            case phone = "phone"
            case email = "email"
            case flat_no = "flat_no"
            case landmark = "landmark"
            case address = "address"
            case area = "area"
            case area_id = "area_id"
            case city = "city"
            case state = "state"
            case pincode = "pincode"
            case wallet = "wallet"
            case whatsapp_no = "whatsapp_no"
            case date_of_birth = "date_of_birth"
            case mrg_anniversary = "mrg_anniversary"
            case ship_charge = "ship_charge"
            case lat = "lat"
            case longi = "longi"
            case mapLocation = "mapLocation"
            case cityID = "cityID"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            userimage = try values.decodeIfPresent(String.self, forKey: .userimage)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            phone = try values.decodeIfPresent(String.self, forKey: .phone)
            email = try values.decodeIfPresent(String.self, forKey: .email)
            flat_no = try values.decodeIfPresent(String.self, forKey: .flat_no)
            landmark = try values.decodeIfPresent(String.self, forKey: .landmark)
            address = try values.decodeIfPresent(String.self, forKey: .address)
            area = try values.decodeIfPresent(String.self, forKey: .area)
            area_id = try values.decodeIfPresent(String.self, forKey: .area_id)
            city = try values.decodeIfPresent(String.self, forKey: .city)
            state = try values.decodeIfPresent(String.self, forKey: .state)
            pincode = try values.decodeIfPresent(String.self, forKey: .pincode)
            wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
            whatsapp_no = try values.decodeIfPresent(String.self, forKey: .whatsapp_no)
            date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
            mrg_anniversary = try values.decodeIfPresent(String.self, forKey: .mrg_anniversary)
            ship_charge = try values.decodeIfPresent(String.self, forKey: .ship_charge)
            lat = try values.decodeIfPresent(String.self, forKey: .lat)
            longi = try values.decodeIfPresent(String.self, forKey: .longi)
            mapLocation = try values.decodeIfPresent(String.self, forKey: .mapLocation)
            cityID = try values.decodeIfPresent(String.self, forKey: .cityID)
        }
        
    }
    
}

