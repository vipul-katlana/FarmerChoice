

import UIKit

protocol OrdersDetailsPresentationLogic {
    func presentOrderDetails(response: OrdersDetails.ViewModel?, message: String, successCode: Int)
    func presentReOrderResponse(response: ReOrder.ViewModel?, message: String, successCode: Int)
}

class OrdersDetailsPresenter: OrdersDetailsPresentationLogic {
    weak var viewController: OrdersDetailsDisplayLogic?
    
    func presentOrderDetails(response: OrdersDetails.ViewModel?, message: String, successCode: Int) {
        viewController?.didReceiveOrderDetails(response: response, message: message, successCode: successCode)
    }
    
    func presentReOrderResponse(response: ReOrder.ViewModel?, message: String, successCode: Int) {
        viewController?.didReceiveReOrder(response: response, message: message, successCode: successCode)
    }
}
