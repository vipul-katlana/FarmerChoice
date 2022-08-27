
import UIKit

protocol SearchProductBusinessLogic {
    func callSearchAPI(request: SearchProduct.Request)
}

protocol SearchProductDataStore {
    //var name: String { get set }
}

class SearchProductInteractor: SearchProductBusinessLogic, SearchProductDataStore {
    var presenter: SearchProductPresentationLogic?
    var worker: SearchProductWorker?
    
    
    func callSearchAPI(request: SearchProduct.Request) {
        worker = SearchProductWorker()
        worker?.callSearchListAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentSearchListResponse(response: response, message: message ?? "" , successCode: successCode ?? 0)
        })
        
    }
}
