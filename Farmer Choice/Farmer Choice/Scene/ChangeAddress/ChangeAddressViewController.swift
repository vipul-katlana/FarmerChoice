
import UIKit

protocol ChangeAddressDisplayLogic: class {
    
    func didReceiveChangeAddressResponse(response: ChangeAddress.ViewModel?, message: String, successCode: Int)
    
}

class ChangeAddressViewController: BaseViewController {
    
    @IBOutlet weak var imgLocationIcon: UIImageView!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var viewMobile: UIView!
    @IBOutlet weak var txtFieldMobile: UITextField!
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var txtFieldAddress: UITextField!
    @IBOutlet weak var viewLandMark: UIView!
    @IBOutlet weak var txtFieldLandmark: UITextField!
    @IBOutlet weak var viewPinCode: UIView!
    @IBOutlet weak var txtFieldPinCode: UITextField!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var txtFieldCity: UITextField!
    @IBOutlet weak var viewArea: UIView!
    @IBOutlet weak var txtFieldArea: UITextField!
    @IBOutlet weak var lblMapLocation: UILabel!
    
    var resData: DeliveryAddress.ViewModel?
    
    var areaId = ""
    var lat = ""
    var long = ""
    var mapLocation = ""
    
    var oldCityId = ""
    var apiCall = false
    
