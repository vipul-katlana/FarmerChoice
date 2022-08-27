

import UIKit

protocol StaticPagesPresentationLogic {
    
    func presentStaticPageResponse(response: StaticPages.ViewModel?,message: String, successCode: Int)
}

class StaticPagesPresenter: StaticPagesPresentationLogic {
    weak var viewController: StaticPagesDisplayLogic?
    
    // MARK: Do something
    
    func presentStaticPageResponse(response: StaticPages.ViewModel?,message: String, successCode: Int) {
        viewController?.didStaticPageListResponse(response: response, message: message, successCode: successCode)
    }
}
