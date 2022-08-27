

import UIKit

class HelpCenterWorker {
    
    func callSubmitHelpAPI(request: HelpCenter.Request, completionHandler: @escaping(_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "help&userID=\(user?.userId ?? "")&name=\(request.name)&email=\(request.email)&phone=\(request.phone)&msg=\(request.message)&type=Iphone"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<ReferEarn.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler("Error",1)
            }
        }
    }
}
