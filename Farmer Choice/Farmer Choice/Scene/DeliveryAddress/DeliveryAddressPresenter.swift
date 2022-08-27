
import UIKit

protocol DeliveryAddressPresentationLogic {
    
    func presentDeliveryResponseResponse(response: DeliveryAddress.ViewModel?,message: String, successCode: Int)
    
    func presentTimeSlotResponseResponse(response: TimeSlot.ViewModel?,message: String, successCode: Int)
}

class DeliveryAddressPresenter: DeliveryAddressPresentationLogic {
    weak var viewController: DeliveryAddressDisplayLogic?
    
    // MARK: Do something
    
    func presentDeliveryResponseResponse(response: DeliveryAddress.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveDeliveryResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentTimeSlotResponseResponse(response: TimeSlot.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveTimeSlotResponse(response: response, message: message, successCode: successCode)
    }
}
