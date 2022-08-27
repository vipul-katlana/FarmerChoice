
import UIKit

protocol BrandPresentationLogic {
    func presentBrandListResponse(response: Brand.ViewModel?, message: String, successCode: Int)
}

class BrandPresenter: BrandPresentationLogic {
    weak var viewController: BrandDisplayLogic?
    
    // MARK: Do something
    
    func presentBrandListResponse(response: Brand.ViewModel?, message: String, successCode: Int) {
        viewController?.didReceiveBrandListResponse(response: response, message: message, successCode: successCode)
    }
}
