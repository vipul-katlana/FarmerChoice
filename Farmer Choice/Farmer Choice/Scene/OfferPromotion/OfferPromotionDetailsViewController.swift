
import UIKit

class OfferPromotionDetailsViewController: UIViewController {
    
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var offerData : OfferPromotion.OfferList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
    }
    
    func setUpData() {
        self.lblTitle.text = offerData?.title ?? ""
        //self.lblDescription.text = "\(offerData?.message ?? "")/n\(offerData?.terms ?? "")"
        
       // self.lblDescription.set(html: "\(offerData?.message ?? "") \(offerData?.terms ?? "")")
        
        self.lblDescription.text = "\(offerData?.message ?? "") \n\(offerData?.terms ?? "")"
        self.imgIcon.setImage(with: offerData?.image, placeHolder: UIImage(named: "common_OfferPlaceholder"))
        self.btnShare.setBorderWithColor(color: #colorLiteral(red: 0.06666666667, green: 0.5098039216, blue: 0.231372549, alpha: 1))
        self.btnShare.layer.cornerRadius = 5
    }
    
    
    class func instance() -> OfferPromotionDetailsViewController? {
        return UIStoryboard(name: "OfferPromotion", bundle: nil).instantiateViewController(withIdentifier: "OfferPromotionDetailsViewController") as? OfferPromotionDetailsViewController
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnShareAction(_ sender: Any) {
        let atext = "Share Code \(offerData?.title ?? "")"
        let activityVC = UIActivityViewController(activityItems: [atext], applicationActivities: nil)
        activityVC.setValue("\(AppInfo.kAppName) Code", forKey: "subject")
        self.present(activityVC, animated: true, completion: nil)
    }
    
}


extension UILabel {
  func set(html: String) {
    if let htmlData = html.data(using: .unicode) {
      do {
        self.attributedText = try NSAttributedString(data: htmlData,
                                                     options: [.documentType: NSAttributedString.DocumentType.html],
                                                     documentAttributes: nil)
      } catch let e as NSError {
        print("Couldn't parse \(html): \(e.localizedDescription)")
      }
    }
  }
}
