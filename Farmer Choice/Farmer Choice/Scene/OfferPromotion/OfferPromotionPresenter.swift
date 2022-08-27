

import UIKit

protocol OfferPromotionPresentationLogic {
    func presentOfferPromotionResponse(response: OfferPromotion.ViewModel?,message: String, successCode: Int)
}

class OfferPromotionPresenter: OfferPromotionPresentationLogic {
    weak var viewController: OfferPromotionDisplayLogic?
    
    // MARK: Do something
    
    func presentOfferPromotionResponse(response: OfferPromotion.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveOfferPromotionResponse(response: response, message: message, successCode: successCode)
    }
}
