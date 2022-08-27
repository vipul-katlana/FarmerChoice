

import UIKit

enum PaymentOption {
    
    struct Request {
        var areaID: String
        var expressSelected: String
    }
    
    class ViewModel: WSResponseData {
        var final_charges : [Final_charges]?
        
        enum CodingKeys: String, CodingKey {
            
            case final_charges = "final_charges"
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            final_charges = try values.decodeIfPresent([Final_charges].self, forKey: .final_charges)
        }
    }
    
    struct Final_charges : Codable {
        let show_coupon_list : String?
        let wallet_option : String?
        let display_wallet_bal : String?
        let wallet_bal : String?
        let wallet_label : String?
        let wallet_text : String?
        
        let super_wallet_option : String?
        let super_wallet_bal : String?
        let super_wallet_label : String?
        let super_wallet_text : String?
        
        let coupon : String?
        let cod : String?
        let cod_label : String?
        let cod_text : String?
        let paytm : String?
        let paytm_label : String?
        let paytm_text : String?
        let payu : String?
        let payu_label : String?
        let payu_text : String?
        let area_charge : String?
        let express : String?
        let express_charges : String?
        let express_label : String?
        let bag : String?
        let bag_charges_auto : String?
        let bag_charges : String?
        let bag_label : String?
        let bag_text : String?
        
        enum CodingKeys: String, CodingKey {
            
            case show_coupon_list = "show_coupon_list"
            case wallet_option = "wallet_option"
            case display_wallet_bal = "display_wallet_bal"
            case wallet_bal = "wallet_bal"
            case wallet_label = "wallet_label"
            case wallet_text = "wallet_text"
            
            case super_wallet_option = "super_wallet_option"
            case super_wallet_bal = "super_wallet_bal"
            case super_wallet_label = "super_wallet_label"
            case super_wallet_text = "super_wallet_text"
            
            case coupon = "coupon"
            case cod = "cod"
            case cod_label = "cod_label"
            case cod_text = "cod_text"
            case paytm = "paytm"
            case paytm_label = "paytm_label"
            case paytm_text = "paytm_text"
            case payu = "payu"
            case payu_label = "payu_label"
            case payu_text = "payu_text"
            case area_charge = "area_charge"
            case express = "express"
            case express_charges = "express_charges"
            case express_label = "express_label"
            case bag = "bag"
            case bag_charges_auto = "bag_charges_auto"
            case bag_charges = "bag_charges"
            case bag_label = "bag_label"
            case bag_text = "bag_text"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            show_coupon_list = try values.decodeIfPresent(String.self, forKey: .show_coupon_list)
            wallet_option = try values.decodeIfPresent(String.self, forKey: .wallet_option)
            display_wallet_bal = try values.decodeIfPresent(String.self, forKey: .display_wallet_bal)
            wallet_bal = try values.decodeIfPresent(String.self, forKey: .wallet_bal)
            wallet_label = try values.decodeIfPresent(String.self, forKey: .wallet_label)
            wallet_text = try values.decodeIfPresent(String.self, forKey: .wallet_text)
            
            super_wallet_option = try values.decodeIfPresent(String.self, forKey: .super_wallet_option)
            super_wallet_bal = try values.decodeIfPresent(String.self, forKey: .super_wallet_bal)
            super_wallet_label = try values.decodeIfPresent(String.self, forKey: .super_wallet_label)
            super_wallet_text = try values.decodeIfPresent(String.self, forKey: .super_wallet_text)
            
