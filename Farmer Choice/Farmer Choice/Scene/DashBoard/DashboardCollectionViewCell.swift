
import UIKit

class DashboardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    
    func setBannerData(data: DashBoard.Banner_list) {
        self.imgIcon.setImage(with: "\(data.image ?? "")",placeHolder: UIImage(named: ""))
    }
    
    func setOfferData(data: DashBoard.Offer_banner) {
        self.imgIcon.setImage(with: "\(data.image ?? "")",placeHolder: UIImage(named: ""))
    }
    
    func setTabelData(data: DashBoardList.OfferBanner) {
        self.imgIcon.setImage(with: "\(data.image ?? "")",placeHolder: UIImage(named: ""))
    }
}
