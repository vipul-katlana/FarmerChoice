//
//  QuantityBoxViewController.swift
//  Farmer Choice
//
//  Created by Vipul  on 26/08/22.
//

import UIKit

class QuantityBoxViewController: UIViewController {
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblEnglishName: UILabel!
    @IBOutlet weak var lblHindiName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var txtQty: UITextField!
    
    var currentProduct: QuantityBox?
    var delegate: QuatityBoxUpdate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgProduct.setImage(with: currentProduct?.imgProduct, placeHolder: UIImage(named: "common_Placeholder"))
        self.lblEnglishName.text = currentProduct?.englishTitle
        self.lblHindiName.text = currentProduct?.hindiTitle
        self.lblPrice.text = currentProduct?.price
        self.lblWeight.text = currentProduct?.weight
        self.txtQty.text = currentProduct?.currentQty
    }
    
    
    class func instance() -> QuantityBoxViewController? {
        return UIStoryboard(name: "QuantityBox", bundle: nil).instantiateViewController(withIdentifier: "QuantityBoxViewController") as? QuantityBoxViewController
    }
    
    @IBAction func btnDismissAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnAddAction(_ sender: Any) {
        
        if txtQty.text?.trimmingCharacters(in: .whitespaces) == "" {
            self.showTopMessage(message: "Please enter quantity", type: .Error)
        }else if (Int(txtQty.text?.trimmingCharacters(in: .whitespaces) ?? "") ?? 0) > (Int(currentProduct?.maxQty ?? "") ?? 0) {
            self.showTopMessage(message: "You can add maximum \(currentProduct?.maxQty ?? "") quantity for this product", type: .Error)
        }else {
            delegate?.quantityChanged(qty: self.txtQty.text ?? "", productID: currentProduct?.productID ?? "", priceId: currentProduct?.priceID ?? "", type: currentProduct?.type ?? "")
            self.dismiss(animated: false, completion: nil)
        }
    }
}


struct QuantityBox {
    var imgProduct: String
    var englishTitle: String
    var hindiTitle: String
    var price: String
    var weight: String
    var currentQty: String
    
    var productID: String
    var priceID: String
    var type: String
    
    var maxQty : String
    
}
