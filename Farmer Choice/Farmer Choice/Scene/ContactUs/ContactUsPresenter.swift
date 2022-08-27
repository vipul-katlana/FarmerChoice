

import UIKit

protocol ContactUsPresentationLogic {
    func presentContactUsResponse(response: ContactUs.ViewModel?,message: String, successCode: Int)
}

class ContactUsPresenter: ContactUsPresentationLogic {
    weak var viewController: ContactUsDisplayLogic?
    
    // MARK: Do something
    
    func presentContactUsResponse(response: ContactUs.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveContactUsResponse(response: response, message: message, successCode: successCode)
    }
}
