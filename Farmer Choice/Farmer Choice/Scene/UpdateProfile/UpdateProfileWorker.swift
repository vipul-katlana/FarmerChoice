

import UIKit

class UpdateProfileWorker {
    
    func callUpdateProfileAPI(request:UpdateProfile.Request ,completionHandler: @escaping(UpdateProfile.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
       
        let paramter = ["userID": (user?.userId ?? ""),
                        "userPhone": request.phone,
                        "email": request.email,
                        "name": request.name,
                        "lastname": request.lastName,
                        "city": request.city,
                        "landmark": request.landMark,
                        "state":request.state,
                        "address": request.address,
                        "area": request.area,
                        "pincode": request.pinCode,
                        "date_of_birth": request.dateofBirth,
                        "mrg_anniversary": request.marrigeAni,
                        "whatsapp_no": request.whatsAppNumber,
                        "area_id": request.areaid,
                        "lat": request.lat,
                        "long":request.long,
                        "mapLocation": request.mapLocation
        ]
        
        NetworkService.uploadImageAndData(with: paramter, imageData: request.imageData) { (response: WSResponse<UpdateProfile.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
        
    }
}
