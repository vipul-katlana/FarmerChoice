
import UIKit

protocol SetHeight {
    func getHeight(height: CGFloat)
}

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgTopArrow: UIImageView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var viewCategoryLevelFirst: UIView!
    @IBOutlet weak var tblViewFirstCategory: UITableView!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnExoand: UIButton!
    
    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var clctnView: UICollectionView!
    var expandCloser: (()->())?
    var secondLevelExpandCloser: ((String,Int)->())?
    var firstLevelCategoryAction: ((String)->())?
    var secondLevelLevelCategoryAction: ((String)->())?
    
    var categoryFirstLevel = [Category.SubCategory]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tblViewFirstCategory.delegate = self
        self.tblViewFirstCategory.dataSource = self
        
        self.clctnView.delegate = self
        self.clctnView.dataSource = self
        
        self.imgTopArrow.isHidden = true
        
    }
    
    @IBAction func btnExpandAction(_ sender: Any) {
        if expandCloser != nil {
            expandCloser!()
        }
    }
    
    func setFirstLevelData(data: [Category.SubCategory]?,isExpand: Bool, secondLevelCategoryCount: Int) {
        if let newdata = data {
            self.categoryFirstLevel = newdata
            if isExpand {
//                viewHeightConstraint.constant = CGFloat(CGFloat((60 * newdata.count)) + self.clctnView.frame.height)
                viewHeightConstraint.constant = 180
                self.imgBG.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.imgTopArrow.isHidden = false
            }else {
                viewHeightConstraint.constant = 0
                self.imgBG.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
                self.imgTopArrow.isHidden = true
            }
            self.tblViewFirstCategory.reloadData()
        }
    }
}

extension CategoryTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryFirstLevel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryLevelFirstCell", for: indexPath) as! CategoryLevelFirstCell
        cell.imgIcon.setImage(with: categoryFirstLevel[indexPath.row].icon ?? "")
        cell.lblTitle.text = categoryFirstLevel[indexPath.row].name ?? ""
        cell.setData(data: categoryFirstLevel[indexPath.row].subcat_list, firstCategoryCount: categoryFirstLevel.count, isExpand: true)
        
       
        cell.expandCloser = {
            if cell.btnExpand.isSelected {
                cell.btnExpand.isSelected = false
                if self.secondLevelExpandCloser != nil {
                    self.secondLevelExpandCloser!("catId", indexPath.row)
                }
            }else {
                cell.btnExpand.isSelected = true
                if self.secondLevelExpandCloser != nil {
                    self.secondLevelExpandCloser!("catId", indexPath.row)
                }
            }
            self.tblViewFirstCategory.reloadData()
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if firstLevelCategoryAction != nil {
            firstLevelCategoryAction!(categoryFirstLevel[indexPath.row].catID ?? "")
        }
    }
}

extension CategoryTableViewCell : SetHeight {
    func getHeight(height: CGFloat) {
//        viewHeightConstraint.constant = CGFloat(Int(height) + categoryFirstLevel.count * 60)
//        self.reloadInputViews()
    }
    
}


extension CategoryTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryFirstLevel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CateegoryCollectionViewCell", for: indexPath) as! CateegoryCollectionViewCell
        cell.imgIcon.setImage(with: categoryFirstLevel[indexPath.row].icon ?? "")
        cell.lbblTitle.text = categoryFirstLevel[indexPath.row].name ?? ""
        cell.vwG.setShadow()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.clctnView.frame.width / 3), height: self.clctnView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if firstLevelCategoryAction != nil {
            firstLevelCategoryAction!(categoryFirstLevel[indexPath.row].catID ?? "")
        }
    }
    
}
