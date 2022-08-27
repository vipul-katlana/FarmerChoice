

import UIKit

protocol DeliveryAddressBusinessLogic {
    func callDeliveryApi(request: DeliveryAddress.Request,loader: Bool)
    func callTimeSlotApi(request: TimeSlot.Request)
}

protocol DeliveryAddressDataStore {
    //var name: String { get set }
}

class DeliveryAddressInteractor: DeliveryAddressBusinessLogic, DeliveryAddressDataStore {
    var presenter: DeliveryAddressPresentationLogic?
    var worker: DeliveryAddressWorker?
    
    func callDeliveryApi(request: DeliveryAddress.Request,loader: Bool) {
        worker = DeliveryAddressWorker()
        worker?.callDeliveryAPI(request: request,loader: loader,completionHandler: { (response, message, successCode) in
            self.presenter?.presentDeliveryResponseResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
    
    func callTimeSlotApi(request: TimeSlot.Request) {
        worker = DeliveryAddressWorker()
        worker?.callTimeSlotAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentTimeSlotResponseResponse(response: response, message: message ?? "" , successCode: successCode ?? 0)
        })
    }
}
