

import UIKit

class OrderDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(data: OrdersDetails.ProductsList) {
        self.imgIcon.setImage(with: data.image, placeHolder: UIImage(named: ""))
        self.lblTitle.text = data.name ?? ""
        self.lblQty.text = data.weight ?? ""
        self.lblPrice.text = "₹\(data.price ?? "") x \(data.quantity ?? "")"
        self.lblAmount.text = "₹\(data.line_total ?? "")"
    }

}
