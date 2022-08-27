

import UIKit
import Alamofire

class AuthenticationWorker {
    
    func callLoginAPI(request: Login.Request, completionHandler: @escaping(Login.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let createUrl = AppConstant.baseUrl + "login19&user_phone=\(request.phoneNumber)"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<Login.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
    func callSignUpAPI(request: SignUp.Request, completionHandler: @escaping(SignUp.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let createUrl = AppConstant.baseUrl + "register19&name=\(request.name)&email=\(request.email)&phone=\(request.phone)&refer_code=\(request.referCode)&cityID=\(UserDefaultsManager.getCityId())"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<SignUp.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
}




