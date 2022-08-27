

import UIKit

protocol OrderHistoryBusinessLogic {
    func callOrderHistoryAPI(request: OrderHistory.Request)
    func callCancelOrderAPI(request: CancelOrder.Request)
    func callReOrderAPI(request: ReOrder.Request)
}

protocol OrderHistoryDataStore
{
    //var name: String { get set }
}

class OrderHistoryInteractor: OrderHistoryBusinessLogic, OrderHistoryDataStore {
    var presenter: OrderHistoryPresentationLogic?
    var worker: OrderHistoryWorker?
    
    func callOrderHistoryAPI(request: OrderHistory.Request) {
        worker = OrderHistoryWorker()
        worker?.callOrderHistoryAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentOrderHistoryList(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
    
    func callCancelOrderAPI(request: CancelOrder.Request) {
        worker = OrderHistoryWorker()
        worker?.callCancelOrderAPI(request: request
            , completionHandler: { (response, message, success) in
                self.presenter?.presentCancelOrderResponse(response: response, message: message ?? "", successCode: success ?? 0)
        })
    }
    
    func callReOrderAPI(request: ReOrder.Request) {
        worker = OrderHistoryWorker()
        worker?.callReOrderAPI(request: request, completionHandler: { (response, message, succeccCode) in
            
            self.presenter?.presentReOrderResponse(response: response, message: message ?? "", successCode: succeccCode ?? 0)
        })
    }
}
