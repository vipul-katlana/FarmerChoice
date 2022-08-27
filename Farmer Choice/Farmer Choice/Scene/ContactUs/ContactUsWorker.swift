


import UIKit

class ContactUsWorker {
    
    func callContactUSAPI(completionHandler: @escaping(ContactUs.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let createUrl = AppConstant.baseUrl + "contact19"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<ContactUs.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
}
