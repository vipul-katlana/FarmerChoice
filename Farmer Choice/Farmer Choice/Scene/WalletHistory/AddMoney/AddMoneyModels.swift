

import UIKit

enum PaytmIntegration {
    
    struct Request {
        var amount: String
    }
    
    
    class ViewModel: WSResponseData {
        
        var cashfree_Mode : String?
        var cashfree_clientID : String?
        var cashfree_clientSecret : String?
        var orderAmount : String?
        var orderId : String?
        var token: String?
        var orderCurrency : String?
        var orderNote : String?
        var customerName : String?
        var customerEmail : String?
        var customerPhone : String?
        var SuccessFailUrl: String?
        var notifyUrl: String?
        var razorpayOrderId: String?
        
        
        enum CodingKeys: String, CodingKey {
            case cashfree_Mode = "cashfree_Mode"
            case cashfree_clientID = "cashfree_clientID"
            case cashfree_clientSecret = "cashfree_clientSecret"
            case orderAmount = "orderAmount"
            case orderId = "orderId"
            case orderCurrency = "orderCurrency"
            case orderNote = "orderNote"
            case customerName = "customerName"
            case customerEmail = "customerEmail"
            case customerPhone = "customerPhone"
            case SuccessFailUrl
            case notifyUrl
            case token
            case razorpayOrderId
            
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            cashfree_Mode = try values.decodeIfPresent(String.self, forKey: .cashfree_Mode)
            cashfree_clientID = try values.decodeIfPresent(String.self, forKey: .cashfree_clientID)
            cashfree_clientSecret = try values.decodeIfPresent(String.self, forKey: .cashfree_clientSecret)
            orderAmount = try values.decodeIfPresent(String.self, forKey: .orderAmount)
            orderId = try values.decodeIfPresent(String.self, forKey: .orderId)
            orderCurrency = try values.decodeIfPresent(String.self, forKey: .orderCurrency)
            orderNote = try values.decodeIfPresent(String.self, forKey: .orderNote)
            customerName = try values.decodeIfPresent(String.self, forKey: .customerName)
            customerEmail = try values.decodeIfPresent(String.self, forKey: .customerEmail)
            customerPhone = try values.decodeIfPresent(String.self, forKey: .customerPhone)
            SuccessFailUrl = try values.decodeIfPresent(String.self, forKey: .SuccessFailUrl)
            notifyUrl = try values.decodeIfPresent(String.self, forKey: .notifyUrl)
            token = try values.decodeIfPresent(String.self, forKey: .token)
            razorpayOrderId = try values.decodeIfPresent(String.self, forKey: .razorpayOrderId)
        }
    }
}


enum PaytmOrderResult {
    
    struct Request {
        var orderId: String
        var orderAmount: String
        var referenceId: String
        var txStatus: String
        var paymentMode: String
        var txMsg: String
        var txTime: String
        var signature: String
        
        var rozerPayId: String
    }
    
    
    class ViewModel: WSResponseData {
        
        var payment_status : String?
        var msg1 : String?
        var msg2 : String?
        
        enum CodingKeys: String, CodingKey {
            case payment_status = "payment_status"
            case msg1 = "msg1"
            case msg2 = "msg2"
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
            msg1 = try values.decodeIfPresent(String.self, forKey: .msg1)
            msg2 = try values.decodeIfPresent(String.self, forKey: .msg2)
        }
    }
}
