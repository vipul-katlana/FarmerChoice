

import UIKit

class SearchProductWorker {
    
    func callSearchListAPI(request:SearchProduct.Request, completionHandler: @escaping(SearchProduct.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let createUrl = AppConstant.baseUrl + "search_new&pagecode=\(request.pageCount)"
        NetworkService.callServerAPI(with: createUrl,showLoader: false) { (response: WSResponse<SearchProduct.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
}
