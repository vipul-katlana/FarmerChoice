

import UIKit

protocol FeedBackDisplayLogic: class {
    func didReceiveFeedBackResponse(response: FeedBack.ViewModel?, message: String, successCode: Int)
}

class FeedBackViewController: UIViewController {
    
    var interactor: FeedBackBusinessLogic?
    var router: (NSObjectProtocol & FeedBackRoutingLogic & FeedBackDataPassing)?
    
    
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var lblThird: UILabel!
    @IBOutlet weak var lblFourth: UILabel!
    @IBOutlet weak var lblFivth: UILabel!
    @IBOutlet weak var imgFirst: UIImageView!
    @IBOutlet weak var viewText: UIView!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var lblPlaceHolder: UILabel!
    var expression = ""
    var orderId = ""
    var delegateFeedBack: SendFeedBack?
    
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
        let interactor = FeedBackInteractor()
        let presenter = FeedBackPresenter()
        let router = FeedBackRouter()
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
        viewText.setBorderWithColor(color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.4009683099))
    }
    
    
    class func instance() -> FeedBackViewController? {
        return UIStoryboard(name: "FeedBack", bundle: nil).instantiateViewController(withIdentifier: "FeedBackViewController") as? FeedBackViewController
    }
    
    @IBAction func btnDismissAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func btnOneAction(_ sender: Any) {
        self.expression = "Terrible"
        self.lblFirst.font = UIFont(name: "Roboto-Regular", size: 18.0)
        self.lblSecond.font = UIFont(name: "Roboto-Light", size: 14.0)
        self.lblThird.font = UIFont(name: "Roboto-Light", size: 14.0)
        self.lblFourth.font = UIFont(name: "Roboto-Light", size: 14.0)
        self.lblFivth.font = UIFont(name: "Roboto-Light", size: 14.0)
    }
    
    @IBAction func btnSecondAction(_ sender: Any) {
        self.expression = "Bad"
        self.lblSecond.font = UIFont(name: "Roboto-Regular", size: 18.0)
        self.lblFirst.font = UIFont(name: "Roboto-Light", size: 14.0)
        self.lblThird.font = UIFont(name: "Roboto-Light", size: 14.0)
        self.lblFourth.font = UIFont(name: "Roboto-Light", size: 14.0)
        self.lblFivth.font = UIFont(name: "Roboto-Light", size: 14.0)
    }
    
    @IBAction func btnThirdAction(_ sender: Any) {
        self.expression = "Okay"
        self.lblThird.font = UIFont(name: "Roboto-Regular", size: 18.0)
        self.lblFirst.font = UIFont(name: "Roboto-Light", size: 14.0)
        self.lblSecond.font = UIFont(name: "Roboto-Light", size: 14.0)
        self.lblFourth.font = UIFont(name: "Roboto-Light", size: 14.0)
        self.lblFivth.font = UIFont(name: "Roboto-Light", size: 14.0)
    }
    
    @IBAction func btnFourthAction(_ sender: Any) {
        self.expression = "Good"
        self.lblFourth.font = UIFont(name: "Roboto-Regular", size: 18.0)
        self.lblFirst.font = UIFont(name: "Roboto-Light", size: 14.0)
        self.lblSecond.font = UIFont(name: "Roboto-Light", size: 14.0)
        self.lblThird.font = UIFont(name: "Roboto-Light", size: 14.0)
        self.lblFivth.font = UIFont(name: "Roboto-Light", size: 14.0)
    }
    
    @IBAction func btnFivthAction(_ sender: Any) {
        self.expression = "Great"
        self.lblFivth.font = UIFont(name: "Roboto-Regular", size: 18.0)
        self.lblFirst.font = UIFont(name: "Roboto-Light", size: 14.0)
        self.lblSecond.font = UIFont(name: "Roboto-Light", size: 14.0)
        self.lblThird.font = UIFont(name: "Roboto-Light", size: 14.0)
        self.lblFourth.font = UIFont(name: "Roboto-Light", size: 14.0)
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        if self.expression == "" {
            self.showTopMessage(message: "Please select expression", type: .Error)
        }else {
            let request = FeedBack.Request(orderId: self.orderId, expression: self.expression, message: self.txtView.text ?? "")
            interactor?.callFeedbackAPI(request: request)
        }
        
    }
    
}

extension FeedBackViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceHolder.isHidden = !txtView.text.isEmpty
    }
}

extension FeedBackViewController: FeedBackDisplayLogic {
    func didReceiveFeedBackResponse(response: FeedBack.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            delegateFeedBack?.success()
            self.showTopMessage(message: message, type: .Success)
            self.dismiss(animated: false, completion: nil)
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
}
