

import UIKit

protocol DashBoardPresentationLogic {
    
    func presentDashboardResponse(response: DashBoard.ViewModel?,message: String, successCode: Int)
    func presentDashboardListResponse(response: DashBoardList.ViewModel?,message: String, successCode: Int)
    func presentClearCartResponse(response: AddCart.ViewModel?,message: String, successCode: Int)
}

class DashBoardPresenter: DashBoardPresentationLogic {
    weak var viewController: DashBoardDisplayLogic?
    
    func presentDashboardResponse(response: DashBoard.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveDashBoardResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentDashboardListResponse(response: DashBoardList.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveDashBoardListResponse(response: response, message: message, successCode: successCode)
    }
    
    func presentClearCartResponse(response: AddCart.ViewModel?,message: String, successCode: Int) {
        viewController?.didReceiveClearCartResponse(response: response, message: message, successCode: successCode)
    }
}
