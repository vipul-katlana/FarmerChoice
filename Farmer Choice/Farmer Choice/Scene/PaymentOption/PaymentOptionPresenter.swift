


import UIKit

protocol PaymentOptionPresentationLogic {
    
    func presentPaymentResponse(response: PaymentOption.ViewModel?,message: String, successCode: Int)
    
    func presentPlaceOrderResponse(response: [PlaceOrder.ViewModel]?,message: String, successCode: Int)
    
    func presentPayTmOrder(response: PaytmOrderResult.ViewModel?,message: String, successCode: Int)
}

class PaymentOptionPresenter: PaymentOptionPresentationLogic {
    weak var viewController: PaymentOptionDisplayLogic?
    
    // MARK: Do something
    
    func presentPaymentResponse(response: PaymentOption.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceivePaymentResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentPlaceOrderResponse(response: [PlaceOrder.ViewModel]?,message: String, successCode: Int) {
        viewController?.didReceivePlaceOrderResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentPayTmOrder(response: PaytmOrderResult.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceivePayTmOrder(response: response, message: message, successCode: successCode)
    }
}
