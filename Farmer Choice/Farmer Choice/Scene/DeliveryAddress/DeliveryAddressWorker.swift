

import UIKit

class DeliveryAddressWorker {
    
    
    func callDeliveryAPI(request: DeliveryAddress.Request,loader: Bool, completionHandler: @escaping(DeliveryAddress.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "get_info&userID=\(user?.userId ?? "")&userPhone=\(user?.phone ?? "")&day=\(request.day)&type=\(request.timeSlot)&cityID=\(UserDefaultsManager.getCityId())"
        NetworkService.callServerAPI(with: createUrl,showLoader: loader) { (response: WSResponse<DeliveryAddress.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
    
    func callTimeSlotAPI(request: TimeSlot.Request, completionHandler: @escaping(TimeSlot.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "get_info&userID=\(user?.userId ?? "")&userPhone=\(user?.phone ?? "")&day=\(request.day)&type=time_slot&cityID=\(UserDefaultsManager.getCityId())"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<TimeSlot.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
}
