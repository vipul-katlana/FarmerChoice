
import Foundation
import Alamofire

enum AuthRouter: RouterProtocol {
    
    var baseUrlString: String {
        return AppConstant.baseUrl
    }
    
    case cashFreePayment(request: PaytmOrderResult.Request)
    
    case cartCashFreePayment(request: PaytmOrderResult.Request)
    
    
    var method: HTTPMethod {
        switch self {
        
        case .cashFreePayment, .cartCashFreePayment:
            return .post
            
        }
    }
    
    var path: String {
        switch self {
        case .cashFreePayment:
            return "walletcashfree_result"
        case .cartCashFreePayment:
            return "ordercashfree_result"
        }
        
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .cashFreePayment(let request):
            return [
                "orderId": request.orderId,
                "orderAmount": request.orderAmount,
                "referenceId": request.referenceId,
                "txStatus": request.txStatus,
                "paymentMode": request.paymentMode,
                "txMsg": request.txMsg,
                "txTime": request.txTime,
                "paymentSignature": request.signature,
                "razorpayOrderId": request.rozerPayId
                
            ]
        case .cartCashFreePayment(let request):
            return [
                "orderId": request.orderId,
                "orderAmount": request.orderAmount,
                "referenceId": request.referenceId,
                "txStatus": request.txStatus,
                "paymentMode": request.paymentMode,
                "txMsg": request.txMsg,
                "txTime": request.txTime,
                "paymentSignature": request.signature,
                "razorpayOrderId": request.rozerPayId
            ]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String: String]? {
        switch self {
        case .cashFreePayment,  .cartCashFreePayment:
            return [
                "Content-Type": ""
            ]
        }
    }
    
    var files: [MultiPartData]? {
        switch self {
        case .cashFreePayment , .cartCashFreePayment:
            return nil
        }
    }
}
