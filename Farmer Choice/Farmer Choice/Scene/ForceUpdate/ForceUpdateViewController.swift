
import UIKit

class ForceUpdateViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    var titleMessage = ""
    var clouer: (()->())?
    var forceUpdate = false
    @IBOutlet weak var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitle.text = titleMessage
        if forceUpdate {
            self.btnCancel.isHidden = true
        }else {
            self.btnCancel.isHidden = false
        }
    }
    
    class func instance() -> ForceUpdateViewController? {
        return UIStoryboard(name: "ForceUpdate", bundle: nil).instantiateViewController(withIdentifier: "ForceUpdateViewController") as? ForceUpdateViewController
    }
    
    @IBAction func btnUpdateAction(_ sender: Any) {
        if clouer != nil {
            clouer!()
        }
        
    }
    
    @IBAction func btnCancelAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
