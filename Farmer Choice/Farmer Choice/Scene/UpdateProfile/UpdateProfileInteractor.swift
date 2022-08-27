

import UIKit

protocol UpdateProfileBusinessLogic {
    func callUpdateProfileApi(request: UpdateProfile.Request)
}

protocol UpdateProfileDataStore {
    //var name: String { get set }
}

class UpdateProfileInteractor: UpdateProfileBusinessLogic, UpdateProfileDataStore {
    var presenter: UpdateProfilePresentationLogic?
    var worker: UpdateProfileWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func callUpdateProfileApi(request: UpdateProfile.Request) {
        worker = UpdateProfileWorker()
        worker?.callUpdateProfileAPI(request: request, completionHandler: { (response, message, successCode) in
            self.presenter?.presentUpdateProfile(response: response, message: message ?? "", successCode: successCode ?? 0)
        })
    }
}
