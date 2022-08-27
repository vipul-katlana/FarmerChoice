
import UIKit

protocol OTPPresentationLogic {
    func presentLoginResponse(response: OTP.ViewModel?,message: String, successCode: Int)
}

class OTPPresenter: OTPPresentationLogic {
    weak var viewController: OTPDisplayLogic?
    func presentLoginResponse(response: OTP.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveOTPResponse(response: response, message: message, successCode: successCode)
    }
}
