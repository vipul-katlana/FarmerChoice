
import UIKit

class CartListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblEnglishTitle: UILabel!
    @IBOutlet weak var lblHIndiTitle: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblMrp: UILabel!
    @IBOutlet weak var lblQTY: UILabel!
    @IBOutlet weak var vwProductRemove: UIView!
    @IBOutlet weak var lblProductRemoveMessage: UILabel!
    @IBOutlet weak var btnProductRemove: UIButton!
    
    @IBOutlet weak var btnMM: UIButton!
    @IBOutlet weak var btnAA: UIButton!
    
    var addClouser: (()->())?
    var removeClouser: (()->())?
    var deleteClouser: (()->())?
    var productRemoveClouser: (()->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.btnMM.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        self.btnMM.layer.borderWidth = 1
        self.btnMM.layer.cornerRadius = 5
        
        self.btnAA.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        self.btnAA.layer.borderWidth = 1
        self.btnAA.layer.cornerRadius = 5
    }
    
    func setData(data: CartList.CartItemList ) {
        self.lblEnglishTitle.text = data.product_name ?? ""
        self.lblHIndiTitle.text = data.product_information ?? ""
        self.lblWeight.text = data.weight ?? ""
        self.lblQTY.text = data.product_qty ?? ""
        self.lblPrice.text = "₹\(data.product_price ?? "")"
        let attrString = NSAttributedString(string: "₹\(data.product_mrp ?? "")", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        lblMrp.attributedText = attrString
        self.lblSubTotal.text = "₹\(data.line_total ?? "")"
        
        if (data.product_mrp ?? "") == "" {
            lblMrp.isHidden = true
        }else {
            lblMrp.isHidden = false
        }
        
        if (data.item_notes ?? "") == "" {
            self.vwProductRemove.isHidden = true
        }else {
            self.vwProductRemove.isHidden = false
            self.lblProductRemoveMessage.text = data.item_notes ?? ""
            self.btnProductRemove.setTitle(data.btn_name ?? "", for: .normal)
        }
        
        self.imgIcon.setImage(with: data.cart_image, placeHolder: UIImage(named: "common_placeholder"))
    }
    
    
    @IBAction func btnDeleteAction(_ sender: Any) {
        if deleteClouser != nil {
            deleteClouser!()
        }
    }
    
    @IBAction func btnMinusAction(_ sender: Any) {
        if removeClouser != nil {
            removeClouser!()
        }
    }
    
    
    @IBAction func btnAdAction(_ sender: Any) {
        if addClouser != nil {
            addClouser!()
        }
    }
    
    @IBAction func btnRemoveProductAction(_ sender: Any) {
        if productRemoveClouser != nil {
            productRemoveClouser!()
        }
    }
}
