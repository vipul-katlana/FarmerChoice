

import UIKit

class ChangeAddressWorker {
    
    func callAddressAPI(request:ChangeAddress.Request ,completionHandler: @escaping(ChangeAddress.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        let createUrl = AppConstant.baseUrl + "change_info&userID=\(user?.userId ?? "")&name=\(request.name)&userPhone=\(request.phone)&city=\(request.city)&address=\(request.address)&area=\(request.area)&area_id=\(request.area_id)&pincode=\(request.pinCode)&email=\(request.email)&lat=\(request.lat)&long=\(request.long)&mapLocation=\(request.mapLocation)&landmark=\(request.landMark)&cityID=\(UserDefaultsManager.getCityId())"
        
        let paramter = ["userID": (user?.userId ?? ""),
                        "userPhone": request.phone,
                        "email": request.email,
                        "name": request.name,
                        "city": request.city,
                        "landmark": request.landMark,
                        "address": request.address,
                        "area": request.area,
                        "pincode": request.pinCode,
                        "area_id": request.area_id,
                        "lat": request.lat,
                        "long":request.long,
                        "mapLocation": request.mapLocation,
                        "cityID" : UserDefaultsManager.getCityId()
        ]
        
        NetworkService.uploadImageAndData(with: paramter, imageData: Data()) { (response: WSResponse<ChangeAddress.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
}
