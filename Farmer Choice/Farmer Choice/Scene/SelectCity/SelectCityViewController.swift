

import UIKit
import Alamofire

protocol SelectCityDisplayLogic: class {
    func displaySomething(viewModel: SelectCity.Something.ViewModel)
}

protocol SelctArearList {
    func area(id: String, area: String)
}

class SelectCityViewController: UIViewController {
    var interactor: SelectCityBusinessLogic?
    var router: (NSObjectProtocol & SelectCityRoutingLogic & SelectCityDataPassing)?
    
    // MARK: Object lifecycle
    @IBOutlet weak var clctnView: UICollectionView!
    @IBOutlet weak var vwZipCode: UIView!
    @IBOutlet weak var txtZipCode: UITextField!
    
    @IBOutlet weak var clctHeight: NSLayoutConstraint!
    var cityData : AvailableCity?
    
    var isFormDashboard = false
    var dele: ChangeCity?
    
    var selectedAreaId = ""
    
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
        let interactor = SelectCityInteractor()
        let presenter = SelectCityPresenter()
        let router = SelectCityRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.vwZipCode.layer.borderWidth = 1
        self.vwZipCode.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        getCityData()
    }
    
    class func instance() -> SelectCityViewController? {
        return UIStoryboard(name: "SelectCity", bundle: nil).instantiateViewController(withIdentifier: "SelectCityViewController") as? SelectCityViewController
    }
    
    @IBAction func btnZipAction(_ sender: Any) {
        if txtZipCode.text == "" {
            self.showTopMessage(message: "Please select state", type: .Error)
        }else {
            //self.checkAvability(cityID: "", pinCode: self.txtZipCode.text ?? "")
            
            self.checkAvability(cityID: selectedAreaId, pinCode: "")
        }
    }
    
}

extension SelectCityViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityData?.User_data?.city_list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectCityCollectionViewCell", for: indexPath) as! SelectCityCollectionViewCell
        cell.clctnBG.layer.borderWidth = 1
        cell.clctnBG.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        cell.imgCity.setImage(with: cityData?.User_data?.city_list?[indexPath.row].icon ?? "")
        cell.lblCity.text = cityData?.User_data?.city_list?[indexPath.row].name ?? ""
        cell.lblState.text = cityData?.User_data?.city_list?[indexPath.row].state ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.checkAvability(cityID: cityData?.User_data?.city_list?[indexPath.row].cityID ?? "", pinCode: "")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.clctnView.frame.width / 2, height: 150.0)
    }
    
}

extension SelectCityViewController: SelectCityDisplayLogic {
    func displaySomething(viewModel: SelectCity.Something.ViewModel) {
        print("")
    }
    
    
}


extension SelectCityViewController {
    
    func getCityData() {
        
        DispatchQueue.main.async {
            GlobalUtility.showHud()
        }
       
        guard let url = URL(string: "\(AppConstant.baseUrl)city_list") else {
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
                            let result = try JSONDecoder().decode(AvailableCity.self, from: data)
                            self.cityData = result
                            //                        if (self.cityData?.User_data?.city_list?.count ?? 0) % 2 == 0 {
                            //                            self.clctHeight.constant = CGFloat(150 * ((self.cityData?.User_data?.city_list?.count ?? 0) / 2))
                            //                        }else {
                            //                            self.clctHeight.constant = CGFloat(150 * (((self.cityData?.User_data?.city_list?.count ?? 0) / 2) + 1))
                            //                        }
                            self.clctnView.reloadData()
                            
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
    
    
    
    func checkAvability(cityID: String, pinCode: String) {
        
        DispatchQueue.main.async {
            GlobalUtility.showHud()
        }
        
        guard let url = URL(string: "\(AppConstant.baseUrl)city_pincode_check&cityID=\(cityID)&pincode=\(pinCode)") else {
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
                            let result = try JSONDecoder().decode(AvailableCity.self, from: data)
                            if result.msgcode == "0" {
                                UserDefaultsManager.selectCityId(id: result.User_data?.city_list?.first?.cityID ?? "")
                                UserDefaultsManager.selectCityName(name: result.User_data?.city_list?.first?.name ?? "")
                                UserDefaultsManager.selectAreaId(areaId: result.User_data?.city_list?.first?.areaID ?? "")
                                if self.isFormDashboard {
                                    self.dele?.changed(success: true)
                                }else {
                                    let user = UserDefaultsManager.getLoggedUserDetails()
                                    if user?.userId != ""  && user?.userId != nil {
                                        AppConstant.appDelegate.setRootViewController()
                                    }else {
                                        if let VC = AuthenticationViewController.instance() {
                                            self.navigationController?.pushViewController(VC, animated: true)
                                        }
                                    }
                                }
                            }else {
                                if self.isFormDashboard {
                                    self.dele?.changed(success: false)
                                }else {
                                    if let VC = CityFormViewController.instance() {
                                        VC.zipCode = pinCode
                                        VC.cityID = cityID
                                        self.navigationController?.pushViewController(VC, animated: true)
                                    }
                                }
                                
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


extension SelectCityViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let VC = SelectAreaListViewController.instance() {
            VC.selectDele = self
            VC.modalPresentationStyle = .overCurrentContext
            VC.cityData = self.cityData
            self.present(VC, animated: false) {
                self.txtZipCode.resignFirstResponder()
            }
        }
    }
}


extension SelectCityViewController: SelctArearList {
    func area(id: String, area: String) {
        self.txtZipCode.text = area
        self.dismiss(animated: false, completion: nil)
        self.selectedAreaId = id
    }
    
    
}
