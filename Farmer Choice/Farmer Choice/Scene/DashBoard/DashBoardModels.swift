

import UIKit

enum DashBoard {
    
    struct Request {
        var deviceId : String
        var tokenId: String
        var appVersion: String
    }
    
    class ViewModel: WSResponseData {
        var version : String?
        var version_msg : String?
        var iphone_version : String?
        var iphone_msg : String?
        var home_category_list : [Home_category_list]?
        var banner_list : [Banner_list]?
        var offer_banner : [Offer_banner]?
        var brand_list: [DashBoardBrandList]?
        var cart_amount : String?
        var cart_msg : String?
        var banner_bootom_image : String?
        var refer_image : String?
        var facebook_image : String?
        var facebook_link : String?
        var walvar : String?
        var dashboardMsg : String?
        var clearDatabase : String?
        var wallet: String?
        var iphone_update_force: String?
        var userCityId: String?
        var userCityName: String?
        
        
        enum CodingKeys: String, CodingKey {
            
            case version = "version"
            case version_msg = "version_msg"
            case iphone_version = "iphone_version"
            case iphone_msg = "iphone_msg"
            case iphone_update_force = "iphone_update_force"
            case home_category_list = "home_category_list"
            case banner_list = "banner_list"
            case brand_list = "brand_list"
            case offer_banner = "offer_banner"
            case cart_amount = "cart_amount"
            case cart_msg = "cart_msg"
            case banner_bootom_image = "banner_bootom_image"
            case refer_image = "refer_image"
            case facebook_image = "facebook_image"
            case facebook_link = "facebook_link"
            case walvar = "walvar"
            case dashboardMsg = "dashboardMsg"
            case clearDatabase = "ClearDatabase"
            case wallet = "wallet"
            case userCityId
            case userCityName
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            var values = try decoder.container(keyedBy: CodingKeys.self)
            version = try values.decodeIfPresent(String.self, forKey: .version)
            version_msg = try values.decodeIfPresent(String.self, forKey: .version_msg)
            iphone_version = try values.decodeIfPresent(String.self, forKey: .iphone_version)
            iphone_msg = try values.decodeIfPresent(String.self, forKey: .iphone_msg)
            home_category_list = try values.decodeIfPresent([Home_category_list].self, forKey: .home_category_list)
            banner_list = try values.decodeIfPresent([Banner_list].self, forKey: .banner_list)
            brand_list = try values.decodeIfPresent([DashBoardBrandList].self, forKey: .brand_list)
            offer_banner = try values.decodeIfPresent([Offer_banner].self, forKey: .offer_banner)
            cart_amount = try values.decodeIfPresent(String.self, forKey: .cart_amount)
            cart_msg = try values.decodeIfPresent(String.self, forKey: .cart_msg)
            banner_bootom_image = try values.decodeIfPresent(String.self, forKey: .banner_bootom_image)
            refer_image = try values.decodeIfPresent(String.self, forKey: .refer_image)
            facebook_image = try values.decodeIfPresent(String.self, forKey: .facebook_image)
            facebook_link = try values.decodeIfPresent(String.self, forKey: .facebook_link)
            walvar = try values.decodeIfPresent(String.self, forKey: .walvar)
            dashboardMsg = try values.decodeIfPresent(String.self, forKey: .dashboardMsg)
            clearDatabase = try values.decodeIfPresent(String.self, forKey: .clearDatabase)
            wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
            iphone_update_force = try values.decodeIfPresent(String.self, forKey: .iphone_update_force)
            userCityId = try values.decodeIfPresent(String.self, forKey: .userCityId)
            userCityName = try values.decodeIfPresent(String.self, forKey: .userCityName)
        }
        
    }
    
    struct DashBoardBrandList : Codable {
        let brandID : String?
        let name : String?
        let image : String?
        
        enum CodingKeys: String, CodingKey {
            
            case brandID = "brandID"
            case name = "name"
            case image = "image"
            
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            brandID = try values.decodeIfPresent(String.self, forKey: .brandID)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            image = try values.decodeIfPresent(String.self, forKey: .image)
            
        }
        
    }
    
    struct Offer_banner : Codable {
        let sr : String?
        let name : String?
        let image : String?
        let catID : String?
        
        enum CodingKeys: String, CodingKey {
            
