
import UIKit

protocol WalletHistoryBusinessLogic {
    func callWalletHistoryAPI()
}

protocol WalletHistoryDataStore {
    //var name: String { get set }
}

class WalletHistoryInteractor: WalletHistoryBusinessLogic, WalletHistoryDataStore {
    var presenter: WalletHistoryPresentationLogic?
    var worker: WalletHistoryWorker?
    
    func callWalletHistoryAPI() {
        worker = WalletHistoryWorker()
        worker?.callWalletHistoryAPI(completionHandler: { (response, message, successCode) in
            self.presenter?.presentWalletList(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
}
