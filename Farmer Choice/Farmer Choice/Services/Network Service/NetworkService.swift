
import Foundation
import Alamofire
//import MBProgressHUD

public protocol NetworkProtocol {
    static func uploadDataRequest<Model: WSResponseData>(with inputRequest: RouterProtocol,showLoader: Bool, completionHandler: @escaping (Model?, String?,Int?) -> Void)
}

final class NetworkService {
    private init() {}
    
    static let boundaryConstant = "aRandomBoundary1837440"
    
    private static let manager: SessionManager = { () -> SessionManager in
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let sessionManager = SessionManager(configuration: configuration)
        return sessionManager
    }()
    
    enum DataResponse {
        case success(Data)
        case failure(Error)
    }
}

extension NetworkService: NetworkProtocol {
    
    static func uploadDataRequest<Model: WSResponseData>(with inputRequest: RouterProtocol,showLoader: Bool = true, completionHandler: @escaping (Model?, String?,Int?) -> Void) {
        
        print("ROUTER BASE", inputRequest.baseUrlString)
        print("ROUTER PARAMETERS", inputRequest.parameters ?? [:])
        print("ROUTER PATH", inputRequest.path)
        print("ROUTER VERB", inputRequest.method)
        
        if showLoader {
            GlobalUtility.showHud()
        }
        
        manager.upload(multipartFormData: { (multiPartData) in
            var reqParam = inputRequest.parameters ?? [String: Any]()
            reqParam[SessionConstant.WS_TOKEN] = FuelButlerSessionHandler.shared.wsToken
            
            if let files = inputRequest.files {
                for file in files {
                    multiPartData.append(file.data, withName: file.paramKey, fileName: file.fileName, mimeType: file.mimeType)
                    reqParam[file.paramKey] = "FILE"
                }
            }
            for (key, value) in reqParam {
                print("\(key) :: \(value)")
                
                if let intVal = value as? Int {
                    multiPartData.append("\(value)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: key)
                    
                    //                    multiPartData.append(intVal.data, withName: key)
                    
                }else {
                    multiPartData.append((value as! NSString).data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)!, withName: key)
                }
            }
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, with: inputRequest) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                upload.responseData(completionHandler: { (response) in
                    let request = response.request
                    let resp = response.response
                    let result = response.result
                    let responseString = String(data: response.data!, encoding: .utf8)
                    let error = result.error as NSError?
                    Debug.printRequest(request, response: resp, responseString: responseString, error: error)
                    GlobalUtility.hideHud()
                    
                    if let data = response.data {
                        do {
                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormat)
                            let decodedValue = try decoder.decode(Model.self, from: data)
                            completionHandler(decodedValue, nil , response.response?.statusCode)
                        } catch {
                            completionHandler(nil,(response.error?.localizedDescription)!,response.response?.statusCode)
                        }
                    } else {
                        completionHandler(nil, (response.error?.localizedDescription)!,response.response?.statusCode)
                    }
                })
            case .failure(let error):
                completionHandler(nil, nil,nil)
            }
        }
    }
    
    
    static func dataRequest<Model: WSResponseData>(with inputRequest: RouterProtocol,showLoader: Bool = true, completionHandler: @escaping (WSResponse<Model>?, String?,Int?) -> Void) {
        
        print("ROUTER BASE", inputRequest.baseUrlString)
        print("ROUTER PARAMETERS", inputRequest.parameters ?? [:])
        print("ROUTER PATH", inputRequest.path)
        print("ROUTER VERB", inputRequest.method)
        
        if !(NetworkReachabilityManager()!.isReachable) {
            let VC = AppConstant.appDelegate.window?.rootViewController
            VC?.showTopMessage(message: AlertMessage.InternetError, type: .Error)
            return
        }
        
        
        if showLoader {
            GlobalUtility.showHud()
        }
        do {
            _ = try inputRequest.asURLRequest()
        } catch let requestError {
            GlobalUtility.hideHud()
            completionHandler(nil, requestError.localizedDescription, nil)
            return
        }
        
        manager.upload(multipartFormData: { (multiPartData) in
            var reqParam = inputRequest.parameters ?? [String: Any]()
            if let files = inputRequest.files {
                for file in files {
                    multiPartData.append(file.data, withName: file.paramKey, fileName: file.fileName, mimeType: file.mimeType)
                    reqParam[file.paramKey] = "FILE"
                }
            }
            for (key, value) in reqParam {
                print("\(key) :: \(value)")
                multiPartData.append((value as! NSString).data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)!, withName: key)
            }
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, with: inputRequest) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                upload.responseData(completionHandler: { (response) in
                    let request = response.request
                    let resp = response.response
                    let result = response.result
                    let responseString = String(data: response.data!, encoding: .utf8)
                    let error = result.error as NSError?
                    Debug.printRequest(request, response: resp, responseString: responseString, error: error)
                    
                    GlobalUtility.hideHud()
                    
                    var finalResponseData: Data? = response.data
                    if let data = response.data, AppConstant.enableEncryption {
                        let strResult = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String?
                    }
                    
                    if let data = finalResponseData {
                        do {
                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormat)
                            let decodedValue = try decoder.decode(WSResponse<Model>.self, from: data)
                            
                            //                            if response.response?.statusCode ?? 0 == 401 {
                            //                                GlobalUtility.shared.currentTopViewController().showTopMessage(message: decodedValue.message ?? "", type: .Error)
                            //                                UserDefaultsManager.logoutUser()
                            //                                if let VC = LoginScreenViewController.instance() {
                            //                                    AppConstant.appDelegate.window?.rootViewController = VC
                            //                                }
                            //                            }
                            
                            completionHandler(decodedValue, nil , response.response?.statusCode)
                        } catch {
                            completionHandler(nil,(response.error?.localizedDescription) ?? nil ,response.response?.statusCode)
                        }
                    } else {
                        completionHandler(nil,(response.error?.localizedDescription) ?? nil ,response.response?.statusCode)
                    }
                })
                
            case .failure(_):
                completionHandler(nil, nil ,0)
            }
        }
    }
    
    static func tokenCreationDataRequest(with request: RouterProtocol, shouldShowLoader: Bool = true, completionHandler: @escaping (Data?, Error?) -> Void) {
        print("ROUTER BASE", request.baseUrlString)
        print("ROUTER PARAMETERS", request.parameters ?? [:])
        print("ROUTER PATH", request.path)
        print("ROUTER VERB", request.method)
        
        if shouldShowLoader {
            GlobalUtility.showHud()
        }
        
        do {
            _ = try request.asURLRequest()
        } catch let requestError {
            if shouldShowLoader {
                GlobalUtility.hideHud()
            }
            completionHandler(nil, requestError)
            return
        }
        Alamofire.request(request).responseData(completionHandler: { (response) in
            let request = response.request
            let resp = response.response
            let result = response.result
            let responseString = String(data: response.data!, encoding: .utf8)
            let error = result.error as NSError?
            Debug.printRequest(request, response: resp, responseString: responseString, error: error)
            if shouldShowLoader {
                GlobalUtility.hideHud()
            }
            
            if let data = response.data, AppConstant.enableEncryption {
                let strResult = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String?
                
                completionHandler(response.data, response.result.error)
                
            } else {
                completionHandler(response.data, response.result.error)
            }
        })
    }
    
    
    static func callServerAPI<Model: WSResponseData>(with inputRequest: String,showLoader: Bool = true, completionHandler: @escaping (WSResponse<Model>?, String?,Int?) -> Void)  {
        if showLoader {
            GlobalUtility.showHud()
        }
        let newInputUrl = inputRequest.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(newInputUrl ?? "")
        Alamofire.request(newInputUrl!).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    print(value)
                    
                    if let data = response.data {
                        do {
                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormat)
                            let decodedValue = try decoder.decode(WSResponse<Model>.self, from: data)
                            
                            GlobalUtility.hideHud()
                            completionHandler(decodedValue, nil , response.response?.statusCode)
                        } catch {
                            GlobalUtility.hideHud()
                            completionHandler(nil,(response.error?.localizedDescription) ?? nil ,response.response?.statusCode)
                        }
                    }
                    
                    
                }
            case .failure(let error):
                GlobalUtility.hideHud()
                print(error)
            }
        }
    }
    
    
    static func uploadImageAndData<Model: WSResponseData>(with parameters: [String:String], imageData: Data,  completionHandler: @escaping (WSResponse<Model>?, String?,Int?) -> Void){
        
        print(parameters)
        
        GlobalUtility.showHud()
        
        Alamofire.upload(
            multipartFormData: { MultipartFormData in
                for (key, value) in parameters {
                    MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
                MultipartFormData.append(imageData, withName: "file", fileName: "test1.jpg", mimeType: "image/jpg")
                
                
            }, to: "\(AppConstant.baseUrl + "change_info")") { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    GlobalUtility.hideHud()
                    if let value = response.result.value {
                        print(value)
                        
                        if let data = response.data {
                            do {
                                let decoder = JSONDecoder()
                                decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormat)
                                let decodedValue = try decoder.decode(WSResponse<Model>.self, from: data)
                                
                                GlobalUtility.hideHud()
                                completionHandler(decodedValue, nil , response.response?.statusCode)
                            } catch {
                                GlobalUtility.hideHud()
                                completionHandler(nil,(response.error?.localizedDescription) ?? nil ,response.response?.statusCode)
                            }
                        }
                        
                        
                    }
                }
                
            case .failure(let encodingError): break
                print(encodingError)
                GlobalUtility.hideHud()
            }
        }
    }
    
    
    
    static func callPostAPI<Model: WSResponseData>(with inputRequest: RouterProtocol,showLoader: Bool = true, completionHandler: @escaping (WSResponse<Model>?, String?,Int?) -> Void) {
        
        if showLoader {
            GlobalUtility.showHud()
        }
        let baseUrl = inputRequest.baseUrlString + inputRequest.path
        
        print("REQUEST URL: \(baseUrl)")
        print("REQUEST Parameters: \(String(describing: inputRequest.parameters))")
        
        
        
        Alamofire.upload(multipartFormData: { MultipartFormData in
            for (key, value) in inputRequest.parameters! {
                MultipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to: baseUrl) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    GlobalUtility.hideHud()
                    if let value = response.result.value {
                        print(value)
                        if let data = response.data {
                            do {
                                let decoder = JSONDecoder()
                                decoder.dateDecodingStrategy = .formatted(DateFormatter.customFormat)
                                let decodedValue = try decoder.decode(WSResponse<Model>.self, from: data)
                                GlobalUtility.hideHud()
                                completionHandler(decodedValue, nil , response.response?.statusCode)
                                GlobalUtility.hideHud()
                            } catch {
                                GlobalUtility.hideHud()
                                completionHandler(nil,(response.error?.localizedDescription) ?? nil ,response.response?.statusCode)
                                GlobalUtility.hideHud()
                            }
                        }
                        GlobalUtility.hideHud()
                    }
                }
                
            case .failure(let encodingError): break
                print(encodingError)
                GlobalUtility.hideHud()
            }
        }
        
        
        
    }
}
