

import UIKit

protocol DashBoardBusinessLogic {
    func callDashBoardApi(request: DashBoard.Request)
    func callDashBoardListAPI(request:DashBoardList.Request, loader: Bool)
    func callClearCartApi()
}

protocol DashBoardDataStore {
    //var name: String { get set }
}

class DashBoardInteractor: DashBoardBusinessLogic, DashBoardDataStore {
    var presenter: DashBoardPresentationLogic?
    var worker: DashBoardWorker?
    
    
    func callDashBoardApi(request: DashBoard.Request) {
        worker = DashBoardWorker()
        worker?.callDashBoardAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentDashboardResponse(response: response, message: message ?? "" , successCode: successCode ?? 0)
        })
    }
    
    func callDashBoardListAPI(request:DashBoardList.Request,loader: Bool) {
        worker = DashBoardWorker()
        worker?.callDashBoardListAPI(request: request ,loader:loader, completionHandler: { (response, message, successCode) in
            self.presenter?.presentDashboardListResponse(response: response, message: message ?? "" , successCode: successCode ?? 0)
        })
    }
    
    func callClearCartApi() {
        worker = DashBoardWorker()
        worker?.callEmptyCartAPI(completionHandler: { (response, message, successCode) in
            self.presenter?.presentClearCartResponse(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
    
    
}
