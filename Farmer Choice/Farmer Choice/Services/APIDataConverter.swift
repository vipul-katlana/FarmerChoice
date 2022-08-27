
import Foundation

public class WSResponse<T: WSResponseData> : Codable {
    
    var arrayData: [T]?
    var dictData: T?
    var message: String?
    var status: String?
    var authentication: Bool?
    var requestId: Int?
    var currentPage: Int?
    var nextPage: Int?
    
    private enum CodingKeys: String, CodingKey {
        case data = "User_data"
        case message = "message"
        case status = "msgcode"
        case authentication = "authentication"
        case requestId = "request_id"
        case currentPage = "curr_page"
        case nextPage = "next_page"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(arrayData, forKey: .data)
        try container.encode(dictData, forKey: .data)
        try container.encode(message, forKey: .message)
        try container.encode(status, forKey: .status)
        try container.encode(authentication, forKey: .authentication)
        try container.encode(requestId, forKey: .requestId)
        try container.encode(currentPage, forKey: .currentPage)
        try container.encode(nextPage, forKey: .nextPage)
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        arrayData = try? values.decode([T].self, forKey: .data)
        dictData = try? values.decode(T.self, forKey: .data)
        message = try? values.decode(String.self, forKey: .message)
        status = try? values.decode(String.self, forKey: .status)
        authentication = try? values.decode(Bool.self, forKey: .authentication)
        requestId = try? values.decode(Int.self, forKey: .requestId)
        currentPage = try? values.decode(Int.self, forKey: .currentPage)
        nextPage = try? values.decode(Int.self, forKey: .nextPage)
    }
}

public class WSResponseData: Codable {
    
    init() {
        
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
    
    required public init(from decoder: Decoder) throws {
        
    }
}
