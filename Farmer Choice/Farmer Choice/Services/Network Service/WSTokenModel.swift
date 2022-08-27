

import Foundation

public class WSTokenModel: WSResponseData {
    
    var webserviceToken: String?
    
    private enum CodingKeys: String, CodingKey {
        case webserviceToken = "ws_token"
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(webserviceToken, forKey: .webserviceToken)
    }
    
    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        webserviceToken = try? values.decode(String.self, forKey: .webserviceToken)
    }
}
