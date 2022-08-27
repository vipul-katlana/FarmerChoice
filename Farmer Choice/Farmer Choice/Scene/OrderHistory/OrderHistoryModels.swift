

import UIKit

enum OrderHistory {
    
    struct Request {
        var pageCode: String
    }
    
    class ViewModel: WSResponseData {
        var orderList: [OrderList]?
        
        enum CodingKeys: String, CodingKey {
            case order_list
        }
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            orderList = try values.decodeIfPresent([OrderList].self, forKey: .order_list)
        }
    }
    
    class OrderList: Codable {
        var OrderID : Int?
        var orderPlaceOn: String?
        var orderScheduled: String?
        var orderNo: String?
        var status: String?
        var products: String?
        var delivery_charges: String?
        var final_pay_amount: String?
        var paid_by: String?
        var feedback_btn: String?
        var cancel_btn: String?
        var help_btn: String?
        var reorder_btn: String?
        
        enum CodingKeys: String, CodingKey {
            case OrderID
            case orderPlaceOn
            case orderScheduled
            case orderNo
            case status
            case products
            case delivery_charges
            case final_pay_amount
            case paid_by
            case feedback_btn
            case cancel_btn
            case help_btn
            case reorder_btn
        }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            OrderID = try values.decodeIfPresent(Int.self, forKey: .OrderID)
            orderPlaceOn = try values.decodeIfPresent(String.self, forKey: .orderPlaceOn)
            orderScheduled = try values.decodeIfPresent(String.self, forKey: .orderScheduled)
            orderNo = try values.decodeIfPresent(String.self, forKey: .orderNo)
            status = try values.decodeIfPresent(String.self, forKey: .status)
            products = try values.decodeIfPresent(String.self, forKey: .products)
            delivery_charges = try values.decodeIfPresent(String.self, forKey: .delivery_charges)
            final_pay_amount = try values.decodeIfPresent(String.self, forKey: .final_pay_amount)
            paid_by = try values.decodeIfPresent(String.self, forKey: .paid_by)
            feedback_btn = try values.decodeIfPresent(String.self, forKey: .feedback_btn)
            cancel_btn = try values.decodeIfPresent(String.self, forKey: .cancel_btn)
            help_btn = try values.decodeIfPresent(String.self, forKey: .help_btn)
            reorder_btn = try values.decodeIfPresent(String.self, forKey: .reorder_btn)
            
            
        }
        
    }
}

enum CancelOrder {
    struct Request {
        var reason: String
        var orderId: String
    }
    
    class ViewModel: WSResponseData {
        
    }
}

enum ReOrder {
    struct Request {
        var orderId: String
    }
    
    class ViewModel: WSResponseData {
        var cart_items : String?
        var cart_amount : String?
        
        enum CodingKeys: String, CodingKey {
            case cart_items = "cart_items"
            case cart_amount = "cart_amount"
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            cart_items = try values.decodeIfPresent(String.self, forKey: .cart_items)
            cart_amount = try values.decodeIfPresent(String.self, forKey: .cart_amount)
        }
    }
}
