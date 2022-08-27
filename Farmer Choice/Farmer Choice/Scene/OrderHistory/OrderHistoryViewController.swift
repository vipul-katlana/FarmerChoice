
import UIKit


protocol OrderCancel {
    func cancel(message: String)
}

protocol OrderHistoryDisplayLogic: class {
    func didReceiveOrderHistory(response: OrderHistory.ViewModel?, message: String, successCode: Int)
    func didReceiveCancelOrder(response: CancelOrder.ViewModel?, message: String, successCode: Int)
    func didReceiveReOrder(response: ReOrder.ViewModel?, message: String, successCode: Int)
    
    
}

class OrderHistoryViewController: BaseViewController {
    var interactor: OrderHistoryBusinessLogic?
    var router: (NSObjectProtocol & OrderHistoryRoutingLogic & OrderHistoryDataPassing)?
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewNorecord: UIView!
    
    var orderHistoryList = [OrderHistory.OrderList]()
    var cancelOrderId = ""
    
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
        let interactor = OrderHistoryInteractor()
        let presenter = OrderHistoryPresenter()
        let router = OrderHistoryRouter()
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
        setUpLayout()
        
        //self.viewNorecord.addSubview(self.getNoDataView(filename: "no_order", view: self.viewNorecord, size: 180))
    }
    
    func setUpLayout() {
        let request = OrderHistory.Request(pageCode: "0")
        interactor?.callOrderHistoryAPI(request: request)
    }
    class func instance() -> OrderHistoryViewController? {
        return UIStoryboard(name: "OrderHistory", bundle: nil).instantiateViewController(withIdentifier: "OrderHistoryViewController") as? OrderHistoryViewController
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHomeAction(_ sender: Any) {
        self.redirectToHome()
    }
    
    @IBAction func btnInfoAction(_ sender: Any) {
        self.redirectToHelp()
    }
    
    @IBAction func btnListAction(_ sender: Any) {
    }
    
    @IBAction func btnWalletAction(_ sender: Any) {
        self.redirectToWallet()
    }
    
    @IBAction func btnStartShoppingActiopn(_ sender: Any) {
        self.redirectToHome()
    }
}

extension OrderHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderHistoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHistoryTableViewCell", for: indexPath) as! OrderHistoryTableViewCell
        cell.setData(data: orderHistoryList[indexPath.row])
        
        cell.reorderClouser = {
            self.displayAlert(msg: "Are you sure you want to reorder?", ok: "Yes", cancel: "No", okAction: {
                let id = "\(self.orderHistoryList[indexPath.row].orderNo ?? "0")"
                let request = ReOrder.Request(orderId: String(id.dropFirst()))
                self.interactor?.callReOrderAPI(request: request)
            }, cancelAction: nil)
        }
        
        cell.detailsClouser = {
            if let VC = OrdersDetailsViewController.instance() {
                let id = "\(self.orderHistoryList[indexPath.row].orderNo ?? "0")"
                VC.orderId = String(id.dropFirst())
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
        
        cell.cancelClouser = {
            let id = "\(self.orderHistoryList[indexPath.row].orderNo ?? "0")"
            self.cancelOrderId = String(id.dropFirst())
            if let VC = CancelOrderViewController.instance() {
                VC.modalPresentationStyle = .overCurrentContext
                VC.dele = self
                self.present(VC, animated: false, completion: nil)
            }
        }
        return cell
    }
    
    
}

extension OrderHistoryViewController: OrderHistoryDisplayLogic {
    func didReceiveOrderHistory(response: OrderHistory.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                self.orderHistoryList = data.orderList!
                if (data.orderList?.count ?? 0) == 0 {
                    viewNorecord.isHidden = false
                }else {
                    viewNorecord.isHidden = true
                }
                self.tblView.reloadData()
            }
            
        }else {
            viewNorecord.isHidden = false
            //self.showTopMessage(message: message, type: .Error)
        }
    }
    
    
    func didReceiveCancelOrder(response: CancelOrder.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            self.showTopMessage(message: message, type: .Success)
            let request = OrderHistory.Request(pageCode: "0")
            interactor?.callOrderHistoryAPI(request: request)
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    func didReceiveReOrder(response: ReOrder.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if response != nil {
                UserDefaultsManager.setCartCount(count: response?.cart_items ?? "")
                UserDefaultsManager.setCartAmount(amount: response?.cart_amount ?? "")
                self.redirectToCart()
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
}

extension OrderHistoryViewController: OrderCancel {
    
    func cancel(message: String) {
        if message == "" {
            self.dismiss(animated: false, completion: nil)
        }else {
            self.dismiss(animated: false, completion: nil)
            let request = CancelOrder.Request(reason: message, orderId: cancelOrderId)
            interactor?.callCancelOrderAPI(request: request)
        }
        
    }
    
}
