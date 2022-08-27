

import UIKit

class OrdersDetailsWorker {
    
    func callOrderDetailsAPI(request: OrdersDetails.Request, completionHandler: @escaping(OrdersDetails.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "order_detail&userID=\(user?.userId ?? "")&orderID=\(request.orderId)"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<OrdersDetails.ViewModel>?, message: String?, successCode: Int?) in
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
