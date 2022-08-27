
import UIKit

enum OrdersDetails {
    
    struct Request {
        var orderId: String
    }
    
    class ViewModel: WSResponseData {
        var displayOrderID : String?
        var order_date : String?
        var delivery_time_label : String?
        var delivery_time_data : String?
        var current_track_status : String?
        var pay_label : String?
        var pay_icon : String?
        var pay_text : String?
        var final_total_data : [FinalTotalData]?
        var total_final_payble_text : String?
        var total_final_payble_amount : String?
        var total_final_payble_color : String?
        var total_final_saving_text : String?
        var total_final_saving_amount : String?
        var total_final_saving_color : String?
        var item : String?
        var item_amount : String?
        var products_list : [ProductsList]?
        var delivery_address : String?
        var cancel_btn : String?
        var return_btn : String?
        var change_date_btn : String?
        var feedback_btn_heading : String?
        var add_item_text : String?
        var add_item_text1 : String?
        
        enum CodingKeys: String, CodingKey {
            
            case displayOrderID = "displayOrderID"
            case order_date = "order_date"
            case delivery_time_label = "delivery_time_label"
            case delivery_time_data = "delivery_time_data"
            case current_track_status = "current_track_status"
            case pay_label = "pay_label"
            case pay_icon = "pay_icon"
            case pay_text = "pay_text"
            case final_total_data = "final_total_data"
            case total_final_payble_text = "total_final_payble_text"
            case total_final_payble_amount = "total_final_payble_amount"
            case total_final_payble_color = "total_final_payble_color"
            case total_final_saving_text = "total_final_saving_text"
            case total_final_saving_amount = "total_final_saving_amount"
            case total_final_saving_color = "total_final_saving_color"
            case item = "item"
            case item_amount = "item_amount"
            case products_list = "products_list"
            case delivery_address = "delivery_address"
            case cancel_btn = "cancel_btn"
            case return_btn = "return_btn"
            case change_date_btn = "change_date_btn"
            case feedback_btn_heading = "feedback_btn_heading"
            case add_item_text = "add_item_text"
            case add_item_text1 = "add_item_text1"
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            displayOrderID = try values.decodeIfPresent(String.self, forKey: .displayOrderID)
            order_date = try values.decodeIfPresent(String.self, forKey: .order_date)
            delivery_time_label = try values.decodeIfPresent(String.self, forKey: .delivery_time_label)
            delivery_time_data = try values.decodeIfPresent(String.self, forKey: .delivery_time_data)
            current_track_status = try values.decodeIfPresent(String.self, forKey: .current_track_status)
            pay_label = try values.decodeIfPresent(String.self, forKey: .pay_label)
            pay_icon = try values.decodeIfPresent(String.self, forKey: .pay_icon)
            pay_text = try values.decodeIfPresent(String.self, forKey: .pay_text)
            final_total_data = try values.decodeIfPresent([FinalTotalData].self, forKey: .final_total_data)
            total_final_payble_text = try values.decodeIfPresent(String.self, forKey: .total_final_payble_text)
            total_final_payble_amount = try values.decodeIfPresent(String.self, forKey: .total_final_payble_amount)
            total_final_payble_color = try values.decodeIfPresent(String.self, forKey: .total_final_payble_color)
            total_final_saving_text = try values.decodeIfPresent(String.self, forKey: .total_final_saving_text)
            total_final_saving_amount = try values.decodeIfPresent(String.self, forKey: .total_final_saving_amount)
            total_final_saving_color = try values.decodeIfPresent(String.self, forKey: .total_final_saving_color)
            item = try values.decodeIfPresent(String.self, forKey: .item)
            item_amount = try values.decodeIfPresent(String.self, forKey: .item_amount)
            products_list = try values.decodeIfPresent([ProductsList].self, forKey: .products_list)
            delivery_address = try values.decodeIfPresent(String.self, forKey: .delivery_address)
            cancel_btn = try values.decodeIfPresent(String.self, forKey: .cancel_btn)
            return_btn = try values.decodeIfPresent(String.self, forKey: .return_btn)
            change_date_btn = try values.decodeIfPresent(String.self, forKey: .change_date_btn)
            feedback_btn_heading = try values.decodeIfPresent(String.self, forKey: .feedback_btn_heading)
            add_item_text = try values.decodeIfPresent(String.self, forKey: .add_item_text)
            add_item_text1 = try values.decodeIfPresent(String.self, forKey: .add_item_text1)
        }
        
    }
    
    struct ProductsList : Codable {
        let sR : Int?
        let image : String?
        let name : String?
        let weight : String?
        let quantity : String?
        let price : String?
        let mrp : String?
        let line_total : String?
        
        enum CodingKeys: String, CodingKey {
            
            case sR = "SR"
            case image = "image"
            case name = "name"
            case weight = "weight"
            case quantity = "quantity"
            case price = "price"
            case mrp = "mrp"
            case line_total = "line_total"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            sR = try values.decodeIfPresent(Int.self, forKey: .sR)
            image = try values.decodeIfPresent(String.self, forKey: .image)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            weight = try values.decodeIfPresent(String.self, forKey: .weight)
            quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
            price = try values.decodeIfPresent(String.self, forKey: .price)
            mrp = try values.decodeIfPresent(String.self, forKey: .mrp)
            line_total = try values.decodeIfPresent(String.self, forKey: .line_total)
        }
        
    }
    
    struct FinalTotalData : Codable {
        let label : String?
        let amount : String?
        let type : String?
        let color : String?
        
        enum CodingKeys: String, CodingKey {
            
            case label = "label"
            case amount = "amount"
            case type = "type"
            case color = "color"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            label = try values.decodeIfPresent(String.self, forKey: .label)
            amount = try values.decodeIfPresent(String.self, forKey: .amount)
            type = try values.decodeIfPresent(String.self, forKey: .type)
            color = try values.decodeIfPresent(String.self, forKey: .color)
        }
        
    }
    
    
}
