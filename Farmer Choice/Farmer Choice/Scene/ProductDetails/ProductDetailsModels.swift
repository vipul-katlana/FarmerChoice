
import UIKit

enum ProductDetails {
    struct Request {
        var productId: String
    }
    
    
    class ViewModel: WSResponseData {
        var product : [ProductList]?
        
        enum CodingKeys: String, CodingKey {
            case product = "product"
            
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            product = try values.decodeIfPresent([ProductList].self, forKey: .product)
        }
        
    }
    
    
    struct ProductList : Codable {
        let productID : String?
        let name : String?
        let caption : String?
        let image : String?
        var price_list : [Price_list]?
        let sold_out : String?
        var wishlist : String?
        var image_list: [ImageList]?
        var description: String?
        var selectedProduct: Int?
        
        
        enum CodingKeys: String, CodingKey {
            case productID = "productID"
            case name = "name"
            case caption = "caption"
            case image = "image"
            case price_list = "price_list"
            case sold_out = "sold_out"
            case wishlist = "wishlist"
            case image_list = "image_list"
            case description = "description"
            case selectedProduct = "selectedProduct"
            
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            productID = try values.decodeIfPresent(String.self, forKey: .productID)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            caption = try values.decodeIfPresent(String.self, forKey: .caption)
            image = try values.decodeIfPresent(String.self, forKey: .image)
            price_list = try values.decodeIfPresent([Price_list].self, forKey: .price_list)
            sold_out = try values.decodeIfPresent(String.self, forKey: .sold_out)
            wishlist = try values.decodeIfPresent(String.self, forKey: .wishlist)
            image_list = try values.decodeIfPresent([ImageList].self, forKey: .image_list)
            
            description = try values.decodeIfPresent(String.self, forKey: .description)
            
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
    
    
    struct ImageList : Codable {
        let sr : String?
        let small_image : String?
        let large_image : String?
        
        
        enum CodingKeys: String, CodingKey {
            case sr = "sr"
            case small_image = "small_image"
            case large_image = "large_image"
            
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            sr = try values.decodeIfPresent(String.self, forKey: .sr)
            small_image = try values.decodeIfPresent(String.self, forKey: .small_image)
            large_image = try values.decodeIfPresent(String.self, forKey: .large_image)
            
        }
        
    }
    
}


enum RelatedProduct {
    struct Request {
        var productId : String
    }
    
    class ViewModel: WSResponseData {
        var category_products : [CategoryProducts]?
        
        enum CodingKeys: String, CodingKey {
            
            case category_products = "related_product"
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            category_products = try values.decodeIfPresent([CategoryProducts].self, forKey: .category_products)
        }
        
    }
    
    
    struct CategoryProducts : Codable {
        let productID : String?
        let name : String?
        let caption : String?
        let image : String?
        let discount : String?
        let price : String?
        let mrp : String?
        let sold_out : String?
        var price_list : [Price_list]?
        var wishlist : String?
        var selectedProduct: Int?
        
        
        enum CodingKeys: String, CodingKey {
            
            case productID = "productID"
            case name = "name"
            case caption = "caption"
            case image = "image"
            case discount = "discount"
            case price = "price"
            case mrp = "mrp"
            case sold_out = "sold_out"
            case price_list = "price_list"
            case wishlist = "wishlist"
            case selectedProduct = "selectedProduct"
            
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            productID = try values.decodeIfPresent(String.self, forKey: .productID)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            caption = try values.decodeIfPresent(String.self, forKey: .caption)
            image = try values.decodeIfPresent(String.self, forKey: .image)
            discount = try values.decodeIfPresent(String.self, forKey: .discount)
            price = try values.decodeIfPresent(String.self, forKey: .price)
            mrp = try values.decodeIfPresent(String.self, forKey: .mrp)
            sold_out = try values.decodeIfPresent(String.self, forKey: .sold_out)
            price_list = try values.decodeIfPresent([Price_list].self, forKey: .price_list)
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
}
