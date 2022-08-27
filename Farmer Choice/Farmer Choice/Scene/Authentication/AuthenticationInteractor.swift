

import UIKit

protocol AuthenticationBusinessLogic {
    func callLoginAPI(request: Login.Request)
    func callSignUpAPI(request: SignUp.Request)
}

protocol AuthenticationDataStore {
    //var name: String { get set }
}

class AuthenticationInteractor: AuthenticationBusinessLogic, AuthenticationDataStore {
    var presenter: AuthenticationPresentationLogic?
    var worker: AuthenticationWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func callLoginAPI(request: Login.Request) {
        worker = AuthenticationWorker()
        worker?.callLoginAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentLoginResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
    
    func callSignUpAPI(request: SignUp.Request) {
        worker = AuthenticationWorker()
        worker?.callSignUpAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentSignUpResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
        
    }
}
