

import UIKit

class OrderHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var lblOrdrePlacedOn: UILabel!
    @IBOutlet weak var lblScheduleFor: UILabel!
    @IBOutlet weak var lblOrderNumber: UILabel!
    @IBOutlet weak var viewCancelTop: UIView!
    @IBOutlet weak var viewreorder: UIView!
    @IBOutlet weak var lblProductCount: UILabel!
    @IBOutlet weak var lbldeliveryCharge: UILabel!
    @IBOutlet weak var imgFirst: UIImageView!
    @IBOutlet weak var imgFirstLine: UIImageView!
    @IBOutlet weak var imgSecond: UIImageView!
    @IBOutlet weak var imgSecondNew: UIImageView!
    @IBOutlet weak var imgSecondLine: UIImageView!
    @IBOutlet weak var imgThird: UIImageView!
    @IBOutlet weak var imgThirdNew: UIImageView!
    @IBOutlet weak var imgThirdLine: UIImageView!
    @IBOutlet weak var imgFourth: UIImageView!
    @IBOutlet weak var imgFourthLine: UIImageView!
    @IBOutlet weak var lblOrderAmount: UILabel!
    @IBOutlet weak var lblPaidBy: UILabel!
    @IBOutlet weak var btnViewdetails: UIButton!
    @IBOutlet weak var btnCancelOrder: UIButton!
    @IBOutlet weak var viewTrack: UIView!
    
    
    var reorderClouser: (()->())?
    var cancelClouser: (()->())?
    var detailsClouser: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        viewBG.layer.cornerRadius = 5
//        viewBG.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        viewBG.layer.borderWidth = 1
        
        
        btnViewdetails.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        btnViewdetails.layer.borderWidth = 1
    
        btnCancelOrder.layer.borderColor = UIColor.red.cgColor
        btnCancelOrder.layer.borderWidth = 1
        
        viewreorder.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        viewreorder.layer.borderWidth = 1
        
        self.viewreorder.isHidden = true
    }
    
    func setData(data: OrderHistory.OrderList) {
        self.lblOrdrePlacedOn.text = data.orderPlaceOn ?? ""
        let htmlString = data.orderScheduled ?? ""
        let newdata = htmlString.data(using: String.Encoding.unicode)!

        let attrStr = try? NSAttributedString(
            data: newdata,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
//        lblScheduleFor.attributedText = attrStr
        
        lblScheduleFor.text = data.orderScheduled ?? ""
        
        
        
        self.lblOrderNumber.text = "Order \(data.orderNo ?? "")"
        
        
        self.lblProductCount.text = data.products ?? ""
        self.lbldeliveryCharge.text = data.delivery_charges ?? ""
        
        
        if data.status == "Placed" {
            self.imgFirstLine.image = UIImage(named: "order_check")
            self.imgFirst.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgSecondLine.image = UIImage(named: "order_Uncheck")
            self.imgSecond.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgSecondNew.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgThirdLine.image = UIImage(named: "order_Uncheck")
            self.imgThird.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgThirdNew.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgFourthLine.image = UIImage(named: "order_Uncheck")
            self.imgFourth.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            
            self.viewTrack.isHidden = false
            self.viewCancelTop.isHidden = true
            //self.viewreorder.isHidden = false
            
            
        }else if data.status == "Confirmed" {
            self.imgFirstLine.image = UIImage(named: "order_check")
            self.imgFirst.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgSecondLine.image = UIImage(named: "order_check")
            self.imgSecond.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgSecondNew.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgThirdLine.image = UIImage(named: "order_Uncheck")
            self.imgThird.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgThirdNew.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgFourthLine.image = UIImage(named: "order_Uncheck")
            self.imgFourth.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            
            self.viewTrack.isHidden = false
            self.viewCancelTop.isHidden = true
          //  self.viewreorder.isHidden = false
            
            
        }else if data.status == "OnDelivery" {
            self.imgFirstLine.image = UIImage(named: "order_check")
            self.imgFirst.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgSecondLine.image = UIImage(named: "order_check")
            self.imgSecond.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgSecondNew.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgThirdLine.image = UIImage(named: "order_check")
            self.imgThird.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgThirdNew.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            self.imgFourthLine.image = UIImage(named: "order_Uncheck")
            self.imgFourth.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 0.5019806338)
            
            self.viewTrack.isHidden = false
            self.viewCancelTop.isHidden = true
         //   self.viewreorder.isHidden = false
////
            
        }else if data.status == "Delivered" {
            self.imgFirstLine.image = UIImage(named: "order_check")
            self.imgFirst.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgSecondLine.image = UIImage(named: "order_check")
            self.imgSecond.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgSecondNew.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgThirdLine.image = UIImage(named: "order_check")
            self.imgThird.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgThirdNew.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            self.imgFourthLine.image = UIImage(named: "order_check")
            self.imgFourth.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.6862745098, blue: 0.537254902, alpha: 0.9684474032)
            
            self.viewTrack.isHidden = false
            self.viewCancelTop.isHidden = true
          //  self.viewreorder.isHidden = false
            
            
        } else if data.status == "Canceled" {
            self.viewTrack.isHidden = true
            self.viewCancelTop.isHidden = false
           // self.viewreorder.isHidden = true
        }
        
        
        if data.cancel_btn == "Yes" {
            self.btnCancelOrder.isHidden = false
        }else {
            self.btnCancelOrder.isHidden = true
        }
        
//        if data.reorder_btn == "Yes" {
//            self.viewreorder.isHidden = false
//
//        }else {
//            self.viewreorder.isHidden = true
//        }
//
        self.lblOrderAmount.text = "₹\(data.final_pay_amount ?? "")"
        self.lblPaidBy.text = data.paid_by ?? ""
    }
    
    
    @IBAction func btnTopCancelAction(_ sender: Any) {
        print("No action")
    }
    
    @IBAction func btnReorderAction(_ sender: Any) {
        if reorderClouser != nil {
            reorderClouser!()
        }
    }
    
    @IBAction func btnViewDetailsAction(_ sender: Any) {
        if detailsClouser != nil {
            detailsClouser!()
        }
    }
    
    @IBAction func btnCancelOrderAction(_ sender: Any) {
        if cancelClouser != nil {
            cancelClouser!()
        }
    }
    
}


