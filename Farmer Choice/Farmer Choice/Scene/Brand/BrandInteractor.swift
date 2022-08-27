

import UIKit

protocol BrandBusinessLogic {
    
    func callAPI(request: Brand.Request,loader: Bool)
}

protocol BrandDataStore
{
    //var name: String { get set }
}

class BrandInteractor: BrandBusinessLogic, BrandDataStore {
    var presenter: BrandPresentationLogic?
    var worker: BrandWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func callAPI(request: Brand.Request,loader: Bool) {
        worker = BrandWorker()
        worker?.callAPI(loader: loader, request: request, completionHandler: { (response, message, success) in
            self.presenter?.presentBrandListResponse(response: response, message: message ?? "", successCode: success ?? 0)
        })
    }
}
