

import UIKit

protocol PaymentOptionBusinessLogic {
    func callPaymentApi(request: PaymentOption.Request)
    func callPlaceOrderApi(request: PlaceOrder.Request)
}

protocol PaymentOptionDataStore {
    //var name: String { get set }
}

class PaymentOptionInteractor: PaymentOptionBusinessLogic, PaymentOptionDataStore {
    var presenter: PaymentOptionPresentationLogic?
    var worker: PaymentOptionWorker?
    
    func callPaymentApi(request: PaymentOption.Request) {
        worker = PaymentOptionWorker()
        worker?.callPaymentAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentPaymentResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
    
    func callPlaceOrderApi(request: PlaceOrder.Request) {
        worker = PaymentOptionWorker()
        worker?.callOrderPlaceAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentPlaceOrderResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
}
