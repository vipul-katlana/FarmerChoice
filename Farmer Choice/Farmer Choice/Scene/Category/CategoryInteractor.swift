

import UIKit

protocol CategoryBusinessLogic {
    func callCategoryAPI()
}

protocol CategoryDataStore {
    //var name: String { get set }
}

class CategoryInteractor: CategoryBusinessLogic, CategoryDataStore {
    var presenter: CategoryPresentationLogic?
    var worker: CategoryWorker?
    
    func callCategoryAPI() {
        worker = CategoryWorker()
        worker?.callCategoryAPI(completionHandler: { (response, message, successCode) in
            self.presenter?.presentCategoryResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
}
