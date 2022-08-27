
import Foundation
import Alamofire

enum WSTokenRouter: RouterProtocol {
    
    var baseUrlString: String {
        return AppConstant.baseUrl
    }

    case createToken

    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        switch self {
        case .createToken:
            return "/create_token"
        }
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.httpBody
    }
    
    var headers: [String: String]? {
        return ["Content-Type": ""]
    }
    
    
    var files: [MultiPartData]? {
        return nil
    }
}
