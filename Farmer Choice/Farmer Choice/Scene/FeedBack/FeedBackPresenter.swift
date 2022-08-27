

import UIKit

protocol FeedBackPresentationLogic {
    func presentFeedback(response: FeedBack.ViewModel?, message: String, successCode: Int)
}

class FeedBackPresenter: FeedBackPresentationLogic {
    weak var viewController: FeedBackDisplayLogic?
    
    
    func presentFeedback(response: FeedBack.ViewModel?, message: String, successCode: Int) {
        viewController?.didReceiveFeedBackResponse(response: response, message: message, successCode: successCode)
    }
    
}
