
import UIKit

protocol OfferPromotionBusinessLogic {
    func callOfferPromotionAPI()
}

protocol OfferPromotionDataStore
{
    //var name: String { get set }
}

class OfferPromotionInteractor: OfferPromotionBusinessLogic, OfferPromotionDataStore {
    var presenter: OfferPromotionPresentationLogic?
    var worker: OfferPromotionWorker?
    
    func callOfferPromotionAPI() {
        worker = OfferPromotionWorker()
        worker?.callOfferPromotionAPI(completionHandler: { (response, message, successCode) in
            self.presenter?.presentOfferPromotionResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
}