    var interactor: ChangeAddressBusinessLogic?
    var router: (NSObjectProtocol & ChangeAddressRoutingLogic & ChangeAddressDataPassing)?
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ChangeAddressInteractor()
        let presenter = ChangeAddressPresenter()
        let router = ChangeAddressRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if !apiCall {
            let tm = self.resData
            var tmDetails =  tm?.get_detail?.first
            tmDetails?.cityID = self.oldCityId
            tm?.get_detail?[0] = tmDetails!
            self.resData = tm
        }
    }
    
    class func instance() -> ChangeAddressViewController? {
        return UIStoryboard(name: "ChangeAddress", bundle: nil).instantiateViewController(withIdentifier: "ChangeAddressViewController") as?  ChangeAddressViewController
    }
    
    func setUpLayout() {
        self.viewName.setBorder()
        self.viewEmail.setBorder()
        self.viewMobile.setBorder()
        self.viewAddress.setBorder()
        self.viewLandMark.setBorder()
        self.viewArea.setBorder()
        self.viewPinCode.setBorder()
        self.viewCity.setBorder()
        
        
        self.imgLocationIcon.image = self.imgLocationIcon.image?.withRenderingMode(.alwaysTemplate)
               self.imgLocationIcon.tintColor = AppConstant.appGreenColor!
        
        self.setInitialData()
        
        if UserDefaultsManager.getCityId() != self.resData?.get_detail?.first?.cityID ?? "" {
            var tm = self.resData
            self.oldCityId = tm?.get_detail?.first?.cityID ?? ""
            var tmDetails =  tm?.get_detail?.first
            tmDetails?.cityID = UserDefaultsManager.getCityId()
            tm?.get_detail?[0] = tmDetails!
            self.resData = tm
            self.txtFieldPinCode.text = ""
            self.txtFieldArea.text = ""
            self.txtFieldCity.text = UserDefaultsManager.getCityName()
            self.txtFieldCity.isUserInteractionEnabled = false
        }
        
        
    }
    
    func setInitialData() {
        if let userDetails = self.resData?.get_detail?[0] {
            self.txtFieldName.text = userDetails.name ?? ""
            self.txtFieldEmail.text = userDetails.email ?? ""
            self.txtFieldMobile.text = userDetails.phone ?? ""
            self.txtFieldAddress.text = userDetails.address ?? ""
            self.txtFieldLandmark.text = userDetails.landmark ?? ""
            self.txtFieldArea.text = userDetails.pincode ?? ""
            self.txtFieldPinCode.text = userDetails.pincode ?? ""
            self.txtFieldCity.text = userDetails.city ?? ""
            self.areaId = userDetails.area_id ?? ""
            self.mapLocation = userDetails.mapLocation ?? ""
            if userDetails.lat ?? "" != "" {
                self.lat = userDetails.lat ?? ""
                self.long = userDetails.longi ?? ""
            }
            
            self.lblMapLocation.text = userDetails.mapLocation ?? ""
        }
    }
    
    
    func validatFields() {
        guard self.internetAvailable() else {
            return
        }
        do {
            _ = try txtFieldName.validatedText(validationType: ValidatorType.username,
                                               visibility: true, optional: false)
            
            _ = try txtFieldEmail.validatedText(validationType: ValidatorType.email,
                                                visibility: true, optional: false)
            
            _ = try txtFieldMobile.validatedText(validationType: ValidatorType.phone,
                                                 visibility: true, optional: false)
            
            if txtFieldAddress.text?.trimmingCharacters(in: .whitespaces) == "" {
                self.showTopMessage(message: "Please enter address", type: .Error)
            }else if txtFieldLandmark.text?.trimmingCharacters(in: .whitespaces) == "" {
                self.showTopMessage(message: "Please enter landmark", type: .Error)
            }
            else if txtFieldArea.text?.trimmingCharacters(in: .whitespaces) == "" {
                self.showTopMessage(message: "Please enter zipcode", type: .Error)
            }
            else if txtFieldArea.text?.count != 6 {
                self.showTopMessage(message: "Please enter 6 digit zipcode", type: .Error)
            }
            else if self.lat == "" || self.long == "" {
                self.showTopMessage(message: "Please set map location for better delivery from map screen", type: .Error)
            }else if txtFieldCity.text?.trimmingCharacters(in: .whitespaces) == "" {
                self.showTopMessage(message: "Please enter state", type: .Error)
            }
            else {
                //call api here
                let request = ChangeAddress.Request(name: self.txtFieldName.text ?? "", phone: self.txtFieldMobile.text ?? "", city: self.txtFieldCity.text ?? "", address: self.txtFieldAddress.text ?? "", area:  "", area_id: self.areaId, pinCode: self.txtFieldArea.text ?? "", email: self.txtFieldEmail.text ?? "", lat: self.lat, long: self.long, mapLocation: self.mapLocation, landMark: self.txtFieldLandmark.text ?? "")
                interactor?.callChangeAddressAPI(request: request)
            }
            
           
            
        } catch(let error) {
            self.showTopMessage(message: (error as? ValidationError)?.message, type: .Error)
        }
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPinCodeAction(_ sender: Any) {
        if let customPopUp = PinCodeViewController.instance() {
            customPopUp.modalPresentationStyle = .overCurrentContext
            customPopUp.areaId = self.areaId
            customPopUp.area = false
            customPopUp.selectedDelegate = self
            self.present(customPopUp, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnAreaAction(_ sender: Any) {
        if let customPopUp = PinCodeViewController.instance() {
            customPopUp.modalPresentationStyle = .overCurrentContext
            customPopUp.areaId = self.areaId
            customPopUp.area = true
            customPopUp.selectedDelegate = self
            self.present(customPopUp, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        self.validatFields()
        
    }
}

extension ChangeAddressViewController: selectAreaPincode {
    func selectedData(area: Bool, id: String, name: String) {
        print(area, id, name)
        if area {
            self.areaId = id
            self.txtFieldArea.text = name
        }else {
            self.txtFieldPinCode.text = name
        }
    }
}


extension ChangeAddressViewController: ChangeAddressDisplayLogic {
    
    func didReceiveChangeAddressResponse(response: ChangeAddress.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let _ = response {
                NotificationCenter.default.post(name: Notification.Name("changeAddress"), object: nil)
                self.showTopMessage(message: message, type: .Success)
                apiCall = true
                let count = (self.navigationController?.viewControllers.count)!; self.navigationController?.popToViewController((self.navigationController?.viewControllers[(count - 3)])!, animated: true)
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
}
