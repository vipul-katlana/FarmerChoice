

import UIKit

protocol CartListPresentationLogic {
    func presentCartListResponse(response: CartList.ViewModel?,message: String, successCode: Int)
    
    func presentAddRemoveResponse(response: AddCart.ViewModel?,message: String, successCode: Int)
    
    func presentDeleteItemResponse(response: AddCart.ViewModel?,message: String, successCode: Int)
    
    func presentClearCartResponse(response: AddCart.ViewModel?,message: String, successCode: Int)
}

class CartListPresenter: CartListPresentationLogic {
    weak var viewController: CartListDisplayLogic?
    
    // MARK: Do something
    
    func presentCartListResponse(response: CartList.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveCartListResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentAddRemoveResponse(response: AddCart.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveAddRemoveResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentDeleteItemResponse(response: AddCart.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveDeteleItemResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentClearCartResponse(response: AddCart.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveClearCartResponse(response: response, message: message, successCode: successCode)
    }
}
