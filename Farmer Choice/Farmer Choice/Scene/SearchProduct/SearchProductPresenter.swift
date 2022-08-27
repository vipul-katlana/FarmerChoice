

import UIKit

protocol SearchProductPresentationLogic {
    
    func presentSearchListResponse(response: SearchProduct.ViewModel?,message: String, successCode: Int)
    
}

class SearchProductPresenter: SearchProductPresentationLogic {
    weak var viewController: SearchProductDisplayLogic?
    
    // MARK: Do something
    
    func presentSearchListResponse(response: SearchProduct.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveSearchListResponse(response: response, message: message, successCode: successCode)
    }
}
