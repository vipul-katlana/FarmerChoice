

import UIKit

protocol PromoCodeBusinessLogic {
    func callPromoCodeList()
    func applyPromoCode(request: PromoCodeApply.Request)
}

protocol PromoCodeDataStore {
    //var name: String { get set }
}

class PromoCodeInteractor: PromoCodeBusinessLogic, PromoCodeDataStore {
    var presenter: PromoCodePresentationLogic?
    var worker: PromoCodeWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func callPromoCodeList() {
        worker = PromoCodeWorker()
        worker?.callPromoCodelIstAPI(completionHandler: { (response, message, successCode) in
            self.presenter?.presentPromoCodeListResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
    
    func applyPromoCode(request: PromoCodeApply.Request) {
        worker = PromoCodeWorker()
        worker?.callPromoCodelApplyAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentApplyPromoCodeListResponse(response: response, message: message ?? "" , successCode: successCode ?? 0)
        })
    }
}
