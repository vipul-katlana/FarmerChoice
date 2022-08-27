

import UIKit

protocol OrderHistoryPresentationLogic {
    func presentOrderHistoryList(response: OrderHistory.ViewModel?, message: String, successCode: Int)
    func presentCancelOrderResponse(response: CancelOrder.ViewModel?, message: String, successCode: Int)
    func presentReOrderResponse(response: ReOrder.ViewModel?, message: String, successCode: Int)
}

class OrderHistoryPresenter: OrderHistoryPresentationLogic {
    weak var viewController: OrderHistoryDisplayLogic?
    
    // MARK: Do something
    
    func presentOrderHistoryList(response: OrderHistory.ViewModel?, message: String, successCode: Int) {
        viewController?.didReceiveOrderHistory(response: response, message: message, successCode: successCode)
    }
    
    func presentCancelOrderResponse(response: CancelOrder.ViewModel?, message: String, successCode: Int) {
        viewController?.didReceiveCancelOrder(response: response, message: message, successCode: successCode)
    }
    func presentReOrderResponse(response: ReOrder.ViewModel?, message: String, successCode: Int) {
        viewController?.didReceiveReOrder(response: response, message: message, successCode: successCode)
    }
}
