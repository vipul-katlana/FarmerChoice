

import UIKit

protocol PinCodePresentationLogic {
    func presentPincodeResponse(response: PinCode.ViewModel?,message: String, successCode: Int)
}

class PinCodePresenter: PinCodePresentationLogic {
    weak var viewController: PinCodeDisplayLogic?
    
    // MARK: Do something
    
    func presentPincodeResponse(response: PinCode.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceivePinCodeResponse(response: response, message: message, successCode: successCode)
    }
}
