

import UIKit

protocol WalletHistoryPresentationLogic {
    func presentWalletList(response: WalletHistory.ViewModel?, message: String, successCode: Int)
}

class WalletHistoryPresenter: WalletHistoryPresentationLogic {
    weak var viewController: WalletHistoryDisplayLogic?
    
    // MARK: Do something
    
    func presentWalletList(response: WalletHistory.ViewModel?, message: String, successCode: Int) {
        viewController?.didReceiveWalletHistory(response: response, message: message, successCode: successCode)
    }
}
