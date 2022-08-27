
import UIKit

class PromoCodeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnApply: UIButton!
    
    var btnApplyClouser: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.btnApply.setBorderWithColor(color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.3987676056))
    }
    
    
    @IBAction func btnApplyAction(_ sender: Any) {
        if btnApplyClouser != nil {
            btnApplyClouser!()
        }
    }
    
}
