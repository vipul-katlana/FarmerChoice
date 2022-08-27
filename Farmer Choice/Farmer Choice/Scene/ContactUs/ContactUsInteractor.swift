

import UIKit

protocol ContactUsBusinessLogic {
    func callContactUsAPI()
}

protocol ContactUsDataStore {
    //var name: String { get set }
}

class ContactUsInteractor: ContactUsBusinessLogic, ContactUsDataStore {
    var presenter: ContactUsPresentationLogic?
    var worker: ContactUsWorker?
    
    func callContactUsAPI() {
        worker = ContactUsWorker()
        worker?.callContactUSAPI(completionHandler: { (response, message, successCode) in
            self.presenter?.presentContactUsResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
}
