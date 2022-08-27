

import UIKit

protocol ChangeAddressPresentationLogic{
    
    func presentChangeAddressResponse(response: ChangeAddress.ViewModel?,message: String, successCode: Int)
}

class ChangeAddressPresenter: ChangeAddressPresentationLogic {
    weak var viewController: ChangeAddressDisplayLogic?
    
    // MARK: Do something
    
    func presentChangeAddressResponse(response: ChangeAddress.ViewModel?,message: String, successCode: Int) {
        
        viewController?.didReceiveChangeAddressResponse(response: response, message: message, successCode: successCode)
    }
}
