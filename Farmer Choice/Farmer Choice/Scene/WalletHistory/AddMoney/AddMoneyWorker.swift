

import UIKit

class AddMoneyWorker {
    
    
    func callPaytmDetailsAPI(request:PaytmIntegration.Request ,completionHandler: @escaping([PaytmIntegration.ViewModel]?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "add_money&userID=\(user?.userId ?? "")&amount=\(request.amount)&type1=razorpay"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<PaytmIntegration.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.arrayData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
    
    class func callPaymentStatusAPI(request:PaytmOrderResult.Request ,completionHandler: @escaping(PaytmOrderResult.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        
        NetworkService.callPostAPI(with: AuthRouter.cashFreePayment(request: request) , showLoader: true) { (response: WSResponse<PaytmOrderResult.ViewModel>?, message, succwss) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
    
    
    class func callCartPaymentStatusAPI(request:PaytmOrderResult.Request ,completionHandler: @escaping(PaytmOrderResult.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        
        NetworkService.callPostAPI(with: AuthRouter.cartCashFreePayment(request: request) , showLoader: true) { (response: WSResponse<PaytmOrderResult.ViewModel>?, message, succwss) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
}
