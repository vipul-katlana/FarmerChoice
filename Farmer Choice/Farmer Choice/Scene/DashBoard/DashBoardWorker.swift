

import UIKit

class DashBoardWorker {
    
    func callDashBoardAPI(request:DashBoard.Request ,completionHandler: @escaping(DashBoard.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "home&userID=\(user?.userId ?? "")&deviceID=\(request.deviceId)&tokenid=\(request.tokenId)&mobile_type=iPhone&appV=\(request.appVersion)&cityID=\(UserDefaultsManager.getCityId())"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<DashBoard.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
    func callDashBoardListAPI(request: DashBoardList.Request, loader:Bool, completionHandler: @escaping(DashBoardList.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        
        let createUrl = AppConstant.baseUrl + "home_products_new_2022&userID=\(user?.userId ?? "")&pagecode=\(request.pageCode)&cityID=\(UserDefaultsManager.getCityId())"
        NetworkService.callServerAPI(with: createUrl,showLoader: loader) { (response: WSResponse<DashBoardList.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
    func callEmptyCartAPI(completionHandler: @escaping(AddCart.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "cart&userID=\(user?.userId ?? "")&page_type=cart_clear&cityID=\(UserDefaultsManager.getCityId())"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<AddCart.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
}
