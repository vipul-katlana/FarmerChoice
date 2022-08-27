

import UIKit

protocol ReferEarnPresentationLogic {
    func presentReferFriendResponse(response: ReferEarn.ViewModel?,message: String, successCode: Int)
}

class ReferEarnPresenter: ReferEarnPresentationLogic {
    weak var viewController: ReferEarnDisplayLogic?
    
    // MARK: Do something
    
    func presentReferFriendResponse(response: ReferEarn.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveReferEarnResponse(response: response, message: message, successCode: successCode)
    }
}
