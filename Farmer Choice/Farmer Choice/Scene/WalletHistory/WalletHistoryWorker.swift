

import UIKit

class WalletHistoryWorker {
    
    func callWalletHistoryAPI(completionHandler: @escaping(WalletHistory.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "wallet_transction&userID=\(user?.userId ?? "")"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<WalletHistory.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
}
