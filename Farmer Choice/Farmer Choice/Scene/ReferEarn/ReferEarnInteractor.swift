

import UIKit

protocol ReferEarnBusinessLogic {
    func callReferEarnAPI()
}

protocol ReferEarnDataStore {
    //var name: String { get set }
}

class ReferEarnInteractor: ReferEarnBusinessLogic, ReferEarnDataStore {
    var presenter: ReferEarnPresentationLogic?
    var worker: ReferEarnWorker?
    
    func callReferEarnAPI() {
        worker = ReferEarnWorker()
        worker?.callReferEarnAPI(completionHandler: { (response, message, successCode) in
            self.presenter?.presentReferFriendResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
}
