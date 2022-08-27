
import UIKit
import Alamofire

class CityFormViewController: UIViewController {
    
    @IBOutlet weak var txtNname: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var vwname: UIView!
    @IBOutlet weak var vwAddress: UIView!
    @IBOutlet weak var vwMobile: UIView!
    
    var cityID = ""
    var zipCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBorder(vw: self.vwname)
        self.setBorder(vw: self.vwMobile)
        self.setBorder(vw: self.vwAddress)
    }
    
    class func instance() -> CityFormViewController? {
        return UIStoryboard(name: "SelectCity", bundle: nil).instantiateViewController(withIdentifier: "CityFormViewController") as? CityFormViewController
    }
    
    func setBorder(vw: UIView) {
        vw.layer.borderWidth = 1
        vw.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
    }
    
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        if txtNname.text == "" {
            self.showTopMessage(message: "Please enter your name", type: .Error)
        }else if txtAddress.text == "" {
            self.showTopMessage(message: "Please enter Email address", type: .Error)
        }else if txtMobile.text == "" {
            self.showTopMessage(message: "Please enter your mobile", type: .Error)
        }else {
            self.callFormAPI()
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CityFormViewController {
    
    func callFormAPI() {
        DispatchQueue.main.async {
            GlobalUtility.showHud()
        }
        
        guard let url = URL(string: "\(AppConstant.baseUrl)other_inq&name=\(self.txtNname.text ?? "")&email=\(txtAddress.text ??  "")&phone=\(self.txtMobile.text ?? "")") else {
            DispatchQueue.main.async {
                GlobalUtility.hideHud()
            }
            return
        }
        
        print("ROUTER BASE: \(url)")
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
        .responseJSON  { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                
                let request = responseObject.request
                let resp = responseObject.response
                let result = responseObject.result
                let responseString = String(data: responseObject.data!, encoding: .utf8)
                let error = result.error as NSError?
                Debug.printRequest(request, response: resp, responseString: responseString, error: error)
                DispatchQueue.main.async {
                    GlobalUtility.hideHud()
                }
                if let data =  responseObject.data {
                    do {
                        let result = try JSONDecoder().decode(SubmitForm.self, from: data)
                        if result.msgcode == "0" {
                            self.showTopMessage(message: result.message, type: .Success)
                            self.navigationController?.popViewController(animated: true)
                        }else {
                            self.showTopMessage(message: result.message, type: .Error)
                        }
                        

                        DispatchQueue.main.async {
                            GlobalUtility.hideHud()
                        }
                    } catch _ {
                        DispatchQueue.main.async {
                            GlobalUtility.hideHud()
                        }
                    }
                }
                
                return
            }
            if responseObject.result.isFailure {
                DispatchQueue.main.async {
                    GlobalUtility.hideHud()
                }
                return
            }
        }

    }
}
