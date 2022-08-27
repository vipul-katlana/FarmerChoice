

import UIKit

class ProductDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblEnglishTitle: UILabel!
    @IBOutlet weak var lblHindiTitle: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblAmountCut: UILabel!
    @IBOutlet weak var lblOff: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var viewAdd: UIView!
    @IBOutlet weak var viewQty: UIView!
    
    @IBOutlet weak var viewCategoryDropDown: UIView!
    @IBOutlet weak var lblSoldOut: UILabel!
    
    @IBOutlet weak var btnAA: UIButton!
    @IBOutlet weak var btnMM: UIButton!
    var addClouser: (()->())?
    var removeClouser: (()->())?
    var addFavClouser: (()->())?
    var dropDownClouser: (()->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewBG.addViewShadow()
        self.viewCategoryDropDown.setBorderWithColor(color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),width: 0.5)
        
        
        self.btnMM.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        self.btnMM.layer.borderWidth = 1
        self.btnMM.layer.cornerRadius = 5
        
        self.btnAA.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        self.btnAA.layer.borderWidth = 1
        self.btnAA.layer.cornerRadius = 5
        
        self.viewAdd.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        self.viewAdd.layer.borderWidth = 1
    }
    
    func setData(data: DashBoardList.Category_products) {
        self.lblEnglishTitle.text = data.name ?? ""
        self.lblHindiTitle.text = data.caption ?? ""
        self.lblAmount.text = "₹\(data.price_list?[data.selectedProduct ?? 0].price ?? "")"
        let attrString = NSAttributedString(string: "₹\(data.price_list?[data.selectedProduct ?? 0].mrp ?? "")", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        lblAmountCut.attributedText = attrString
        if data.price_list?[data.selectedProduct ?? 0].mrp ?? "" == "" {
            lblAmountCut.isHidden = true
        }else {
            lblAmountCut.isHidden = false
        }
        
        self.lblOff.text = "\(data.price_list?[data.selectedProduct ?? 0].dis ?? "")% Off"
        
        if (data.price_list?[data.selectedProduct ?? 0].dis ?? "") == "" || (data.price_list?[data.selectedProduct ?? 0].dis ?? "") == "0" {
            self.lblOff.isHidden = true
        }else {
            self.lblOff.isHidden = false
        }
        self.lblWeight.text = data.price_list?[data.selectedProduct ?? 0].weight ?? ""
        self.imgIcon.setImage(with: "\(data.image ?? "")",placeHolder: UIImage(named: "common_Placeholder"))
        if data.wishlist == "Yes" {
            self.btnFav.isSelected = true
        }else {
            self.btnFav.isSelected = false
        }
        
        if data.sold_out ?? "" == "Yes" {
            self.viewAdd.isHidden = true
            self.viewQty.isHidden = true
            self.lblSoldOut.isHidden = false
        }else {
            self.lblSoldOut.isHidden = true
            if data.price_list?[data.selectedProduct ?? 0].cart_qty ?? "" == "" || data.price_list?[data.selectedProduct ?? 0].cart_qty ?? "" == "0" {
                self.viewAdd.isHidden = false
                self.viewQty.isHidden = true
            }else {
                self.viewAdd.isHidden = true
                self.viewQty.isHidden = false
                self.lblQuantity.text = data.price_list?[data.selectedProduct ?? 0].cart_qty ?? ""
            }
        }
        
        
        if data.price_list?.count == 1 {
            self.viewCategoryDropDown.isHidden = true
        }else {
            self.viewCategoryDropDown.isHidden = false
        }
        
    }
    
    func setProductData(data: RelatedProduct.CategoryProducts) {
        self.lblEnglishTitle.text = data.name ?? ""
        self.lblHindiTitle.text = data.caption ?? ""
        self.lblAmount.text = "₹\(data.price_list?[data.selectedProduct ?? 0].price ?? "")"
        
        let attrString = NSAttributedString(string: "₹\(data.price_list?[data.selectedProduct ?? 0].mrp ?? "")", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        lblAmountCut.attributedText = attrString
        
        if (data.price_list?[data.selectedProduct ?? 0].mrp ?? "") == "" {
            lblAmountCut.isHidden = true
        }else {
            lblAmountCut.isHidden = false
        }
        
        self.lblOff.text = "\(data.price_list?[data.selectedProduct ?? 0].dis ?? "")% Off"
        
        if (data.price_list?[data.selectedProduct ?? 0].dis ?? "") == "" || (data.price_list?[data.selectedProduct ?? 0].dis ?? "") == "0" {
            self.lblOff.isHidden = true
        }else {
            self.lblOff.isHidden = false
        }
        self.lblWeight.text = data.price_list?[data.selectedProduct ?? 0].weight ?? ""
        self.imgIcon.setImage(with: "\(data.image ?? "")",placeHolder: UIImage(named: "common_Placeholder"))
        if data.wishlist == "Yes" {
            self.btnFav.isSelected = true
        }else {
            self.btnFav.isSelected = false
        }
        
        if data.sold_out ?? "" == "Yes" {
            self.viewAdd.isHidden = true
            self.viewQty.isHidden = true
            self.lblSoldOut.isHidden = false
        }else {
            self.lblSoldOut.isHidden = true
            if data.price_list?[data.selectedProduct ?? 0].cart_qty ?? "" == "" || data.price_list?[data.selectedProduct ?? 0].cart_qty ?? "" == "0" {
                self.viewAdd.isHidden = false
                self.viewQty.isHidden = true
            }else {
                self.viewAdd.isHidden = true
                self.viewQty.isHidden = false
                self.lblQuantity.text = data.price_list?[data.selectedProduct ?? 0].cart_qty ?? ""
            }
        }
        
        if data.price_list?.count == 1 {
            self.viewCategoryDropDown.isHidden = true
        }else {
            self.viewCategoryDropDown.isHidden = false
        }
        
    }
    
    
    @IBAction func btnFavAction(_ sender: Any) {
        if addFavClouser != nil {
            addFavClouser!()
        }
    }
    
    @IBAction func btnMinusAction(_ sender: Any) {
        if removeClouser != nil {
            removeClouser!()
        }
    }
    
    @IBAction func btnAddAction(_ sender: Any) {
        if addClouser != nil {
            addClouser!()
        }
    }
    
    @IBAction func btnAddQtyAction(_ sender: Any) {
        if addClouser != nil {
            addClouser!()
        }
    }
    
    @IBAction func btnDropDownAction(_ sender: Any) {
        if dropDownClouser != nil {
            dropDownClouser!()
        }
    }
    
    
}
