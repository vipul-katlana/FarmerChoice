
import UIKit

protocol SelectDelivery {
    func setData(timSlot: String, timeId: String)
}

protocol DeliveryAddressDisplayLogic: class {
    func didReceiveDeliveryResponse(response: DeliveryAddress.ViewModel?, message: String, successCode: Int)
    
    func didReceiveTimeSlotResponse(response: TimeSlot.ViewModel?, message: String, successCode: Int)
}

class DeliveryAddressViewController: BaseViewController {
    
    @IBOutlet weak var viewExpressDelivery: UIView!
    @IBOutlet weak var btnAddAddre: UIButton!
    
    @IBOutlet weak var lblQty: UILabel!
    
    @IBOutlet weak var imgClok: UIImageView!
    @IBOutlet weak var imgCalender: UIImageView!
    @IBOutlet weak var imgProfileCall: UIImageView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblCartQty: UILabel!
    @IBOutlet weak var viewAdrs: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewTimeSlot: UIView!
    @IBOutlet weak var crtIon: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDeliveryChargeText: UILabel!
    @IBOutlet weak var btnSelectDate: UIButton!
    @IBOutlet weak var lblNOdelivery: UILabel!
    
    @IBOutlet weak var btnExpressDelivery: UIButton!
    @IBOutlet weak var lblExpressDelivery: UILabel!
    @IBOutlet weak var btnNormalDelivery: UIButton!
    @IBOutlet weak var viewNormalSelected: UIView!
    
   
    var expressDeliverySelected = false
    var resData: DeliveryAddress.ViewModel?
    var spclInst = ""
    var changeSlotTime = true
    var timeSlot : TimeSlot.ViewModel?
    
    var datePicker : UIDatePicker = UIDatePicker()
    var SelectedDay : String = ""
    
