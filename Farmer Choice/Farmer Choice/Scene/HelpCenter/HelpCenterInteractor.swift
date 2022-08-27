

import UIKit

protocol HelpCenterBusinessLogic {
    func callSubmitHelpAPI(request: HelpCenter.Request)
}

protocol HelpCenterDataStore {
    //var name: String { get set }
}

class HelpCenterInteractor: HelpCenterBusinessLogic, HelpCenterDataStore {
    var presenter: HelpCenterPresentationLogic?
    var worker: HelpCenterWorker?
    
    
    func callSubmitHelpAPI(request: HelpCenter.Request) {
        worker = HelpCenterWorker()
        worker?.callSubmitHelpAPI(request: request, completionHandler: { (message, succesCode) in
            self.presenter?.presentSubmitHelp(message: message ?? "", successCode: succesCode ?? 0)
        })
    }
}
