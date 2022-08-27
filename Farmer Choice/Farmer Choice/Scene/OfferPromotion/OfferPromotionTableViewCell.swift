

import UIKit

class OfferPromotionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    var viewDetailsClouser: (()->())?
    var shareClouser: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewBG.addViewShadow()
    }
    
    @IBAction func btnViewDetailsAction(_ sender: Any) {
        if viewDetailsClouser != nil {
            viewDetailsClouser!()
        }
    }
    
    @IBAction func btnShareAction(_ sender: Any) {
        if shareClouser != nil {
            shareClouser!()
        }
    }
    
}
