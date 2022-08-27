
import UIKit
import Alamofire

class PaymentOptionWorker {
    
    func callPaymentAPI(request: PaymentOption.Request, completionHandler: @escaping(PaymentOption.ViewModel?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        
        let createUrl = AppConstant.baseUrl + "checkout_data&userID=\(user?.userId ?? "")&userPhone=\(user?.phone ?? "")&area_id=\(request.areaID)&subtotal=\(UserDefaultsManager.getCartAmount())&express_selected=\(request.expressSelected)&cityID=\(UserDefaultsManager.getCityId())"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<PaymentOption.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.dictData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
    }
    
    func callOrderPlaceAPI(request: PlaceOrder.Request, completionHandler: @escaping([PlaceOrder.ViewModel]?,_ message: String?, _ successCode: Int?) -> Void) {
        let user = UserDefaultsManager.getLoggedUserDetails()
        
        let createUrl = AppConstant.baseUrl + "checkout_iphone&userID=\(user?.userId ?? "")&wallet_selected=\(request.wallet_selected)&bag_selected=\(request.bag_selected)&exp_delivery=\(request.exp_delivery)&order_total=\(request.order_total)&instruction=\(request.instruction)&del_time_order=\(request.del_time)&del_date_order=\(request.del_date)&DIS_AMOUNT=\(request.DIS_AMOUNT)&DIS_ID=\(request.DIS_ID)&payment_method=\(request.payment_method)&mobiletype=iPhone&cart_item_count=\(UserDefaultsManager.getCartCount())&super_wallet_selected=\(request.super_wallet_selected)&use_super_wallet=\(request.use_super_wallet)&cityID=\(UserDefaultsManager.getCityId())&appVersion=\(request.appVeriosn)"
        NetworkService.callServerAPI(with: createUrl) { (response: WSResponse<PlaceOrder.ViewModel>?, message: String?, successCode: Int?) in
            if let detail = response {
                completionHandler(detail.arrayData, detail.message, Int(detail.status ?? "0"))
            }else {
                completionHandler(nil,"Error",1)
            }
        }
        
    }
    
}

extension PaymentOptionWorker {
    func GetJson(_ param : NSDictionary) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: param, options: JSONSerialization.WritingOptions.prettyPrinted)
            let tempStr = String(data: jsonData, encoding: String.Encoding.utf8)
            return tempStr!
        } catch let error as NSError {
            print(error)
        }
        return ""
    }
}
