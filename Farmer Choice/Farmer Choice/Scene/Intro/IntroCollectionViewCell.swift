
import UIKit

class IntroCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgLogo.clipsToBounds = true
        imgLogo.layer.cornerRadius = 50
        imgLogo.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
}
