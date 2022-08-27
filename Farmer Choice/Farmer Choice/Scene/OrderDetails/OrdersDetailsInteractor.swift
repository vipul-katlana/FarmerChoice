

import UIKit

protocol OrdersDetailsBusinessLogic {
    func callOrderDetailsAPI(request: OrdersDetails.Request)
    func callReOrderAPI(request: ReOrder.Request)
}

protocol OrdersDetailsDataStore {
    //var name: String { get set }
}

class OrdersDetailsInteractor: OrdersDetailsBusinessLogic, OrdersDetailsDataStore {
    var presenter: OrdersDetailsPresentationLogic?
    var worker: OrdersDetailsWorker?
    
    func callOrderDetailsAPI(request: OrdersDetails.Request) {
        worker = OrdersDetailsWorker()
        worker?.callOrderDetailsAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentOrderDetails(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
    
    func callReOrderAPI(request: ReOrder.Request) {
        worker = OrdersDetailsWorker()
        worker?.callReOrderAPI(request: request, completionHandler: { (response, message, succeccCode) in
            self.presenter?.presentReOrderResponse(response: response, message: message ?? "", successCode: succeccCode ?? 0)
        })
    }
}
