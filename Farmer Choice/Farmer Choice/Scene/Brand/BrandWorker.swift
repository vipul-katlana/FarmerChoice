

import UIKit

class BrandWorker {
    
    func callAPI(loader:Bool ,request:Brand.Request ,completionHandler: @escaping(Brand.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "brands_new&pagecode=\(request.pageCode)"
        NetworkService.callServerAPI(with: createUrl,showLoader: loader) { (response: WSResponse<Brand.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
}