    var DeliveryTimeSlot : String = ""
    var DeliveryDateSlot : String = ""
    
    
    var interactor: DeliveryAddressBusinessLogic?
    var router: (NSObjectProtocol & DeliveryAddressRoutingLogic & DeliveryAddressDataPassing)?
    
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
        let interactor = DeliveryAddressInteractor()
        let presenter = DeliveryAddressPresenter()
        let router = DeliveryAddressRouter()
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: Date())
        let request = DeliveryAddress.Request(day: dayInWeek, timeSlot: "")
        interactor?.callDeliveryApi(request: request, loader: true)
        
        self.lblCartQty.text = "₹\(UserDefaultsManager.getCartAmount())"
        self.imgCalender.changePngColorTo(color: AppConstant.appGreenColor!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeAddress), name: Notification.Name("changeAddress"), object: nil)
        
        self.btnNormalDelivery.isSelected = true
        
        self.lblQty.text = "\(UserDefaultsManager.getCartCount()) Item"
        
        self.btnAddAddre.layer.cornerRadius = 7
        self.btnAddAddre.layer.borderWidth = 1
        self.btnAddAddre.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        
    }
    
    @objc func changeAddress(_ notification:Notification) {
        changeSlotTime = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: Date())
        let request = DeliveryAddress.Request(day: dayInWeek, timeSlot: "")
        interactor?.callDeliveryApi(request: request, loader: false)
    }
    
    func setUpLayout() {
      //  self.viewAdrs.setBorderWithColor(color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.4009683099))
        self.viewDate.setBorderWithColor(color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.4009683099))
        self.viewTimeSlot.setBorderWithColor(color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.4009683099))
        self.viewAdrs.setRoundCorner(radius: 5)
        self.viewDate.setRoundCorner(radius: 2)
        self.viewTimeSlot.setRoundCorner(radius: 3)
       // self.crtIon.changePngColorTo(color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        self.imgClok.changePngColorTo(color: AppConstant.appGreenColor!)
        self.GetSelectedDate(date: Date())
        
        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    class func instance() -> DeliveryAddressViewController? {
        return UIStoryboard(name: "DeliveryAddress", bundle: nil).instantiateViewController(withIdentifier: "DeliveryAddressViewController") as? DeliveryAddressViewController
    }
    
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEditAddressAction(_ sender: Any) {
        if let VC = MapLocationViewController.instance() {
            VC.resData = self.resData
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnTimeSlotAction(_ sender: Any) {
        if let VC = PinCodeViewController.instance() {
            VC.deliveryDelegate = self
            VC.deliveryAddress = true
            if self.resData?.timeslot != nil {
                VC.deliveryTimeSlot = (self.resData?.timeslot!)!
            }
            if timeSlot != nil {
                VC.deliveryTimeSlot = [DeliveryAddress.Timeslot]()
                VC.deliveryTimeSlotSecond = self.timeSlot?.timeslot ?? [TimeSlot.Timeslot]()
            }
            VC.modalPresentationStyle = .overCurrentContext
            self.present(VC, animated: false, completion: nil)
            
        }
    }
    
    
    @IBAction func btnProceedPaymentAction(_ sender: Any) {
        
        if self.resData?.get_detail?.first?.address == "" {
            self.displayAlert(msg: "Please add your complete address", ok: "Ok", cancel: "Cancel") {
                if let VC = MapLocationViewController.instance() {
                    VC.resData = self.resData
                    self.navigationController?.pushViewController(VC, animated: true)
                }
            } cancelAction: {
                print("")
            }

        }else {
            if self.expressDeliverySelected  {
                if self.internetAvailable() {
                    
                    if UserDefaultsManager.getCityId() == self.resData?.get_detail?.first?.cityID ?? "" {
                        if let VC = PaymentOptionViewController.instance() {
                            VC.areaId = resData?.get_detail?[0].area_id ?? ""
                            VC.expressDeliverySelected = expressDeliverySelected
                            VC.DeliveryTimeSlot =  ""
                            VC.DeliveryDateSlot =  ""
                            VC.orderSpecialInstruction = self.spclInst
                            self.navigationController?.pushViewController(VC, animated: true)
                        }
                    }else {
                        self.displayAlert(msg: "Selected items not delivered at your selected state, please change to proceed", ok: "Change", cancel: "Cancel") {
                            if let VC = MapLocationViewController.instance() {
                                VC.resData = self.resData
                                self.navigationController?.pushViewController(VC, animated: true)
                            }
                        } cancelAction: {
                            print("Cancel")
                        }
                        
                    }
                    
                    
                }
            }else {
                if self.viewTimeSlot.isHidden  {
                    self.showTopMessage(message: "Please select time slot", type: .Error)
                }else {
                    if self.internetAvailable() {
                        if UserDefaultsManager.getCityId() == self.resData?.get_detail?.first?.cityID ?? ""{
                            if let VC = PaymentOptionViewController.instance() {
                                VC.areaId = resData?.get_detail?[0].area_id ?? ""
                                VC.DeliveryTimeSlot = self.lblTime.text ?? ""
                                VC.expressDeliverySelected = expressDeliverySelected
                                VC.DeliveryDateSlot = self.btnSelectDate.titleLabel?.text ?? ""
                                VC.orderSpecialInstruction = self.spclInst
                                self.navigationController?.pushViewController(VC, animated: true)
                            }
                        }else {
                            self.displayAlert(msg: "Selected items not delivered at your selected state, please change to proceed", ok: "Change", cancel: "Cancel") {
                                if let VC = MapLocationViewController.instance() {
                                    VC.resData = self.resData
                                    self.navigationController?.pushViewController(VC, animated: true)
                                }
                            } cancelAction: {
                                print("Cancel")
                            }
                        }
                        
                    }
                }
            }
        }
        
        
    }
    
    @IBAction func btnSelectDateAction(_ sender: Any) {
        self.CreateDatePickerViewWithAlertController()
    }
    
    @IBAction func btnExpressAction(_ sender: Any) {
        self.btnExpressDelivery.isSelected = true
        self.btnNormalDelivery.isSelected = false
        self.viewNormalSelected.isHidden = true
        self.expressDeliverySelected = true
    }
    
    @IBAction func btnNormalAction(_ sender: Any) {
        self.btnExpressDelivery.isSelected = false
        self.btnNormalDelivery.isSelected = true
        self.viewNormalSelected.isHidden = false
        self.expressDeliverySelected = false
    }
    
    
    func CreateDatePickerViewWithAlertController() {
        let label = UILabel(frame: CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 30))
        label.textAlignment = .center
        label.text = "Set delivery date:"
        label.font = UIFont.systemFont(ofSize: 20)
        let viewDatePicker: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250))
        viewDatePicker.backgroundColor = UIColor.clear
        self.datePicker = UIDatePicker(frame: CGRect(x: 0, y: 40, width: self.view.frame.size.width, height: 200))
        self.datePicker.minimumDate = Date()
        
        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
        
        //NextDay Condition
        //Nextday Condtion
        //Incremnt days
        var nextDay = ""
        
        
        nextDay = self.resData?.next_days ?? ""
        
        var updateday : Int = 1
        
        if nextDay.isEmpty == false {
            if let tempDay = Int(nextDay) {
                updateday = tempDay
            }
        }
        
        let currentDate = Date()
        
        var dateComponent = DateComponents()
        dateComponent.day = updateday
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        print(currentDate)
        print(futureDate!)
        
        self.datePicker.maximumDate = futureDate
        
        
        var tempMinDay = 0
        tempMinDay = Int(self.resData?.tomorrow_day ?? 0)
        
        if tempMinDay > 0 {
            
            self.datePicker.minimumDate = Date().addingTimeInterval(TimeInterval(24 * 60 * 60 * tempMinDay))
            
            
            self.GetSelectedDate(date: Date().addingTimeInterval(TimeInterval(24 * 60 * 60 * tempMinDay)))
            
            
        }else {
            self.datePicker.minimumDate = Date()
            self.GetSelectedDate(date: Date())
        }
        
        
        //Finish NextDay
        
        self.datePicker.datePickerMode = UIDatePicker.Mode.date
        self.datePicker.locale = Locale(identifier: "en_GB")
        //        self.datePicker.addTarget(self, action: "datePickerSelected", forControlEvents: UIControlEvents.ValueChanged)
        self.datePicker.addTarget(self, action: #selector(DeliveryAddressViewController.handleDatePicker(_:)), for: UIControl.Event.valueChanged)
        
        viewDatePicker.addSubview(label)
        
        viewDatePicker.addSubview(self.datePicker)
        
        let alertController = UIAlertController(title: nil, message: "\n\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: UIAlertController.Style.actionSheet)
        
        alertController.view.addSubview(viewDatePicker)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        { (action) in
            // ...
        }
        
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Done", style: .default)
        { (action) in
            
            self.setDate()
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true)
        {
            // ...
        }
        
    }
    
    
    func GetSelectedDate(date : Date) {
        let formatter = DateFormatter()
        //let locale = Locale(identifier: "en_US_POSIX")
        //formatter.locale = locale
        formatter.dateFormat = "dd MMM yyyy"
        let dateStr = formatter.string(from: date)
        self.btnSelectDate.setTitle(dateStr, for: .normal)
        formatter.dateFormat = "dd-MM-yyyy"
        let orderDate = formatter.string(from: date)
        self.DeliveryDateSlot = orderDate
    }
    
    func GetSelectedDay(date : Date) -> String{
        let formatter = DateFormatter()
        //let locale = Locale(identifier: "en_US_POSIX")
        //formatter.locale = locale
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    
    func setDate(){
        self.GetSelectedDate(date: self.datePicker.date)
        self.SelectedDay = self.GetSelectedDay(date: self.datePicker.date)
        
        let request = TimeSlot.Request(day: SelectedDay)
        interactor?.callTimeSlotApi(request: request)
    }
    
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        //self.GetSelectedDate(date: self.datePicker.date)
    }
    
}

