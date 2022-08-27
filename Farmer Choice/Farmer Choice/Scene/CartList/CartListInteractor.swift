

import UIKit

protocol CartListBusinessLogic {
    func callCartListApi()
    func callAddRemoveApi(request: CartList.Request)
    func callDeleteItemApi(request: CartList.Request)
    func callClearCartApi()
    
}

protocol CartListDataStore {
    //var name: String { get set }
}

class CartListInteractor: CartListBusinessLogic, CartListDataStore {
    var presenter: CartListPresentationLogic?
    var worker: CartListWorker?
    
    func callCartListApi() {
        worker = CartListWorker()
        
        worker?.callCartListAPI(completionHandler: { (response, message, successCode) in
            self.presenter?.presentCartListResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
    
    func callAddRemoveApi(request: CartList.Request) {
        worker = CartListWorker()
        
        worker?.callAddRemoveAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentAddRemoveResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
        
    }
    
    func callDeleteItemApi(request: CartList.Request) {
        worker = CartListWorker()
        worker?.callDeleteItemAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentDeleteItemResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
    
    func callClearCartApi() {
        worker = CartListWorker()
        worker?.callEmptyCartAPI(completionHandler: { (response, message, successCode) in
            self.presenter?.presentClearCartResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
}
