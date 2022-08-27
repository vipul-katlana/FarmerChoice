
import UIKit

class OrderHistoryWorker {
    
    func callOrderHistoryAPI(request: OrderHistory.Request,completionHandler: @escaping(OrderHistory.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "order_list&userID=\(user?.userId ?? "")&page=list&pagecode=\(request.pageCode)"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<OrderHistory.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
    
    func callCancelOrderAPI(request: CancelOrder.Request,completionHandler: @escaping(CancelOrder.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "order_list&userID=\(user?.userId ?? "")&page=cancel_order&orderID=\(request.orderId)"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<CancelOrder.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
    func callReOrderAPI(request: ReOrder.Request,completionHandler: @escaping(ReOrder.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "re_order&userID=\(user?.userId ?? "")&orderID=\(request.orderId)"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<ReOrder.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
}
