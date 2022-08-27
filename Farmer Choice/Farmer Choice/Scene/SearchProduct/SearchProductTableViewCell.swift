
import UIKit

class SearchProductTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var lblCatTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
