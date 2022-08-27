

import UIKit

protocol ChangeAddressBusinessLogic {
    func callChangeAddressAPI(request: ChangeAddress.Request)
}

protocol ChangeAddressDataStore
{
    //var name: String { get set }
}

class ChangeAddressInteractor: ChangeAddressBusinessLogic, ChangeAddressDataStore
{
    var presenter: ChangeAddressPresentationLogic?
    var worker: ChangeAddressWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func callChangeAddressAPI(request: ChangeAddress.Request) {
        worker = ChangeAddressWorker()
        worker?.callAddressAPI(request: request, completionHandler: { (response, message, statusCode) in
            self.presenter?.presentChangeAddressResponse(response: response, message: message ?? "", successCode: statusCode ?? 0)
        })
    }
}
