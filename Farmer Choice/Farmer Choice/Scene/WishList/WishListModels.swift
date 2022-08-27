

import UIKit

enum ProductList {
    
    struct Request {
        var pageCode : String
        var catId: String
        var search: String
        var type: String
    }
    
    struct WishListRequest {
        var pageCode : String
        var type: String
    }
    
    struct LastChoiceRequest {
        var pageCode : String
    }
    
    struct BrandList {
        var brandId : String
        var type: String
        var pageCode : String
    }
    
    class WishListViewModel: WSResponseData {
        var total_whish_product : Int?
        var whish_product_list : [Product_list]?
        
        enum CodingKeys: String, CodingKey {
            
            case total_whish_product = "total_whish_product"
            case whish_product_list = "whish_product_list"
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            total_whish_product = try values.decodeIfPresent(Int.self, forKey: .total_whish_product)
            whish_product_list = try values.decodeIfPresent([Product_list].self, forKey: .whish_product_list)
        }
        
    }
    
    class ViewModel: WSResponseData {
        var cate_name : String?
        var cate_list : [Cate_list]?
        var subcate_list : [Subcate_list]?
        var product_list : [Product_list]?
        var total_product : Int?
        
        enum CodingKeys: String, CodingKey {
            
            case cate_name = "cate_name"
            case cate_list = "cate_list"
            case subcate_list = "subcate_list"
            case product_list = "product_list"
            case total_product = "total_product"
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            cate_name = try values.decodeIfPresent(String.self, forKey: .cate_name)
            cate_list = try values.decodeIfPresent([Cate_list].self, forKey: .cate_list)
            subcate_list = try values.decodeIfPresent([Subcate_list].self, forKey: .subcate_list)
            product_list = try values.decodeIfPresent([Product_list].self, forKey: .product_list)
            total_product = try values.decodeIfPresent(Int.self, forKey: .total_product)
        }
        
    }
    
    struct Subcate_list : Codable {
        let subcatID : String?
        let name : String?
        let icon : String?
        let status : String?
        
        enum CodingKeys: String, CodingKey {
            
            case subcatID = "subcatID"
            case name = "name"
            case icon = "icon"
            case status = "status"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            subcatID = try values.decodeIfPresent(String.self, forKey: .subcatID)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            icon = try values.decodeIfPresent(String.self, forKey: .icon)
            status = try values.decodeIfPresent(String.self, forKey: .status)
        }
        
    }
    
    
    struct Product_list : Codable {
        let productID : String?
        let whishID : String?
        let name : String?
        let caption : String?
        let image : String?
        var price_list : [Price_list]?
        let sold_out : String?
        var wishlist : String?
        var selectedProduct: Int?
        
        
        enum CodingKeys: String, CodingKey {
            case whishID = "whishID"
            case productID = "productID"
            case name = "name"
            case caption = "caption"
            case image = "image"
            case price_list = "price_list"
            case sold_out = "sold_out"
            case wishlist = "wishlist"
            case selectedProduct = "selectedProduct"
            
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            productID = try values.decodeIfPresent(String.self, forKey: .productID)
            whishID = try values.decodeIfPresent(String.self, forKey: .whishID)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            caption = try values.decodeIfPresent(String.self, forKey: .caption)
            image = try values.decodeIfPresent(String.self, forKey: .image)
            price_list = try values.decodeIfPresent([Price_list].self, forKey: .price_list)
            sold_out = try values.decodeIfPresent(String.self, forKey: .sold_out)
            wishlist = try values.decodeIfPresent(String.self, forKey: .wishlist)
            selectedProduct = try values.decodeIfPresent(Int.self, forKey: .selectedProduct)
            
        }
        
    }
    
    
    struct Price_list : Codable {
        let sr : String?
        let price_ID : String?
        let price : String?
        let mrp : String?
        let weight : String?
        let dis : String?
        var cart_qty : String?
        var maxQty: String?
        
        enum CodingKeys: String, CodingKey {
            
            case sr = "sr"
            case price_ID = "price_ID"
            case price = "price"
            case mrp = "mrp"
            case weight = "weight"
            case dis = "dis"
            case cart_qty = "cart_qty"
            case maxQty = "max_qty"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            sr = try values.decodeIfPresent(String.self, forKey: .sr)
            price_ID = try values.decodeIfPresent(String.self, forKey: .price_ID)
            price = try values.decodeIfPresent(String.self, forKey: .price)
            mrp = try values.decodeIfPresent(String.self, forKey: .mrp)
            weight = try values.decodeIfPresent(String.self, forKey: .weight)
            dis = try values.decodeIfPresent(String.self, forKey: .dis)
            cart_qty = try values.decodeIfPresent(String.self, forKey: .cart_qty)
            maxQty = try values.decodeIfPresent(String.self, forKey: .maxQty)
        }
        
    }
    
    
    struct Cate_list : Codable {
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
            name = try values.decodeIfPresent(String.self, forKey: .name)
            icon = try values.decodeIfPresent(String.self, forKey: .icon)
        }
        
    }
    
}


enum AddCart {
    
    struct Request {
        var productId : String
        var priceID: String
        var qtyType: String
        var cartQty: String
    }
    
    class ViewModel: WSResponseData {
        var cart_amount : String?
        var cart_items : String?
        var product_line_total: String?
        
        var product_line_single: String?
        
        enum CodingKeys: String, CodingKey {
            case cart_amount = "cart_amount"
            case cart_items = "cart_items"
            case product_line_total = "product_line_total"
            case product_line_single = "product_line_single"
            
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            cart_amount = try values.decodeIfPresent(String.self, forKey: .cart_amount)
            cart_items = try values.decodeIfPresent(String.self, forKey: .cart_items)
            product_line_total = try values.decodeIfPresent(String.self, forKey: .product_line_total)
            product_line_single = try values.decodeIfPresent(String.self, forKey: .product_line_single)
        }
        
    }
}


enum AddRemoveWishList {
    
    struct Request {
        var productId : String
        var pageType: String
        var wishId: String
    }
    
    class ViewModel: WSResponseData {
    }
}
