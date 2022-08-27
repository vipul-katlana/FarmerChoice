

import UIKit

protocol WishListBusinessLogic {
    func callProductListApi(request: ProductList.Request,loader:Bool)
    func callBrandListApi(request: ProductList.BrandList,loader:Bool)
    func callLastChoiceApi(request: ProductList.LastChoiceRequest,loader:Bool)
    func callWishListApi(request: ProductList.WishListRequest,loader:Bool)
    func callAddRemoveApi(request: AddCart.Request)
    func callAddRemoveWishListApi(request: AddRemoveWishList.Request)
}

protocol WishListDataStore {
    //var name: String { get set }
}

class WishListInteractor: WishListBusinessLogic, WishListDataStore {
    var presenter: WishListPresentationLogic?
    var worker: WishListWorker?
    
    
    func callProductListApi(request: ProductList.Request,loader:Bool) {
        worker = WishListWorker()
        worker?.callProductListAPI(loader: loader, request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentProductListResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
    
    func callLastChoiceApi(request: ProductList.LastChoiceRequest,loader:Bool) {
        worker = WishListWorker()
        worker?.callLastChoiceAPI(loader: loader, request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentLastOrderResponse(response: response, message: message ?? "" , successCode: successCode ?? 0)
        })
    }
    
    func callWishListApi(request: ProductList.WishListRequest,loader:Bool) {
        worker = WishListWorker()
        worker?.callWishListAPI(loader: loader, request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentWishListResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
    
    func callAddRemoveApi(request: AddCart.Request) {
        worker = WishListWorker()
        worker?.callAddRemoveAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentAddRemoveResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
    
    func callAddRemoveWishListApi(request: AddRemoveWishList.Request) {
        worker = WishListWorker()
        worker?.callAddRemoveWishListAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentAddRemoveWishlistResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
    
    func callBrandListApi(request: ProductList.BrandList,loader:Bool) {
        worker = WishListWorker()
        worker?.callBrandListAPI(loader: loader, request: request, completionHandler: { (response, message, success) in
            self.presenter?.presentBrandListResponse(response: response, message: message ?? "", successCode: success ?? 0)
        })
    }
}
