

import UIKit

class SelectAreaListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblArea: UILabel!
    @IBOutlet weak var vwBG: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
