

import UIKit

protocol AuthenticationPresentationLogic {
    func presentLoginResponse(response: Login.ViewModel?,message: String, successCode: Int)
    func presentSignUpResponse(response: SignUp.ViewModel?,message: String, successCode: Int)
}

class AuthenticationPresenter: AuthenticationPresentationLogic {
    weak var viewController: AuthenticationDisplayLogic?
    
    func presentLoginResponse(response: Login.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveLoginResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentSignUpResponse(response: SignUp.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveSignUpResponse(response: response, message: message, successCode: successCode)
    }
}
