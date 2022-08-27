
import UIKit

class OTPWorker {
    
    func callOTPAPI(request: OTP.Request, completionHandler: @escaping(OTP.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        
        let createUrl = AppConstant.baseUrl + "otp_verify&userID=\(request.userId)&page=\(request.page)&phone=\(request.phone)&userPhone=\(request.phone)&otp=\(request.otp)"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<OTP.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
}
