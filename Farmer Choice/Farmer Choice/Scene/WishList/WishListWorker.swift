
import UIKit

class WishListWorker {
    
    func callProductListAPI(loader:Bool, request:ProductList.Request ,completionHandler: @escaping(ProductList.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "product&userID=\(user?.userId ?? "")&pagecode=\(request.pageCode)&catID=\(request.catId)&search=\(request.search)&type=\(request.type)&cityID=\(UserDefaultsManager.getCityId())"
        NetworkService.callServerAPI(with: createUrl,showLoader: loader) { (response: WSResponse<ProductList.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
    
    func callBrandListAPI(loader:Bool, request:ProductList.BrandList ,completionHandler: @escaping(ProductList.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        
        let createUrl = AppConstant.baseUrl + "brand_product&pagecode=\(request.pageCode)&brandID=\(request.brandId)&type=\(request.type)"
        NetworkService.callServerAPI(with: createUrl,showLoader: loader) { (response: WSResponse<ProductList.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
    func callLastChoiceAPI(loader:Bool, request:ProductList.LastChoiceRequest ,completionHandler: @escaping(ProductList.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "product&userID=\(user?.userId ?? "")&pagecode=\(request.pageCode)"
        NetworkService.callServerAPI(with: createUrl,showLoader: loader) { (response: WSResponse<ProductList.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
    
    func callWishListAPI(loader:Bool, request:ProductList.WishListRequest ,completionHandler: @escaping(ProductList.WishListViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "whishlist&userID=\(user?.userId ?? "")&pagecode=\(request.pageCode)&page_type=whish_list&type=\(request.type)"
        NetworkService.callServerAPI(with: createUrl,showLoader: loader) { (response: WSResponse<ProductList.WishListViewModel>?, message: String?, successCode: Int?) in
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
    
    func callAddRemoveWishListAPI(request:AddRemoveWishList.Request ,completionHandler: @escaping(AddRemoveWishList.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "whishlist&userID=\(user?.userId ?? "")&page_type=\(request.pageType)&productID=\(request.productId)&whishID=\(request.wishId)"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<AddRemoveWishList.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
}
