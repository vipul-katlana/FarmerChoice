

import UIKit

class StaticPagesWorker {
    
    func callStaticPageAPI(completionHandler: @escaping(StaticPages.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let createUrl = AppConstant.baseUrl + "about&cityID=\(UserDefaultsManager.getCityId())"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<StaticPages.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
}
