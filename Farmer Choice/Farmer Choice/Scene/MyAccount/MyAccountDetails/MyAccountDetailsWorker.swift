

import UIKit

class MyAccountDetailsWorker {
    
    func callMyProfileAPI(request:MyAccountDetails.Request ,completionHandler: @escaping(MyAccountDetails.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: Date())
        let createUrl = AppConstant.baseUrl + "get_info&userID=\(user?.userId ?? "")&userPhone=\(request.userPhone)&day=\(dayInWeek)&cityID=\(UserDefaultsManager.getCityId())"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<MyAccountDetails.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
}
