

import UIKit

protocol PinCodeBusinessLogic {
    func callPinCodeApi(request: PinCode.Request)
}

protocol PinCodeDataStore {
    //var name: String { get set }
}

class PinCodeInteractor: PinCodeBusinessLogic, PinCodeDataStore {
    var presenter: PinCodePresentationLogic?
    var worker: PinCodeWorker?
    
    func callPinCodeApi(request: PinCode.Request) {
        worker = PinCodeWorker()
        worker?.callPinCodeAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentPincodeResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
}
