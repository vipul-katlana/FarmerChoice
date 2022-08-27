
import UIKit

protocol OTPBusinessLogic {
    func callOTPAPI(request: OTP.Request)
}

protocol OTPDataStore {
    //var name: String { get set }
}

class OTPInteractor: OTPBusinessLogic, OTPDataStore {
    var presenter: OTPPresentationLogic?
    var worker: OTPWorker?
    
    func callOTPAPI(request: OTP.Request) {
        worker = OTPWorker()
        worker?.callOTPAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentLoginResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
}
