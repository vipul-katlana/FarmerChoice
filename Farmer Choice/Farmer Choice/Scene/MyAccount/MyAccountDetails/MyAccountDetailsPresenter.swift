

import UIKit

protocol MyAccountDetailsPresentationLogic {
    func presentMyProfileResponse(response: MyAccountDetails.ViewModel?,message: String, successCode: Int)
}

class MyAccountDetailsPresenter: MyAccountDetailsPresentationLogic {
    weak var viewController: MyAccountDetailsDisplayLogic?
    
    // MARK: Do something
    
    func presentMyProfileResponse(response: MyAccountDetails.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveMyProfileResponse(response: response, message: message, successCode: successCode)
    }
}
