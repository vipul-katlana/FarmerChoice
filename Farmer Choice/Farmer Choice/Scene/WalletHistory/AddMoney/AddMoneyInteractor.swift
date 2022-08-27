

import UIKit

protocol AddMoneyBusinessLogic {
    func callPaytmDetailsAPI(request: PaytmIntegration.Request)
}

protocol AddMoneyDataStore {
    //var name: String { get set }
}

class AddMoneyInteractor: AddMoneyBusinessLogic, AddMoneyDataStore
{
    var presenter: AddMoneyPresentationLogic?
    var worker: AddMoneyWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func callPaytmDetailsAPI(request: PaytmIntegration.Request) {
        worker = AddMoneyWorker()
        worker?.callPaytmDetailsAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentPayTmDetails(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
}
