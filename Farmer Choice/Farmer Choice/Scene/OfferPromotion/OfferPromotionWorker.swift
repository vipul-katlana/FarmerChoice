

import UIKit

class OfferPromotionWorker {
    
    func callOfferPromotionAPI(completionHandler: @escaping(OfferPromotion.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "offer_list&userID=\(user?.userId ?? "")"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<OfferPromotion.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
}
