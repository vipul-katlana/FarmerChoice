

import UIKit

class PinCodeWorker {
    func callPinCodeAPI(request:PinCode.Request ,completionHandler: @escaping(PinCode.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let createUrl = AppConstant.baseUrl + "area_pincode&areaID=\(request.areaId)&cityID=\(UserDefaultsManager.getCityId())"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<PinCode.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
}
