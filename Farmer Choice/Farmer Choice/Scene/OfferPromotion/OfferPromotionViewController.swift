
import UIKit

protocol OfferPromotionDisplayLogic: class {
    func didReceiveOfferPromotionResponse(response: OfferPromotion.ViewModel?, message: String, successCode: Int)
}

class OfferPromotionViewController: UIViewController {
    var interactor: OfferPromotionBusinessLogic?
    var router: (NSObjectProtocol & OfferPromotionRoutingLogic & OfferPromotionDataPassing)?
    
    @IBOutlet weak var tblView: UITableView!
    var offerList = [OfferPromotion.OfferList]()
    
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
        let interactor = OfferPromotionInteractor()
        let presenter = OfferPromotionPresenter()
        let router = OfferPromotionRouter()
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
        interactor?.callOfferPromotionAPI()
    }
    
    class func instance() -> OfferPromotionViewController? {
        return UIStoryboard(name: "OfferPromotion", bundle: nil).instantiateViewController(withIdentifier: "OfferPromotionViewController") as? OfferPromotionViewController
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension OfferPromotionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfferPromotionTableViewCell", for: indexPath) as! OfferPromotionTableViewCell
        cell.lblTitle.text = offerList[indexPath.row].title ?? ""
        cell.imgIcon.setImage(with: offerList[indexPath.row].image, placeHolder: UIImage(named: "common_OfferPlaceholder"))
        cell.lblDate.text = offerList[indexPath.row].added_on ?? ""
        cell.lblDesc.text = offerList[indexPath.row].message ?? ""
        cell.viewDetailsClouser = {
            if let VC = OfferPromotionDetailsViewController.instance() {
                VC.offerData = self.offerList[indexPath.row]
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
        cell.shareClouser = {
            let atext = "Share Code \(self.offerList[indexPath.row].title ?? "")"
            let activityVC = UIActivityViewController(activityItems: [atext], applicationActivities: nil)
            activityVC.setValue("\(AppInfo.kAppName) Code", forKey: "subject")
            self.present(activityVC, animated: true, completion: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let VC = OfferPromotionDetailsViewController.instance() {
            VC.offerData = self.offerList[indexPath.row]
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
}

extension OfferPromotionViewController: OfferPromotionDisplayLogic {
    func didReceiveOfferPromotionResponse(response: OfferPromotion.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                self.offerList = data.offerList!
                self.tblView.reloadData()
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
        
    }
    
    
}
