

import UIKit

class CartListWorker {
    
    func callCartListAPI(completionHandler: @escaping(CartList.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "cart&userID=\(user?.userId ?? "")&page_type=cart_list&cityID=\(UserDefaultsManager.getCityId())&areaID=\(UserDefaultsManager.getAreaId())"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<CartList.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
    
    func callAddRemoveAPI(request:CartList.Request ,completionHandler: @escaping(AddCart.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "cart&userID=\(user?.userId ?? "")&page_type=cart_item_update&cartID=\(request.cartID)&qty_type=\(request.type)&cityID=\(UserDefaultsManager.getCityId())&cartQty=\(request.qty)"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<AddCart.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
    func callDeleteItemAPI(request:CartList.Request ,completionHandler: @escaping(AddCart.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "cart&userID=\(user?.userId ?? "")&page_type=cart_item_delete&cartID=\(request.cartID)&cityID=\(UserDefaultsManager.getCityId())"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<AddCart.ViewModel>?, message: String?, successCode: Int?) in
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
