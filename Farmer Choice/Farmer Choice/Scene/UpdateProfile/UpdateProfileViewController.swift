
import UIKit


protocol selectAreaPincode {
    func selectedData(area:Bool,id: String, name: String)
}

protocol UpdateProfileDisplayLogic: class {
    func didReceiveUpdateProfileResponse(response: UpdateProfile.ViewModel?, message: String, successCode: Int)
}

class UpdateProfileViewController: BaseViewController {
    
    //MARK: IBOutlet & Constant
    @IBOutlet weak var imgProfile: UIImageView!
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
    @IBOutlet weak var viewWhatsAppNumber: UIView!
    @IBOutlet weak var txtFieldWhatsAppNumber: UITextField!
    @IBOutlet weak var viewBirthDate: UIView!
    @IBOutlet weak var txtFieldBirthDate: UITextField!
    @IBOutlet weak var viewMArrigeAnniversary: UIView!
    @IBOutlet weak var txtFieldMarrigeAnniversary: UITextField!
    
    var updateDelegate: UpdateProfileAction?
    var uploadedFile: Data?
    var pickedImageName = ""
    var fileType = ""
    var userData : MyAccountDetails.ViewModel?
    var areaId = ""
    var lat = ""
    var long = ""
    var mapLocation = ""
    var state = ""
    
