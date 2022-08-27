

import UIKit

class ProductTypeViewController: UIViewController {
    
    var dataArray = [ProductList.Product_list]()
    var productDetailsDataArray = [RelatedProduct.CategoryProducts]()
    var productDetailsDataArrayTop : ProductDetails.ViewModel?
    var dashBoardArray : DashBoardList.Category_products?
    var type = ""
    
    var delegateChange: ChangeProductType?
    var cellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    class func instance() -> ProductTypeViewController? {
        return UIStoryboard(name: "ProductType", bundle: nil).instantiateViewController(withIdentifier: "ProductTypeViewController") as? ProductTypeViewController
    }
    
    @IBAction func btnDismissAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}


extension ProductTypeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == "Productdetails" {
            return productDetailsDataArray[0].price_list?.count ?? 0
        }else if type == "Productdetailstop" {
            return productDetailsDataArrayTop?.product?[0].price_list?.count ?? 0
        }else if type == "dashboard" {
            return dashBoardArray?.price_list?.count ?? 0
            
        }
        else {
            return dataArray[0].price_list?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTypeTableViewCell", for: indexPath) as! ProductTypeTableViewCell
        
        if type == "Productdetails" {
            cell.lblTitle.text = productDetailsDataArray[0].price_list?[indexPath.row].weight ?? ""
            cell.lblPrice.text = "₹\(productDetailsDataArray[0].price_list?[indexPath.row].price ?? "")"
            let attrString = NSAttributedString(string: "₹\(productDetailsDataArray[0].price_list?[indexPath.row].mrp ?? "")", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            cell.lblMrp.attributedText = attrString
            if (productDetailsDataArray[0].price_list?[indexPath.row].mrp ?? "") == "" {
               // cell.lblMrp.isHidden = true
            }else {
               // cell.lblMrp.isHidden = false
            }
        }
        else if type == "dashboard" {
            cell.lblTitle.text = dashBoardArray?.price_list?[indexPath.row].weight ?? ""
            cell.lblPrice.text = "₹\(dashBoardArray?.price_list?[indexPath.row].price ?? "")"
            let attrString = NSAttributedString(string: "₹\(dashBoardArray?.price_list?[indexPath.row].mrp ?? "")", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            cell.lblMrp.attributedText = attrString
            
            if (dashBoardArray?.price_list?[indexPath.row].mrp ?? "") == "" {
               // cell.lblMrp.isHidden = true
            }else {
                //cell.lblMrp.isHidden = false
            }
        }
        
        else if type == "Productdetailstop" {
            cell.lblTitle.text = productDetailsDataArrayTop?.product?[0].price_list?[indexPath.row].weight ?? ""
            cell.lblPrice.text = "₹\(productDetailsDataArrayTop?.product?[0].price_list?[indexPath.row].price ?? "")"
            let attrString = NSAttributedString(string: "₹\(productDetailsDataArrayTop?.product?[0].price_list?[indexPath.row].mrp ?? "")", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            cell.lblMrp.attributedText = attrString
            
            if (productDetailsDataArrayTop?.product?[0].price_list?[indexPath.row].mrp ?? "") == "" {
               // cell.lblMrp.isHidden = true
            }else {
               // cell.lblMrp.isHidden = false
            }
        }
        else {
            cell.lblTitle.text = dataArray[0].price_list?[indexPath.row].weight ?? ""
            cell.lblPrice.text = "₹\(dataArray[0].price_list?[indexPath.row].price ?? "")"
            let attrString = NSAttributedString(string: "₹\(dataArray[0].price_list?[indexPath.row].mrp ?? "")", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            cell.lblMrp.attributedText = attrString
            
            if (dataArray[0].price_list?[indexPath.row].mrp ?? "") == "" {
               // cell.lblMrp.isHidden = true
            }else {
              // cell.lblMrp.isHidden = false
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegateChange?.change(index: indexPath.row, cellIndex: self.cellIndex)
    }
}
