
import UIKit

protocol WalletHistoryDisplayLogic: class {
    func didReceiveWalletHistory(response: WalletHistory.ViewModel?, message: String, successCode: Int)
}

class WalletHistoryViewController: BaseViewController {
    var interactor: WalletHistoryBusinessLogic?
    var router: (NSObjectProtocol & WalletHistoryRoutingLogic & WalletHistoryDataPassing)?
    
    @IBOutlet weak var vwNoData: UIView!
    
    @IBOutlet weak var imgFirst: UIImageView!
    @IBOutlet weak var lblWalletBalance: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnAddMoney: UIButton!
    
    var data : WalletHistory.ViewModel?
    
    var walletList = [WalletHistory.TransactionData]()
    
    
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
        let interactor = WalletHistoryInteractor()
        let presenter = WalletHistoryPresenter()
        let router = WalletHistoryRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLayout()
    }
    
    func setUpLayout() {
        interactor?.callWalletHistoryAPI()
    }
    
    class func instance() -> WalletHistoryViewController? {
        return UIStoryboard(name: "WalletHistory", bundle: nil).instantiateViewController(withIdentifier: "WalletHistoryViewController") as? WalletHistoryViewController
    }
    
    @IBAction func btnBAckAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddMoneyAction(_ sender: Any) {
        if let VC = AddMoneyViewController.instance() {
            VC.walletAmount = self.data?.walletBal ?? ""
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnHomeAction(_ sender: Any) {
        self.redirectToHome()
    }
    
    @IBAction func btnInfoAction(_ sender: Any) {
        self.redirectToHelp()
    }
    
    @IBAction func btnListAction(_ sender: Any) {
        self.rediretToOrderList()
    }
    
    @IBAction func btnWalletAction(_ sender: Any) {
        //self.redirectToWallet()
    }
    
    @IBAction func btnNoDataAddMoney(_ sender: Any) {
        if let VC = AddMoneyViewController.instance() {
            VC.walletAmount = self.data?.walletBal ?? ""
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}

extension WalletHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return walletList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletHistoryTableViewCell", for: indexPath) as! WalletHistoryTableViewCell
        cell.lblDate.text = walletList[indexPath.row].TransactionDate ?? ""
        cell.lblTitle.text = walletList[indexPath.row].OrderID ?? ""
        cell.lblDesc.text = walletList[indexPath.row].Remark ?? ""
        cell.lblAmount.text = "\(walletList[indexPath.row].symbol ?? "") ₹\(walletList[indexPath.row].Amount ?? "")"
        if walletList[indexPath.row].symbol ?? "" == "+" {
            cell.lblAmount.textColor = AppConstant.appGreenColor
        }else {
            cell.lblAmount.textColor = #colorLiteral(red: 0.9294117647, green: 0.1098039216, blue: 0.1411764706, alpha: 1)
        }
        return cell
    }
    
    
}
extension WalletHistoryViewController: WalletHistoryDisplayLogic {
    func didReceiveWalletHistory(response: WalletHistory.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            print(successCode)
            if let data = response {
                self.data = data
                if data.add_money == "Yes" {
                    self.btnAddMoney.isHidden = false
                }else {
                    self.btnAddMoney.isHidden = true
                }
                if data.transactionData != nil {
                    self.walletList = data.transactionData!
                }
                
                self.lblWalletBalance.text = "₹\(data.walletBal ?? "")"
                
                
                self.tblView.reloadData()
                
                if self.walletList.count > 0 {
                    self.vwNoData.isHidden = true
                }else {
                    self.vwNoData.isHidden = false
                }
                
            }
        }else {
            //self.showTopMessage(message: message, type: .Error)
            if let data = response {
                if data.add_money == "Yes" {
                    self.btnAddMoney.isHidden = false
                }else {
                    self.btnAddMoney.isHidden = true
                }
            }
            
            self.vwNoData.isHidden = false
        }
    }
    
}
