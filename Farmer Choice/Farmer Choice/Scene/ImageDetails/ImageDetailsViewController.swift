
import UIKit

class ImageDetailsViewController: UIViewController {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    var imgStr = ""
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgProfile.setImage(with: imgStr, placeHolder: UIImage(named: "common_Placeholder"))
        self.lblName.text = name
    }
    
    
    class func instance() -> ImageDetailsViewController? {
        return UIStoryboard(name: "ImageDetails", bundle: nil).instantiateViewController(withIdentifier: "ImageDetailsViewController") as? ImageDetailsViewController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    @IBAction func btnDismiss(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