    var oldCityId = ""
    var apiCall = false
    
    
    var interactor: UpdateProfileBusinessLogic?
    var router: (NSObjectProtocol & UpdateProfileRoutingLogic & UpdateProfileDataPassing)?
    
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
        let interactor = UpdateProfileInteractor()
        let presenter = UpdateProfilePresenter()
        let router = UpdateProfileRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //MARK: Class Instance
    class func instance() -> UpdateProfileViewController? {
        return UIStoryboard(name: "UpdateProfile", bundle: nil).instantiateViewController(withIdentifier: "UpdateProfileViewController") as? UpdateProfileViewController
    }
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLayout()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if !apiCall {
            let tm = self.userData
            var tmDetails =  tm?.get_detail?.first
            tmDetails?.cityID = self.oldCityId
            tm?.get_detail?[0] = tmDetails!
            self.userData = tm
        }
    }
    
    
    //MARK: Class Method
    func setUpLayout() {
        self.viewName.setBorder()
        self.viewEmail.setBorder()
        self.viewMobile.setBorder()
        self.viewAddress.setBorder()
        self.viewLandMark.setBorder()
        self.viewArea.setBorder()
        self.viewPinCode.setBorder()
        self.viewCity.setBorder()
        self.viewWhatsAppNumber.setBorder()
        self.viewBirthDate.setBorder()
        self.viewMArrigeAnniversary.setBorder()
        
        self.txtFieldBirthDate.setInputViewDatePicker(target: self, selector: #selector(tapBirthDone))
        self.txtFieldMarrigeAnniversary.setInputViewDatePicker(target: self, selector: #selector(tapAnniwersryDone))
        self.setInitialData()
        
        if UserDefaultsManager.getCityId() != self.userData?.get_detail?[0].cityID {
            
            var tm = self.userData
            self.oldCityId = tm?.get_detail?.first?.cityID ?? ""
            var tmDetails =  tm?.get_detail?.first
            tmDetails?.cityID = UserDefaultsManager.getCityId()
            tm?.get_detail?[0] = tmDetails!
            self.userData = tm
            self.txtFieldPinCode.text = ""
            self.txtFieldArea.text = ""
            self.txtFieldCity.text = UserDefaultsManager.getCityName()
            self.txtFieldCity.isUserInteractionEnabled = false
            
        }
    }
    
    func setInitialData() {
        if let userDetails = self.userData?.get_detail?[0] {
            self.imgProfile.setImage(with: userDetails.userimage ?? "",placeHolder: UIImage(named: "user_profile"))
            self.txtFieldName.text = userDetails.name ?? ""
            self.txtFieldEmail.text = userDetails.email ?? ""
            self.txtFieldMobile.text = userDetails.phone ?? ""
            self.txtFieldAddress.text = userDetails.address ?? ""
            self.txtFieldLandmark.text = userDetails.landmark ?? ""
            self.txtFieldArea.text = userDetails.area ?? ""
            self.txtFieldPinCode.text = userDetails.pincode ?? ""
            self.txtFieldCity.text = userDetails.city ?? ""
            self.txtFieldWhatsAppNumber.text = userDetails.whatsapp_no ?? ""
            self.txtFieldBirthDate.text = userDetails.date_of_birth ?? ""
            self.txtFieldMarrigeAnniversary.text = userDetails.mrg_anniversary ?? ""
            self.areaId = userDetails.area_id ?? ""
            self.lat = userDetails.lat ?? ""
            self.long = userDetails.longi ?? ""
            self.mapLocation = userDetails.mapLocation ?? ""
            self.state = userDetails.state ?? ""
        }
        
    }
    
    @objc func tapBirthDone() {
        if let datePicker = self.txtFieldBirthDate.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            //dateformatter.dateStyle = .medium
            dateformatter.dateFormat = "dd/MM/yyyy"
            
            self.txtFieldBirthDate.text = dateformatter.string(from: datePicker.date)
        }
        self.txtFieldBirthDate.resignFirstResponder()
    }
    
    @objc func tapAnniwersryDone() {
        if let datePicker = self.txtFieldMarrigeAnniversary.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            //dateformatter.dateStyle = .medium
            dateformatter.dateFormat = "dd/MM/yyyy"
            self.txtFieldMarrigeAnniversary.text = dateformatter.string(from: datePicker.date)
        }
        self.txtFieldMarrigeAnniversary.resignFirstResponder()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnOpenCameraAction(_ sender: Any) {
        CustomImagePicker.shared.openImagePickerWith(mediaType: .MediaTypeImage, allowsEditing: true, actionSheetTitle: AppInfo.kAppName, message: "", cancelButtonTitle: "Cancel", cameraButtonTitle: "Camera", galleryButtonTitle: "Gallery") { (_, success, dict) in
            if success {
                if let img = (dict!["edited_image"] as? UIImage) {
                    self.imgProfile.layer.cornerRadius = (self.imgProfile.frame.width) / 2
                    self.uploadedFile = img.compressTo(0.5)
                    self.fileType = "png"
                    self.pickedImageName = "\(NSTimeIntervalSince1970).png"
                    self.imgProfile.image = img
                    self.imgProfile.contentMode = .scaleAspectFill
                }
                
            }
        }
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
        
        var imgData = Data()
        if uploadedFile != nil {
            imgData = uploadedFile!
        } else if self.imgProfile.image != nil {
            imgData = imgProfile.image?.compressTo(0.5) ?? Data()
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
            else if txtFieldPinCode.text?.trimmingCharacters(in: .whitespaces) == "" {
                self.showTopMessage(message: "Please enter zipcode", type: .Error)
            }
            else if txtFieldPinCode.text?.count != 6 {
                self.showTopMessage(message: "Please enter 6 digit zipcode", type: .Error)
            }
            else if txtFieldCity.text?.trimmingCharacters(in: .whitespaces) == "" {
                self.showTopMessage(message: "Please enter state", type: .Error)
            }
            
            else {
                //call api here
                let request = UpdateProfile.Request(phone: self.txtFieldMobile.text ?? "", email: txtFieldEmail.text ?? "", name: txtFieldName.text ?? "", lastName: "", city: self.txtFieldCity.text ?? "", landMark: self.txtFieldLandmark.text ?? "", state: self.state , address: self.txtFieldAddress.text ?? "", area: self.txtFieldArea.text ?? "", pinCode: self.txtFieldPinCode.text ?? "", dateofBirth: self.txtFieldBirthDate.text ?? "", marrigeAni: txtFieldMarrigeAnniversary.text ?? "", whatsAppNumber: self.txtFieldWhatsAppNumber.text ?? "", areaid: self.areaId, lat: self.lat, long: self.long, mapLocation: self.mapLocation, imageData: imgData)
                interactor?.callUpdateProfileApi(request: request)
            }
            
           
            
        } catch(let error) {
            self.showTopMessage(message: (error as? ValidationError)?.message, type: .Error)
        }

        
        
//        let request = UpdateProfile.Request(phone: self.txtFieldMobile.text ?? "", email: txtFieldEmail.text ?? "", name: txtFieldName.text ?? "", lastName: "", city: self.txtFieldCity.text ?? "", landMark: self.txtFieldLandmark.text ?? "", state: self.state , address: self.txtFieldAddress.text ?? "", area: self.txtFieldArea.text ?? "", pinCode: self.txtFieldPinCode.text ?? "", dateofBirth: self.txtFieldBirthDate.text ?? "", marrigeAni: txtFieldMarrigeAnniversary.text ?? "", whatsAppNumber: self.txtFieldWhatsAppNumber.text ?? "", areaid: self.areaId, lat: self.lat, long: self.long, mapLocation: self.mapLocation, imageData: imgData)
//        interactor?.callUpdateProfileApi(request: request)
    }
    
    
}

extension UpdateProfileViewController: selectAreaPincode {
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

extension UpdateProfileViewController: UpdateProfileDisplayLogic {
    
    func didReceiveUpdateProfileResponse(response: UpdateProfile.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            self.apiCall = true
            self.showTopMessage(message: message, type: .Success)
            updateDelegate?.Success()
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
}

