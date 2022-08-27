

import UIKit

protocol ProductDetailsPresentationLogic {
    func presentProductDetailsResponse(response: ProductDetails.ViewModel?,message: String, successCode: Int)
    
    func presentRelatedProductDetailsResponse(response: RelatedProduct.ViewModel?,message: String, successCode: Int)
    
    func presentAddRemoveResponse(response: AddCart.ViewModel?,message: String, successCode: Int)
}

class ProductDetailsPresenter: ProductDetailsPresentationLogic {
    weak var viewController: ProductDetailsDisplayLogic?
    
    // MARK: Do something
    
    func presentProductDetailsResponse(response: ProductDetails.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveProductDetailsResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentRelatedProductDetailsResponse(response: RelatedProduct.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiverelatedProductDetailsResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentAddRemoveResponse(response: AddCart.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveAddRemoveResponse(response: response, message: message, successCode: successCode)
    }
}
