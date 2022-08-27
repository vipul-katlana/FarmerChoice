
import UIKit

protocol HelpCenterPresentationLogic {
    func presentSubmitHelp(message: String, successCode: Int)
}

class HelpCenterPresenter: HelpCenterPresentationLogic {
    weak var viewController: HelpCenterDisplayLogic?
    
    // MARK: Do something
    
    func presentSubmitHelp(message: String, successCode: Int) {
        viewController?.didReceiveSubmitHelpResponse(message: message, successCode: successCode)
    }
}