extension DeliveryAddressViewController: SelectDelivery {
    func setData(timSlot: String, timeId: String) {
        self.lblTime.text = timSlot
        self.dismiss(animated: false, completion: nil)
    }
}

extension DeliveryAddressViewController: DeliveryAddressDisplayLogic {
    func didReceiveDeliveryResponse(response: DeliveryAddress.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                self.resData = data
                self.lblAddress.text = "\(data.get_detail?[0].name ?? ""),\n\(data.get_detail?[0].address ?? ""),\n\(data.get_detail?[0].area ?? ""),\n\(data.get_detail?[0].city ?? "") - \(data.get_detail?[0].pincode ?? "")"
                self.lblPhoneNumber.text = data.get_detail?[0].phone ?? ""
                self.lblDeliveryChargeText.text = data.ship_charge_note ?? ""
                
                var tempMinDay = 0
                tempMinDay = Int(self.resData?.tomorrow_day ?? 0)
                if tempMinDay > 0 {
                    self.GetSelectedDate(date: Date().addingTimeInterval(TimeInterval(24 * 60 * 60 * tempMinDay)))
                    
                }else {
                    self.GetSelectedDate(date: Date())
                    
                }
                
                
                if changeSlotTime {
                    if data.timeslot?.count ?? 0 > 0  {
                        self.viewTimeSlot.isHidden = false
                        self.lblNOdelivery.isHidden = true
                        self.lblTime.text = data.timeslot?[0].start_time ?? ""
                    }else {
                        self.viewTimeSlot.isHidden = true
                        self.lblNOdelivery.isHidden = false
                        self.lblNOdelivery.text = data.time_slot_msg ?? ""
                    }
                }
                
                self.lblExpressDelivery.text = data.express_label
                if data.express_label == "" || data.express_label == nil {
                    self.viewExpressDelivery.isHidden = true
                }else {
                    self.viewExpressDelivery.isHidden = false
                }
                
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    
    func didReceiveTimeSlotResponse(response: TimeSlot.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                timeSlot = response
                if data.timeslot?.count ?? 0 > 0  {
                    self.viewTimeSlot.isHidden = false
                    self.lblNOdelivery.isHidden = true
                    self.lblTime.text = data.timeslot?[0].start_time ?? ""
                }else {
                    self.viewTimeSlot.isHidden = true
                    self.lblNOdelivery.isHidden = false
                    self.lblNOdelivery.text = data.time_slot_msg ?? ""
                }
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
}

