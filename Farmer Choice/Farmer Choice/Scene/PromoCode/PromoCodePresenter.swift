

import UIKit

protocol PromoCodePresentationLogic {
    func presentPromoCodeListResponse(response: PromoCode.ViewModel?,message: String, successCode: Int)
    
    func presentApplyPromoCodeListResponse(response: PromoCodeApply.ViewModel?,message: String, successCode: Int)
}

class PromoCodePresenter: PromoCodePresentationLogic {
    weak var viewController: PromoCodeDisplayLogic?
    
    // MARK: Do something
    
    func presentPromoCodeListResponse(response: PromoCode.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceivePromoCodeListResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentApplyPromoCodeListResponse(response: PromoCodeApply.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceivePromoCodeApplyResponse(response: response, message: message, successCode: successCode)
    }
}
