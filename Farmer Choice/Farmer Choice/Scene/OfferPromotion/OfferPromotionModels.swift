

import UIKit

enum OfferPromotion {
    
    class ViewModel: WSResponseData {
        var offerList: [OfferList]?
        
        enum CodingKeys: String, CodingKey {
            case offer_list
        }
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            offerList = try values.decodeIfPresent([OfferList].self, forKey: .offer_list)
        }
        public override func encode(to encoder: Encoder) throws {
            try super.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(offerList, forKey: .offer_list)
        }
    }
    
    class OfferList: Codable {
        var offer : String?
        var product: String?
        var image: String?
        var title: String?
        var message: String?
        var added_on: String?
        var terms: String?
        
        enum CodingKeys: String, CodingKey {
            case offer
            case product
            case image
            case title
            case message
            case added_on
            case terms
        }
        
        required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            offer = try values.decodeIfPresent(String.self, forKey: .offer)
            product = try values.decodeIfPresent(String.self, forKey: .product)
            image = try values.decodeIfPresent(String.self, forKey: .image)
            title = try values.decodeIfPresent(String.self, forKey: .title)
            message = try values.decodeIfPresent(String.self, forKey: .message)
            added_on = try values.decodeIfPresent(String.self, forKey: .added_on)
            terms = try values.decodeIfPresent(String.self, forKey: .terms)
            
        }
        
    }
}