            coupon = try values.decodeIfPresent(String.self, forKey: .coupon)
            cod = try values.decodeIfPresent(String.self, forKey: .cod)
            cod_label = try values.decodeIfPresent(String.self, forKey: .cod_label)
            cod_text = try values.decodeIfPresent(String.self, forKey: .cod_text)
            paytm = try values.decodeIfPresent(String.self, forKey: .paytm)
            paytm_label = try values.decodeIfPresent(String.self, forKey: .paytm_label)
            paytm_text = try values.decodeIfPresent(String.self, forKey: .paytm_text)
            payu = try values.decodeIfPresent(String.self, forKey: .payu)
            payu_label = try values.decodeIfPresent(String.self, forKey: .payu_label)
            payu_text = try values.decodeIfPresent(String.self, forKey: .payu_text)
            area_charge = try values.decodeIfPresent(String.self, forKey: .area_charge)
            express = try values.decodeIfPresent(String.self, forKey: .express)
            express_charges = try values.decodeIfPresent(String.self, forKey: .express_charges)
            express_label = try values.decodeIfPresent(String.self, forKey: .express_label)
            bag = try values.decodeIfPresent(String.self, forKey: .bag)
            bag_charges_auto = try values.decodeIfPresent(String.self, forKey: .bag_charges_auto)
            bag_charges = try values.decodeIfPresent(String.self, forKey: .bag_charges)
            bag_label = try values.decodeIfPresent(String.self, forKey: .bag_label)
            bag_text = try values.decodeIfPresent(String.self, forKey: .bag_text)
        }
        
    }
    
}

enum PlaceOrder {
    struct Request {
        var exp_delivery: String
        var bag_selected: String
        var wallet_selected: String
        var order_total: String
        var instruction: String
        var del_time: String
        var del_date: String
        var DIS_AMOUNT: String
        var DIS_ID: String
        var payment_method: String
        var super_wallet_selected: String
        var use_super_wallet: String
        var appVeriosn: String
        
        
    }
    
    class ViewModel: WSResponseData {
        var SuccessFailUrl : String?
        var cashfree_Mode: String?
        var cashfree_clientID: String?
        var cashfree_clientSecret: String?
        var customerEmail : String?
        var customerName : String?
        var customerPhone : String?
        var notifyUrl : String?
        var orderAmount : String?
        var orderCurrency : String?
        var orderId : String?
        var orderNote : String?
        var token : String?
        var orderMasterID: String?
        var razorpayOrderId: String?
        
        
        enum CodingKeys: String, CodingKey {
            
            case SuccessFailUrl = "SuccessFailUrl"
            case cashfree_Mode = "cashfree_Mode"
            case cashfree_clientID = "cashfree_clientID"
            case cashfree_clientSecret = "cashfree_clientSecret"
            case customerEmail = "customerEmail"
            case customerName = "customerName"
            case customerPhone = "customerPhone"
            case notifyUrl = "notifyUrl"
            case orderAmount = "orderAmount"
            case orderCurrency = "orderCurrency"
            case orderId = "orderId"
            case orderNote = "orderNote"
            case token = "token"
            case orderMasterID = "orderMasterID"
            case razorpayOrderId
            
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            SuccessFailUrl = try values.decodeIfPresent(String.self, forKey: .SuccessFailUrl)
            cashfree_Mode = try values.decodeIfPresent(String.self, forKey: .cashfree_Mode)
            cashfree_clientID = try values.decodeIfPresent(String.self, forKey: .cashfree_clientID)
            cashfree_clientSecret = try values.decodeIfPresent(String.self, forKey: .cashfree_clientSecret)
            customerEmail = try values.decodeIfPresent(String.self, forKey: .customerEmail)
            customerName = try values.decodeIfPresent(String.self, forKey: .customerName)
            customerPhone = try values.decodeIfPresent(String.self, forKey: .customerPhone)
            notifyUrl = try values.decodeIfPresent(String.self, forKey: .notifyUrl)
            orderAmount = try values.decodeIfPresent(String.self, forKey: .orderAmount)
            orderCurrency = try values.decodeIfPresent(String.self, forKey: .orderCurrency)
            orderId = try values.decodeIfPresent(String.self, forKey: .orderId)
            orderNote = try values.decodeIfPresent(String.self, forKey: .orderNote)
            token = try values.decodeIfPresent(String.self, forKey: .token)
            orderMasterID = try values.decodeIfPresent(String.self, forKey: .orderMasterID )
            razorpayOrderId = try values.decodeIfPresent(String.self, forKey: .razorpayOrderId )
        }
    }
}



