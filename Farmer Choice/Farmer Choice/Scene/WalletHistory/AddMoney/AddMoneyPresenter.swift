

import UIKit

protocol AddMoneyPresentationLogic {
    func presentPayTmDetails(response: [PaytmIntegration.ViewModel]?,message: String, successCode: Int)
    func presentPayTmOrder(response: PaytmOrderResult.ViewModel?,message: String, successCode: Int)
}

class AddMoneyPresenter: AddMoneyPresentationLogic {
    weak var viewController: AddMoneyDisplayLogic?
    
    // MARK: Do something
    
    func presentPayTmDetails(response: [PaytmIntegration.ViewModel]?,message: String, successCode: Int) {
        viewController?.didReceivePayTmDetails(response: response, message: message, successCode: successCode)
    }
    
    func presentPayTmOrder(response: PaytmOrderResult.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceivePayTmOrder(response: response, message: message, successCode: successCode)
    }
}
