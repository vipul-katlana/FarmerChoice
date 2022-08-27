

import UIKit

class CancelOrderViewController: UIViewController {
    
    
    @IBOutlet weak var lblPlaceHolder: UILabel!
    @IBOutlet weak var txtView: UITextView!
    var dele: OrderCancel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    class func instance() -> CancelOrderViewController? {
        return UIStoryboard(name: "OrderHistory", bundle: nil).instantiateViewController(withIdentifier: "CancelOrderViewController") as? CancelOrderViewController
    }
    
    
    @IBAction func btnCancelAction(_ sender: Any) {
        dele?.cancel(message: "")
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        if txtView.text == "" {
            self.showTopMessage(message: "Please enter your reason", type: .Error)
        }else {
           dele?.cancel(message: txtView.text ?? "")
        }
        
    }
    
}

extension CancelOrderViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceHolder.isHidden = !txtView.text.isEmpty
    }
}
