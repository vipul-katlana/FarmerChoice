

import UIKit

enum CartList {
    
    struct Request {
        var cartID: String
        var type: String
        
        var qty: String
    }
    
    class ViewModel: WSResponseData {
        
        var cart_items_list: [CartItemList]?
        var cart_items: String?
        var cart_amount: String?
        var area_ship_charge_msg: String?
        var area_ship_charge: String?
        var area_min_order: String?
        
        enum CodingKeys: String, CodingKey {
            case cart_items_list
            case cart_items
            case cart_amount
            case area_min_order
            case area_ship_charge
            case area_ship_charge_msg
        }
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            cart_items_list = try values.decodeIfPresent([CartItemList].self, forKey: .cart_items_list)
            cart_items = try values.decodeIfPresent(String.self, forKey: .cart_items)
            cart_amount = try values.decodeIfPresent(String.self, forKey: .cart_amount)
            area_min_order = try values.decodeIfPresent(String.self, forKey: .area_min_order)
            area_ship_charge = try values.decodeIfPresent(String.self, forKey: .area_ship_charge)
            area_ship_charge_msg = try values.decodeIfPresent(String.self, forKey: .area_ship_charge_msg)
        }
    }
    
    
    struct CartItemList: Codable {
        var cartID : String?
        var cart_image: String?
        var product_name: String?
        var product_information: String?
        var weight: String?
        var product_qty: String?
        var product_price: String?
        var line_total: String?
        var product_mrp: String?
        
        var btn_name: String?
        var item_notes: String?
        
        var maxQty: Int?
        
        enum CodingKeys: String, CodingKey {
            case cartID
            case cart_image
            case product_name
            case product_information
            case weight
            case product_qty
            case product_price
            case line_total
            case product_mrp
            
            case btn_name
            case item_notes
            case maxQty = "max_qty"
            
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            cartID = try values.decodeIfPresent(String.self, forKey: .cartID)
            cart_image = try values.decodeIfPresent(String.self, forKey: .cart_image)
            product_name = try values.decodeIfPresent(String.self, forKey: .product_name)
            product_information = try values.decodeIfPresent(String.self, forKey: .product_information)
            weight = try values.decodeIfPresent(String.self, forKey: .weight)
            product_qty = try values.decodeIfPresent(String.self, forKey: .product_qty)
            product_price = try values.decodeIfPresent(String.self, forKey: .product_price)
            line_total = try values.decodeIfPresent(String.self, forKey: .line_total)
            product_mrp = try values.decodeIfPresent(String.self, forKey: .product_mrp)
            
            
            btn_name = try values.decodeIfPresent(String.self, forKey: .btn_name)
            item_notes = try values.decodeIfPresent(String.self, forKey: .item_notes)
            
            maxQty = try values.decodeIfPresent(Int.self, forKey: .maxQty)
        }
    }
    
}
