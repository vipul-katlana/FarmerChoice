

import Foundation
public enum NetworkError: Error {
    
    // MARK: - Client Error: 400...499
    case clientError(statusCode: Int)
    
    // MARK: - Server Error: 500...599
    case serverError(statusCode: Int)
    
    // MARK: - Parsing Error
    case parsingError(error: Error)
    
    case requestError(errorMessage: String)
    
    // MARK: - Other
    case other(statusCode: Int?, error: Error?)
}