            case sr = "sr"
            case name = "name"
            case image = "image"
            case catID = "catID"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            sr = try values.decodeIfPresent(String.self, forKey: .sr)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            image = try values.decodeIfPresent(String.self, forKey: .image)
            catID = try values.decodeIfPresent(String.self, forKey: .catID)
        }
        
    }
    
    struct Home_category_list : Codable {
        let catID : String?
        let name : String?
        let icon : String?
        let subcat : String?
        
        enum CodingKeys: String, CodingKey {
            
            case catID = "catID"
            case name = "name"
            case icon = "icon"
            case subcat = "subcat"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            catID = try values.decodeIfPresent(String.self, forKey: .catID)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            icon = try values.decodeIfPresent(String.self, forKey: .icon)
            subcat = try values.decodeIfPresent(String.self, forKey: .subcat)
        }
        
    }
    
    
    struct Banner_list : Codable {
        let sr : String?
        let name : String?
        let image : String?
        let catID : String?
        
        enum CodingKeys: String, CodingKey {
            
            case sr = "sr"
            case name = "name"
            case image = "image"
            case catID = "catID"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            sr = try values.decodeIfPresent(String.self, forKey: .sr)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            image = try values.decodeIfPresent(String.self, forKey: .image)
            catID = try values.decodeIfPresent(String.self, forKey: .catID)
        }
        
    }
    
    
}


enum DashBoardList {
    
    struct Request {
        var pageCode: Int
    }
    
    class ViewModel: WSResponseData {
        
        var home_category_products : [Home_category_products]?
        var categoy_master_list: [categoy_master_listArray]?
        
        enum CodingKeys: String, CodingKey {
            
            case home_category_products = "home_category_products"
            case categoy_master_list
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            home_category_products = try values.decodeIfPresent([Home_category_products].self, forKey: .home_category_products)
            categoy_master_list = try values.decodeIfPresent([categoy_master_listArray].self, forKey: .categoy_master_list)
        }
    }
    
    
    struct categoy_master_listArray : Codable {
        let catID : String?
        let category_name : String?
        let sub_category_list : [SubCategoryList]?
        
        enum CodingKeys: String, CodingKey {
            case catID = "catID"
            case category_name = "category_name"
            case sub_category_list = "sub_category_list"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            catID = try values.decodeIfPresent(String.self, forKey: .catID)
            category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
            sub_category_list = try values.decodeIfPresent([SubCategoryList].self, forKey: .sub_category_list)
        }
    }
    
    
    struct SubCategoryList: Codable {
        let catID : String?
        let category_name : String?
        let image : String?
        
        enum CodingKeys: String, CodingKey {
            case catID = "catID"
            case category_name = "category_name"
            case image = "image"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            catID = try values.decodeIfPresent(String.self, forKey: .catID)
            category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
            image = try values.decodeIfPresent(String.self, forKey: .image)
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
    
    
    struct OfferBanner : Codable {
        let sr : String?
        let name : String?
        let image : String?
        let catID : String?
        
        enum CodingKeys: String, CodingKey {
            
            case sr = "sr"
            case name = "name"
            case image = "image"
            case catID = "catID"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            sr = try values.decodeIfPresent(String.self, forKey: .sr)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            image = try values.decodeIfPresent(String.self, forKey: .image)
            catID = try values.decodeIfPresent(String.self, forKey: .catID)
        }
        
    }
    
    
    struct Home_category_products : Codable {
        let catID : String?
        let category_name : String?
        let category_banner : String?
        let category_products : [Category_products]?
        let offerBanner : [OfferBanner]?
        // let new_category_list : [String]?
        
        enum CodingKeys: String, CodingKey {
            
            case catID = "catID"
            case category_name = "category_name"
            case category_banner = "category_banner"
            case category_products = "category_products"
            case offerBanner = "offerBanner"
            //  case new_category_list = "new_category_list"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            catID = try values.decodeIfPresent(String.self, forKey: .catID)
            category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
            category_banner = try values.decodeIfPresent(String.self, forKey: .category_banner)
            category_products = try values.decodeIfPresent([Category_products].self, forKey: .category_products)
            offerBanner = try values.decodeIfPresent([OfferBanner].self, forKey: .offerBanner)
            // new_category_list = try values.decodeIfPresent([String].self, forKey: .new_category_list)
        }
        
    }
    
    struct Category_products : Codable {
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
    
    
}
