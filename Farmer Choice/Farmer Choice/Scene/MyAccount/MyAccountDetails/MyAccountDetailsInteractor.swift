

import UIKit

protocol MyAccountDetailsBusinessLogic {
    func callMyProfileApi(request: MyAccountDetails.Request)
}

protocol MyAccountDetailsDataStore {
    //var name: String { get set }
}

class MyAccountDetailsInteractor: MyAccountDetailsBusinessLogic, MyAccountDetailsDataStore {
    
    var presenter: MyAccountDetailsPresentationLogic?
    var worker: MyAccountDetailsWorker?
    
    func callMyProfileApi(request: MyAccountDetails.Request) {
        worker = MyAccountDetailsWorker()
        worker?.callMyProfileAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentMyProfileResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
}
