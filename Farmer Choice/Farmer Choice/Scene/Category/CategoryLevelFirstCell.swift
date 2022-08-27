

import UIKit

class CategoryLevelFirstCell: UITableViewCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnExpand: UIButton!
    
    var categorySecondLevel = [Category.SubCategorySecond]()
    var expandCloser: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setData(data: [Category.SubCategorySecond]?, firstCategoryCount: Int, isExpand: Bool) {
        if let newdata = data {
            self.categorySecondLevel = newdata
            
        }
    }
    
    @IBAction func btnExpandAction(_ sender: Any) {
        if expandCloser != nil {
            expandCloser!()
        }
    }
    
}

extension CategoryLevelFirstCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categorySecondLevel.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        return UITableViewCell()
    }
    
    
}
