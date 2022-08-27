

import UIKit

protocol FeedBackBusinessLogic {
    func callFeedbackAPI(request: FeedBack.Request)
}

protocol FeedBackDataStore {
    //var name: String { get set }
}

class FeedBackInteractor: FeedBackBusinessLogic, FeedBackDataStore {
    var presenter: FeedBackPresentationLogic?
    var worker: FeedBackWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func callFeedbackAPI(request: FeedBack.Request) {
     worker = FeedBackWorker()
        worker?.callFeeedBackAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentFeedback(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
}
