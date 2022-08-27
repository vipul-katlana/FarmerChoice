

import UIKit

class ProductDetailsWorker {
    
    func callProductDetailsAPI(request:ProductDetails.Request ,completionHandler: @escaping(ProductDetails.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "product_detail&userID=\(user?.userId ?? "")&productID=\(request.productId)&cityID=\(UserDefaultsManager.getCityId())"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<ProductDetails.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
    func callRelatedProductDetailsAPI(request:RelatedProduct.Request ,completionHandler: @escaping(RelatedProduct.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "related_product&userID=\(user?.userId ?? "")&productID=\(request.productId)&cityID=\(UserDefaultsManager.getCityId())"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<RelatedProduct.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
    func callAddRemoveAPI(request:AddCart.Request ,completionHandler: @escaping(AddCart.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "cart&userID=\(user?.userId ?? "")&page_type=add_item_cart&productID=\(request.productId)&priceID=\(request.priceID)&qty_type=\(request.qtyType)&cityID=\(UserDefaultsManager.getCityId())&cartQty=\(request.cartQty)"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<AddCart.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
}
