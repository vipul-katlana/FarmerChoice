

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var lblHeading: UILabel!
    
    @IBOutlet weak var lblAdrs: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
