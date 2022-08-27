

import UIKit

protocol ProductDetailsBusinessLogic {
    func callProductDetailsAPI(request: ProductDetails.Request)
    func callRelatedProductDetailsAPI(request: RelatedProduct.Request)
    func callAddRemoveApi(request: AddCart.Request)
}

protocol ProductDetailsDataStore {
    //var name: String { get set }
}

class ProductDetailsInteractor: ProductDetailsBusinessLogic, ProductDetailsDataStore {
    var presenter: ProductDetailsPresentationLogic?
    var worker: ProductDetailsWorker?
    
    func callProductDetailsAPI(request: ProductDetails.Request) {
        worker = ProductDetailsWorker()
        worker?.callProductDetailsAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentProductDetailsResponse(response: response, message: message ?? "" , successCode:     successCode ?? 0)
        })
    }
    
    func callRelatedProductDetailsAPI(request: RelatedProduct.Request) {
        worker = ProductDetailsWorker()
        worker?.callRelatedProductDetailsAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentRelatedProductDetailsResponse(response: response, message: message ?? "" , successCode:     successCode ?? 0)
        })
    }
    
    func callAddRemoveApi(request: AddCart.Request) {
        worker = ProductDetailsWorker()
        worker?.callAddRemoveAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentAddRemoveResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
}
