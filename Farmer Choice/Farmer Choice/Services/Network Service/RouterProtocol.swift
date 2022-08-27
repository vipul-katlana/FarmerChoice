

import Foundation
import Alamofire

public protocol RouterProtocol: URLRequestConvertible {

    var method: HTTPMethod { get }
    var baseUrlString: String { get }

    var path: String { get }
    var parameters: [String: Any]? { get }
    var parameterEncoding: ParameterEncoding { get }
    var headers: [String: String]? { get }
    var arrayParameters: [Any]? { get }

    var files: [MultiPartData]? { get }
}

public extension RouterProtocol {
    //data: Data? = nil
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: self.baseUrlString) else {
            throw(NetworkError.requestError(errorMessage: "Unable to create url"))
        }
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = self.headers
        request.timeoutInterval = 600.0 * 0.5
        
//        if let jsonData = data {
//            request.httpBody = jsonData
//        }
        
        do {
            let req = try URLEncoding.default.encode(request as URLRequestConvertible, with: parameters)
            return req
        } catch let error {
            print("error occured \(error)")
        }
        return request
    }

    
    var arrayParameters: [Any]? {
        return nil
    }
}
