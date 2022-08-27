

import UIKit

protocol CategoryPresentationLogic {
    func presentCategoryResponse(response: Category.ViewModel?,message: String, successCode: Int)
}

class CategoryPresenter: CategoryPresentationLogic {
    weak var viewController: CategoryDisplayLogic?
    
    // MARK: Do something
    
    func presentCategoryResponse(response: Category.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveCategoryResponse(response: response, message: message, successCode: successCode)
    }
}
