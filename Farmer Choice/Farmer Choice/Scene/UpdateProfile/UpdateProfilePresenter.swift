

import UIKit

protocol UpdateProfilePresentationLogic {
    func presentUpdateProfile(response: UpdateProfile.ViewModel?,message: String, successCode: Int)
}

class UpdateProfilePresenter: UpdateProfilePresentationLogic {
    weak var viewController: UpdateProfileDisplayLogic?
    
    // MARK: Do something
    
    func presentUpdateProfile(response: UpdateProfile.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveUpdateProfileResponse(response: response, message: message, successCode: successCode)
    }
}
