

import UIKit

protocol WishListPresentationLogic {
    func presentProductListResponse(response: ProductList.ViewModel?,message: String, successCode: Int)
    func presentBrandListResponse(response: ProductList.ViewModel?,message: String, successCode: Int)
    func presentWishListResponse(response: ProductList.WishListViewModel?,message: String, successCode: Int)
    func presentLastOrderResponse(response: ProductList.ViewModel?,message: String, successCode: Int)
    func presentAddRemoveResponse(response: AddCart.ViewModel?,message: String, successCode: Int)
    func presentAddRemoveWishlistResponse(response: AddRemoveWishList.ViewModel?,message: String, successCode: Int)
}

class WishListPresenter: WishListPresentationLogic {
    weak var viewController: WishListDisplayLogic?
    
    // MARK: Do something
    
    func presentProductListResponse(response: ProductList.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveProductListResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentLastOrderResponse(response: ProductList.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveLastChoiceResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentWishListResponse(response: ProductList.WishListViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveWishListResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentAddRemoveResponse(response: AddCart.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveAddRemoveResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentAddRemoveWishlistResponse(response: AddRemoveWishList.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveAddRemoveWishListResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentBrandListResponse(response: ProductList.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveBrandListResponse(response: response, message: message, successCode: successCode)
    }
}
