

import UIKit

protocol StaticPagesBusinessLogic {
    
    func callStaticPageAPI()
}

protocol StaticPagesDataStore {
    //var name: String { get set }
}

class StaticPagesInteractor: StaticPagesBusinessLogic, StaticPagesDataStore {
    var presenter: StaticPagesPresentationLogic?
    var worker: StaticPagesWorker?
    
    func callStaticPageAPI() {
        worker = StaticPagesWorker()
        worker?.callStaticPageAPI(completionHandler: { (response, message, successCode) in
            self.presenter?.presentStaticPageResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
}
