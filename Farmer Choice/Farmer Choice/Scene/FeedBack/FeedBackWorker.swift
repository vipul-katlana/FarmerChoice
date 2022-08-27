

import UIKit

class FeedBackWorker {
    
    func callFeeedBackAPI(request:FeedBack.Request ,completionHandler: @escaping(FeedBack.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "rate_order&userID=\(user?.userId ?? "")&orderID=\(request.orderId)&expre=\(request.expression)&messg=\(request.message)"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<FeedBack.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
}
