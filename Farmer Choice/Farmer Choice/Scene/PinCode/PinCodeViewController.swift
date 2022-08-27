
import UIKit

protocol PinCodeDisplayLogic: class {
    func didReceivePinCodeResponse(response: PinCode.ViewModel?, message: String, successCode: Int)
}

class PinCodeViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var srchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    
    var areaId = ""
    var area = false
    var areadData = [PinCode.Area_list]()
    var pinCodeData = [PinCode.Pincode_list]()
    var searchAreaData = [PinCode.Area_list]()
    var searchPinCodeData = [PinCode.Pincode_list]()
    var selectedDelegate : selectAreaPincode?
    
    var deliveryAddress = false
    var deliveryTimeSlot = [DeliveryAddress.Timeslot]()
    var deliveryTimeSlotSecond = [TimeSlot.Timeslot]()
    var deliveryDelegate: SelectDelivery?
    
    var interactor: PinCodeBusinessLogic?
    var router: (NSObjectProtocol & PinCodeRoutingLogic & PinCodeDataPassing)?
    
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
        let interactor = PinCodeInteractor()
        let presenter = PinCodePresenter()
        let router = PinCodeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    class func instance() -> PinCodeViewController? {
        return UIStoryboard(name: "PinCode", bundle: nil)
            .instantiateViewController(withIdentifier: "PinCodeViewController") as? PinCodeViewController
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if deliveryAddress {
            if deliveryTimeSlot.count != 0 {
                self.tblHeightConstraint.constant  = CGFloat(self.deliveryTimeSlot.count * 60)
            }else {
                 self.tblHeightConstraint.constant  = CGFloat(self.deliveryTimeSlotSecond.count * 60)
            }
            
            self.srchBar.isHidden = true
            self.lblTitle.text = "Choose Time Slot"
            
        }else {
            if area {
                self.lblTitle.text = "Choose Area"
                self.srchBar.placeholder = "Search by Name"
                self.tblHeightConstraint.constant  = CGFloat(self.searchAreaData.count * 60) + 60
                
            }else {
                self.lblTitle.text = "Choose Pincode"
                self.srchBar.placeholder = "Search Pincode"
                
            }
            let request = PinCode.Request(areaId: self.areaId)
            interactor?.callPinCodeApi(request: request)
        }
        
    }
    
    @IBAction func btnCamcelAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}

extension PinCodeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.deliveryAddress {
            if deliveryTimeSlot.count != 0 {
                return self.deliveryTimeSlot.count
            }else {
                return self.deliveryTimeSlotSecond.count
            }
            
        }else {
            if area {
                return searchAreaData.count
            }else {
                return searchPinCodeData.count
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.deliveryAddress {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PinCodeTableViewCell", for: indexPath) as! PinCodeTableViewCell
            if deliveryTimeSlot.count != 0  {
                 cell.lblTitle.text = self.deliveryTimeSlot[indexPath.row].start_time ?? ""
            }else {
                 cell.lblTitle.text = self.deliveryTimeSlotSecond[indexPath.row].start_time ?? ""
            }
           
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PinCodeTableViewCell", for: indexPath) as! PinCodeTableViewCell
            if area {
                cell.lblTitle.text = searchAreaData[indexPath.row].name ?? ""
            }else {
                cell.lblTitle.text = searchPinCodeData[indexPath.row].name ?? ""
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.deliveryAddress {
             if deliveryTimeSlot.count != 0  {
                self.deliveryDelegate?.setData(timSlot: self.deliveryTimeSlot[indexPath.row].start_time ?? "", timeId: self.deliveryTimeSlot[indexPath.row].id ?? "")
             }else {
                self.deliveryDelegate?.setData(timSlot: self.deliveryTimeSlotSecond[indexPath.row].start_time ?? "", timeId: self.deliveryTimeSlotSecond[indexPath.row].id ?? "")
            }
            
        }else {
            if area {
                self.selectedDelegate?.selectedData(area: area, id: searchAreaData[indexPath.row].areaID ?? "", name: searchAreaData[indexPath.row].name ?? "")
                self.dismiss(animated: false, completion: nil)
            }else {
                self.selectedDelegate?.selectedData(area: area, id: searchPinCodeData[indexPath.row].pincodeID ?? "", name: searchPinCodeData[indexPath.row].name ?? "")
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
}

extension PinCodeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            if area {
                self.searchAreaData = self.areadData
            }else {
                self.searchPinCodeData = self.pinCodeData
            }
        }else {
            if area {
                searchAreaData = areadData.filter{((($0.name ?? "")!).lowercased().contains(self.srchBar.text?.lowercased() ?? "") )}
            }else {
                searchPinCodeData = pinCodeData.filter{((($0.name ?? "")!).lowercased().contains(self.srchBar.text?.lowercased() ?? "") )}
            }
        }
        tblView.reloadData()
    }
}

extension PinCodeViewController: PinCodeDisplayLogic {
    func didReceivePinCodeResponse(response: PinCode.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                if let aRes = data.area_list {
                    self.areadData = aRes
                }
                if let pRes = data.pincode_list {
                    self.pinCodeData = pRes
                    self.searchPinCodeData = pRes
                }
                
                if let aRes = data.area_list {
                    self.searchAreaData = aRes
                }
                
                if area {
                    if (UIScreen.main.bounds.height - 180.0) < CGFloat(self.searchAreaData.count * 60) {
                        self.tblHeightConstraint.constant = (UIScreen.main.bounds.height - 180.0)
                    }else {
                        self.tblHeightConstraint.constant = CGFloat(self.searchAreaData.count * 60)
                    }
                    
                }else {
                    if (UIScreen.main.bounds.height - 180.0) < CGFloat(self.searchPinCodeData.count * 60) {
                        self.tblHeightConstraint.constant = (UIScreen.main.bounds.height - 180.0)
                    }else {
                        self.tblHeightConstraint.constant = CGFloat(self.searchPinCodeData.count * 60)
                    }
                    
                }
                
                self.tblView.reloadData()
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    
}
