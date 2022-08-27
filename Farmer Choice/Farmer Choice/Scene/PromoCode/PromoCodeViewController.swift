

import UIKit

protocol PromoCodeDisplayLogic: class {
    func didReceivePromoCodeListResponse(response: PromoCode.ViewModel?, message: String, successCode: Int)
    
    func didReceivePromoCodeApplyResponse(response: PromoCodeApply.ViewModel?, message: String, successCode: Int)
}

class PromoCodeViewController: UIViewController {
    var interactor: PromoCodeBusinessLogic?
    var router: (NSObjectProtocol & PromoCodeRoutingLogic & PromoCodeDataPassing)?
    
    var selectedTitle = ""
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtFieldCode: UITextField!
    @IBOutlet weak var btnApply: UIButton!
    
    var promoCodelist = [PromoCode.Coupon_list]()
    var promoDele: ApplyPromoCode?
    
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
        let interactor = PromoCodeInteractor()
        let presenter = PromoCodePresenter()
        let router = PromoCodeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.callPromoCodeList()
    }
    
    class func instance() -> PromoCodeViewController? {
        return UIStoryboard(name: "PromoCode", bundle: nil).instantiateViewController(withIdentifier: "PromoCodeViewController") as? PromoCodeViewController
    }
    
    @IBAction func btnApplyAction(_ sender: Any) {
        if txtFieldCode.text == "" {
            self.showTopMessage(message: "Please enter promocode", type: .Error)
        }else {
            let request = PromoCodeApply.Request(code: self.txtFieldCode.text ?? "")
            interactor?.applyPromoCode(request: request)
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}

extension PromoCodeViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count ?? 0 > 0 {
            self.btnApply.isHidden = false
        }else {
            self.btnApply.isHidden = true
        }
        return true
    }
    
    
}

extension PromoCodeViewController :UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promoCodelist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromoCodeTableViewCell", for: indexPath) as! PromoCodeTableViewCell
        cell.lblTitle.text = promoCodelist[indexPath.row].code ?? ""
        cell.lblDesc.text = promoCodelist[indexPath.row].msg ?? ""
        cell.btnApplyClouser = {
            self.selectedTitle = self.promoCodelist[indexPath.row].code ?? ""
            let request = PromoCodeApply.Request(code: self.promoCodelist[indexPath.row].code ?? "")
            self.interactor?.applyPromoCode(request: request)
        }
        return cell
    }
    
    
    
}


extension PromoCodeViewController: PromoCodeDisplayLogic {
    
    func didReceivePromoCodeListResponse(response: PromoCode.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                self.promoCodelist = data.coupon_list!
                self.tblView.reloadData()
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    func didReceivePromoCodeApplyResponse(response: PromoCodeApply.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let appData = response {
                if appData.coupon_id ?? "" != "" {
                    self.promoDele?.success(title: selectedTitle, message: appData.coupon_msg ?? "", id: appData.coupon_id ?? "", value: appData.coupon_value ?? "")
                    self.showTopMessage(message: message, type: .Success)
                }else {
                    self.showTopMessage(message: message, type: .Error)
                }
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
}
