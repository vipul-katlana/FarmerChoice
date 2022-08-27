

import UIKit

class DashboardShopBrandCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewBG.addViewShadow()
    }
}
