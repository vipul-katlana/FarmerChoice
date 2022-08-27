

import UIKit
import CFSDK
import Razorpay


protocol ApplyPromoCode {
    func success(title: String,message: String, id: String, value: String)
}

protocol PaymentOptionDisplayLogic: class {
    func didReceivePaymentResponse(response: PaymentOption.ViewModel?, message: String, successCode: Int)
    
    func didReceivePlaceOrderResponse(response: [PlaceOrder.ViewModel]?, message: String, successCode: Int)
    
    func didReceivePayTmOrder(response: PaytmOrderResult.ViewModel?,message: String, successCode: Int)
}

class PaymentOptionViewController: UIViewController {
    @IBOutlet weak var lblQtbtm: UILabel!
    @IBOutlet weak var lblFarmFreshWalletNewMessage: UILabel!
    @IBOutlet weak var vwCpn: UIView!
    @IBOutlet weak var lblCouponNAme: UILabel!
    @IBOutlet weak var imgIconNewCart: UIImageView!
    @IBOutlet weak var lblFinalTotalPayAmt: UILabel!
    @IBOutlet weak var btnTotalPay: UIButton!
    @IBOutlet weak var viewOrderItem: UIView!
    @IBOutlet weak var lblOrderItemAmt: UILabel!
    @IBOutlet weak var viewSubTotal: UIView!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var viewDeliveryCharge: UIView!
    @IBOutlet weak var lblDeliveryChargeAMt: UILabel!
    @IBOutlet weak var viewCouponDiscount: UIView!
    @IBOutlet weak var btnCpnDiscount: UIButton!
    @IBOutlet weak var lblDiscountAmt: UILabel!
    @IBOutlet weak var viewExpressCharge: UIView!
    @IBOutlet weak var lblExpresschargeAmt: UILabel!
    @IBOutlet weak var viewBagCharge: UIView!
    @IBOutlet weak var lblBagChargeAmt: UILabel!
    @IBOutlet weak var viewWalletAmt: UIView!
    @IBOutlet weak var lblWalletAmt: UILabel!
    @IBOutlet weak var lblSuperWalletAmt: UILabel!
    @IBOutlet weak var lblSuperAmountUsed: UILabel!
    
    @IBOutlet weak var viewTotalPay: UIView!
    @IBOutlet weak var lblTotalPayAmt: UILabel!
    @IBOutlet weak var viewHaveCoupon: UIView!
    @IBOutlet weak var viewCoponApplied: UIView!
    @IBOutlet weak var lblCouponAppplied: UILabel!
    @IBOutlet weak var viewBagChargePay: UIView!
    @IBOutlet weak var lblBagChargePayText: UILabel!
    @IBOutlet weak var lblBagChargePayMessage: UILabel!
    @IBOutlet weak var btnBagCharge: UIButton!
    @IBOutlet weak var viewExpressDelveryPay: UIView!
    @IBOutlet weak var lblExpressDeliveryPayText: UILabel!
    @IBOutlet weak var btnExpressCharge: UIButton!
    @IBOutlet weak var viewFarmFresh: UIView!
    @IBOutlet weak var lblFarmFreshVeggieText: UILabel!
    @IBOutlet weak var lblFarmFreshVegiMesage: UILabel!
    
    @IBOutlet weak var viewFarmFreshSuperWallet: UIView!
    @IBOutlet weak var lblFarmFreshSuperText: UILabel!
    @IBOutlet weak var lblFarmFreshSuperMessage: UILabel!
    
    @IBOutlet weak var lblFarmFreshSuperNewMessage: UILabel!
    
    
    @IBOutlet weak var btnFarmFresh: UIButton!
    @IBOutlet weak var viewBottomCOD: UIView!
    @IBOutlet weak var lblBottomCodText: UILabel!
    @IBOutlet weak var lblBottomCodNessage: UILabel!
    @IBOutlet weak var btnBottomCod: UIButton!
    @IBOutlet weak var vieewBottomPaytm: UIView!
    @IBOutlet weak var lblBottomPaytmText: UILabel!
    @IBOutlet weak var lblBottomPaytmMessage: UILabel!
    @IBOutlet weak var btnBottomPaytm: UIButton!
    @IBOutlet weak var viewBottomPayu: UIView!
    @IBOutlet weak var lblBottomPayuText: UILabel!
    @IBOutlet weak var lblBottomPayuMessage: UILabel!
    @IBOutlet weak var btnBottomPayu: UIButton!
    @IBOutlet weak var lblPayableAmt: UILabel!
    @IBOutlet weak var imgBagSelected: UIImageView!
    @IBOutlet weak var btnPayAPI: UIButton!
    
    @IBOutlet weak var viewSuperWallet: UIView!
    
    @IBOutlet weak var btnFarmFreshSuperWallet: UIButton!
    
    var orderPlace = false
    var viewCouponShow = false
    var viewBagShow = false
    var viewWalletShow = false
    var viewExpressShow = false
    var viewCodShow = false
    var viewPatymShow = false
    var viewPayuShow = false
    var superWallet = false
    var original_grand_total = 0.0
    var original_wallet_bal = 0.0
    var original_bag_value = 0.0
    var original_express_value = 0.0
    var original_coupon_value = 0.0
    var super_wallet_amt = 0.0
    var couponApplied = false
    var area_charge = 0.0
    var couponId = ""
    var couponValue = ""
    var paymentOption = "razorpay"
    var expressDeliverySelected = false
    var DeliveryTimeSlot : String = ""
    var DeliveryDateSlot : String = ""
    var orderSpecialInstruction = ""
    var latsDeliveryLat : String = ""
    var latsDeliveryLong : String = ""
    var strOrderID : String = ""
    var areaId = ""
    
    
    var orderMasterId = ""
    
    var paytmSdkMessage = ""
    var paytmStatus = ""
    // var txnController = PGTransactionViewController()
    //  var serv = PGServerEnvironment()
    
    
    var razorpayObj : RazorpayCheckout? = nil
    let razorpayKey = "rzp_live_XHItAkfBjgyxAo"
    
    var orderResponse: PlaceOrder.ViewModel?
    
    
    
    var interactor: PaymentOptionBusinessLogic?
    var router: (NSObjectProtocol & PaymentOptionRoutingLogic & PaymentOptionDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = PaymentOptionInteractor()
        let presenter = PaymentOptionPresenter()
        let router = PaymentOptionRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var expressSeleted = ""
        if self.expressDeliverySelected {
            expressSeleted = "Yes"
        }else {
            expressSeleted = "No"
        }
        let request = PaymentOption.Request(areaID: self.areaId, expressSelected: expressSeleted)
        interactor?.callPaymentApi(request: request)
        
        self.lblOrderItemAmt.text = "\(UserDefaultsManager.getCartCount()) Item"
        self.lblSubTotal.text = "₹\(UserDefaultsManager.getCartAmount())"
        //self.imgIconNewCart.changePngColorTo(color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        
        self.original_grand_total = Double(UserDefaultsManager.getCartAmount()) ?? 0.0
        
        //        btnTotalPay.isSelected = false
        //        viewOrderItem.isHidden = true
        //        viewSubTotal.isHidden = true
        //        viewDeliveryCharge.isHidden = true
        //        viewCouponDiscount.isHidden = true
        //        viewExpressCharge.isHidden = true
        //        viewSuperWallet.isHidden = true
        //        viewBagCharge.isHidden = true
        //        viewWalletAmt.isHidden = true
        //        viewTotalPay.isHidden = true
        
        
        
        btnTotalPay.isSelected = true
        viewOrderItem.isHidden = false
        viewSubTotal.isHidden = false
        viewDeliveryCharge.isHidden = false
        viewCouponDiscount.isHidden = false
        viewExpressCharge.isHidden = false
        viewBagCharge.isHidden = false
        //26 aug changes
        viewWalletAmt.isHidden = true
        //
        viewTotalPay.isHidden = false
        viewSuperWallet.isHidden = true
        self.calculateAmount()
        
        
        self.lblQtbtm.text = "\(UserDefaultsManager.getCartCount()) Item"
    }
    
    class func instance() -> PaymentOptionViewController? {
        return UIStoryboard(name: "PaymentOption", bundle: nil).instantiateViewController(withIdentifier: "PaymentOptionViewController") as? PaymentOptionViewController
    }
    
    
    func calculateAmount() {
        
        var grand_total = 0.0
        var wallet_bal = 0.0
        var used_wallet_bal = 0.0
        var coupon_value = 0.0
        var express_value = 0.0
        var bag_value = 0.0
        var final_payable = 0.0
        var super_wallet = 0.0
        
        grand_total = original_grand_total + area_charge
        wallet_bal = original_wallet_bal
        
        if (btnBagCharge.isSelected) {
            bag_value = original_bag_value;
        } else {
            bag_value = 0
        }
        
        if (btnFarmFreshSuperWallet.isSelected) {
            super_wallet = super_wallet_amt;
        } else {
            super_wallet = 0
        }
        
        //        if (btnExpressCharge.isSelected) {
        //            express_value = original_express_value;
        //        } else {
        //            express_value = 0
        //        }
        
        if expressDeliverySelected {
            express_value = original_express_value
        }else {
            express_value = 0
        }
        
        if (couponId != "") {
            coupon_value = original_coupon_value;
        } else {
            coupon_value = 0
        }
        
        
        final_payable = (grand_total + bag_value + express_value) - (coupon_value + super_wallet)
        
        if (btnFarmFresh.isSelected) {
            if (original_wallet_bal > final_payable) {
                wallet_bal = original_wallet_bal - final_payable;
                used_wallet_bal = final_payable;
                final_payable = 0;
                
            } else {
                wallet_bal = 0;
                used_wallet_bal = original_wallet_bal;
                final_payable = final_payable - original_wallet_bal;
            }
        } else {
            wallet_bal = original_wallet_bal;
        }
        
        self.lblDeliveryChargeAMt.text = "₹\(self.area_charge)"
        self.lblDiscountAmt.text = "- ₹\(coupon_value)"
        self.lblExpresschargeAmt.text = "₹\(express_value)"
        self.lblBagChargeAmt.text = "₹\(bag_value)"
        self.lblWalletAmt.text = "- ₹\(String(format: "%.2f", used_wallet_bal))"
        self.lblSuperWalletAmt.text = "- ₹\(super_wallet)"
        
        
        self.lblTotalPayAmt.text = "₹\(String(format: "%.2f", final_payable))"
        self.lblFinalTotalPayAmt.text = "₹\(String(format: "%.2f", final_payable))"
        self.lblPayableAmt.text = "₹\(String(format: "%.2f", final_payable))"
        
        
        var tm1 = String(format: "%.2f", wallet_bal)
        self.lblFarmFreshVegiMesage.text = "Use Amount: ₹\(tm1)"
        var tm2 = String(format: "%.2f", super_wallet)
        self.lblFarmFreshSuperMessage.text = "Use Amount: ₹\(super_wallet)"
        
        if express_value == 0.0 {
            viewExpressCharge.isHidden = true
        }else {
            viewExpressCharge.isHidden = false
        }
        
        
        if bag_value == 0.0 {
            viewBagCharge.isHidden = true
        }else {
            viewBagCharge.isHidden = false
        }
        
    }
    
    
    //    func getCheckSumAPICall(checkSumKey: String, data: PlaceOrder.ViewModel) {
    //        let user = UserDefaultsManager.getLoggedUserDetails()
    //        var parameter = [String: String]()
    //        var mid = ""
    //        var oid = ""
    //        var custid = ""
    //        var mbl = ""
    //        var eml = ""
    //        var chlid = ""
    //        var intype = ""
    //        var wbst = ""
    //        var amt = ""
    //        var cburl = ""
    //
    //        if let Pmid = data.MID  {
    //            mid = Pmid
    //        }
    //        if let PorderId = data.ORDER_ID  {
    //            oid = PorderId
    //        }
    //        if let PcustId = data.CUST_ID  {
    //            custid = PcustId
    //        }
    //        if let PmobileNumber = data.MOBILE_NO {
    //            mbl = PmobileNumber
    //        }
    //        if let Pemail = user?.email {
    //            eml = Pemail
    //        }
    //        if let PchannelId = data.CHANNEL_ID {
    //            chlid = PchannelId
    //        }
    //        if let PindustryType = data.INDUSTRY_TYPE_ID {
    //            intype = PindustryType
    //        }
    //        if let Pwebsite =  data.WEBSITE {
    //            wbst = Pwebsite
    //        }
    //        if let Pamt = data.TXN_AMOUNT {
    //            amt = Pamt
    //        }
    //        if let PcallBackurl =  data.CALLBACK_URL {
    //            cburl = PcallBackurl
    //        }
    //
    //        parameter = [ "MID" : mid,
    //                      "ORDER_ID": oid,
    //                      "CUST_ID": custid,
    //                      "MOBILE_NO": mbl,
    //                      "EMAIL": eml,
    //                      "CHANNEL_ID": chlid,
    //                      "INDUSTRY_TYPE_ID": intype  ,
    //                      "WEBSITE":  wbst,
    //                      "TXN_AMOUNT": amt,
    //                      "CALLBACK_URL" : cburl
    //        ]
    //        //self.setupPaytm(checkSum:checkSumKey, params: parameter)
    //    }
    
    @IBAction func BtnTotalPayAction(_ sender: Any) {
        //        if btnTotalPay.isSelected {
        //            btnTotalPay.isSelected = false
        //            viewOrderItem.isHidden = true
        //            viewSubTotal.isHidden = true
        //            viewDeliveryCharge.isHidden = true
        //            viewCouponDiscount.isHidden = true
        //            viewExpressCharge.isHidden = true
        //            viewBagCharge.isHidden = true
        //            viewWalletAmt.isHidden = true
        //            viewTotalPay.isHidden = true
        //            viewSuperWallet.isHidden = true
        //        }else {
        //            btnTotalPay.isSelected = true
        //            viewOrderItem.isHidden = false
        //            viewSubTotal.isHidden = false
        //            viewDeliveryCharge.isHidden = false
        //            viewCouponDiscount.isHidden = false
        //            viewExpressCharge.isHidden = false
        //            viewBagCharge.isHidden = false
        //            viewWalletAmt.isHidden = false
        //            viewTotalPay.isHidden = false
        //            viewSuperWallet.isHidden = false
        //            self.calculateAmount()
        //        }
        
        
    }
    
    @IBAction func btnCouponAction(_ sender: Any) {
        
        if let VC = PromoCodeViewController.instance() {
            VC.promoDele = self
            self.navigationController?.pushViewController(VC, animated: true)
        }
        
    }
    
    
    
    @IBAction func btnBagChargeAction(_ sender: Any) {
        if btnBagCharge.isSelected {
            btnBagCharge.isSelected = false
        }else {
            btnBagCharge.isSelected = true
        }
        calculateAmount()
    }
    
    @IBAction func btnExpressDeliveryAction(_ sender: Any) {
        if btnExpressCharge.isSelected {
            btnExpressCharge.isSelected = false
        }else {
            btnExpressCharge.isSelected = true
        }
        calculateAmount()
    }
    
    @IBAction func btnFarmFreshAction(_ sender: Any) {
        if btnFarmFresh.isSelected {
            btnFarmFresh.isSelected = false
        }else {
            btnFarmFresh.isSelected = true
        }
        calculateAmount()
    }
    
    @IBAction func btnFarmFreshSuperAction(_ sender: Any) {
        if btnFarmFreshSuperWallet.isSelected {
            btnFarmFreshSuperWallet.isSelected = false
        }else {
            btnFarmFreshSuperWallet.isSelected = true
        }
        calculateAmount()
    }
    
    
    
    @IBAction func btBottomCodAction(_ sender: Any) {
        paymentOption = "cod"
        btnBottomCod.isSelected = true
        btnBottomPaytm.isSelected = false
        btnBottomPayu.isSelected = false
        
    }
    
    @IBAction func btnBottomPaytmAction(_ sender: Any) {
        paymentOption = "razorpay"
        btnBottomCod.isSelected = false
        btnBottomPaytm.isSelected = true
        btnBottomPayu.isSelected = false
        
    }
    
    @IBAction func btnBottomPayuAction(_ sender: Any) {
        paymentOption = ""
        btnBottomCod.isSelected = false
        btnBottomPaytm.isSelected = false
        btnBottomPayu.isSelected = true
        
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        if date == "" {
            return ""
        }else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            let date = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "dd-MM-yyyy"
            return  dateFormatter.string(from: date!)
        }
        
        
    }
    
    @IBAction func btnPayAvction(_ sender: Any) {
        if paymentOption != "" {
            if !orderPlace {
                var exTemp = ""
                
                if expressDeliverySelected {
                    exTemp = "Yes"
                }else {
                    exTemp = "No"
                }
                
                var bagTemp = ""
                if btnBagCharge.isSelected {
                    bagTemp = "Yes"
                }else {
                    bagTemp = "No"
                }
                
                
                var wallTemp = ""
                if btnFarmFresh.isSelected {
                    wallTemp = "Yes"
                }else {
                    wallTemp = "No"
                }
                
                var expressSeleted = ""
                if self.expressDeliverySelected {
                    expressSeleted = "Yes"
                }else {
                    expressSeleted = "No"
                }
                
                let request = PlaceOrder.Request(exp_delivery: exTemp, bag_selected: bagTemp, wallet_selected: wallTemp, order_total: UserDefaultsManager.getCartAmount(), instruction: self.orderSpecialInstruction, del_time: self.DeliveryTimeSlot, del_date: self.convertDateFormater(self.DeliveryDateSlot), DIS_AMOUNT: "\(self.original_coupon_value)", DIS_ID: self.couponId, payment_method: self.paymentOption, super_wallet_selected: expressSeleted, use_super_wallet: "\(super_wallet_amt)",appVeriosn: AppInfo.kAppVersion)
                interactor?.callPlaceOrderApi(request: request)
            }
        }else {
            self.showTopMessage(message: "Please select payment option", type: .Error)
        }
        
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnRemoveCouponAction(_ sender: Any) {
        self.couponId = ""
        self.original_coupon_value = 0.0
        self.viewCoponApplied.isHidden = true
        self.vwCpn.isHidden = false
        self.calculateAmount()
    }
    
    
    func cashFreePayment(data: PlaceOrder.ViewModel) {
        CFPaymentService().doWebCheckoutPayment(
            params: getPaymentParams(data: data),
            env: data.cashfree_Mode ?? "",
            callback: self)
    }
}

extension PaymentOptionViewController: ApplyPromoCode {
    func success(title: String,message: String, id: String, value: String) {
        self.viewCoponApplied.isHidden = false
        self.lblCouponNAme.text = "\(title) Applied Successfully"
        self.lblCouponAppplied.text = message
        self.vwCpn.isHidden = true
        self.original_coupon_value = Double(value) ?? 0.0
        self.couponId = id
        self.calculateAmount()
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension PaymentOptionViewController: PaymentOptionDisplayLogic {
    
    func didReceivePaymentResponse(response: PaymentOption.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                let paymentData = data.final_charges?[0]
                
                if paymentData?.paytm ?? "" == "No" {
                    self.viewPatymShow = false
                    self.vieewBottomPaytm.isHidden = true
                    paymentOption = ""
                }else {
                    self.viewPatymShow = true
                    self.vieewBottomPaytm.isHidden = false
                }
                
                
                if paymentData?.cod ?? "" == "No" {
                    self.viewCodShow = false
                    self.viewBottomCOD.isHidden = true
                }else {
                    self.viewCodShow = true
                    self.viewBottomCOD.isHidden = false
                }
                
                
                if paymentData?.payu ?? "" == "No" {
                    self.viewPayuShow = false
                    self.viewBottomPayu.isHidden = true
                }else {
                    self.viewPayuShow = true
                    self.viewBottomPayu.isHidden = false
                }
                
                
                if paymentData?.wallet_option ?? "" == "No" {
                    self.viewWalletShow = false
                    
                }else {
                    self.viewWalletShow = true
                    
                }
                
                if paymentData?.coupon ?? "" == "No" {
                    self.viewCouponShow = false
                }else {
                    self.viewCouponShow = true
                }
                
                
                if paymentData?.express ?? "" == "No" {
                    self.viewExpressShow = false
                    // self.viewExpressDelveryPay.isHidden = true
                }else {
                    self.viewExpressShow = true
                    // self.viewExpressDelveryPay.isHidden = false
                }
                
                
                if paymentData?.bag ?? "" == "No" {
                    self.viewBagShow = false
                    self.viewBagChargePay.isHidden = true
                }else {
                    self.viewBagShow = true
                    self.viewBagChargePay.isHidden = false
                }
                
                //26 aug we hide parent view
                if paymentData?.super_wallet_option ?? "" == "No" {
                    self.superWallet = false
                    self.viewFarmFreshSuperWallet.isHidden = true
                    self.viewFarmFresh.isHidden = true
                }else {
                    self.superWallet = true
                    self.viewFarmFreshSuperWallet.isHidden = false
                    self.viewFarmFresh.isHidden = false
                }
                
                
                self.lblFarmFreshSuperText.text = paymentData?.super_wallet_label ?? ""
                self.lblFarmFreshSuperNewMessage.text = paymentData?.super_wallet_text ?? ""
                
                
                if paymentData?.wallet_bal ?? "" == "0" {
                    // self.view
                }
                
                self.lblBottomPayuText.text = paymentData?.payu_label ?? ""
                
                self.lblBottomPayuMessage.text = paymentData?.payu_text ?? ""
                
                self.lblBottomPaytmText.text = paymentData?.paytm_label ?? ""
                
                self.lblBottomPaytmMessage.text = paymentData?.paytm_text ?? ""
                
                self.lblBottomCodText.text = paymentData?.cod_label ?? ""
                
                self.lblBottomCodNessage.text = paymentData?.cod_text ?? ""
                
                self.original_wallet_bal = Double(Float(paymentData?.wallet_bal ?? "") ?? 0.0)
                
                self.lblSuperAmountUsed.text = "You can use maximum ₹\((paymentData?.super_wallet_bal ?? ""))"
                
                self.super_wallet_amt = Double(Float(paymentData?.super_wallet_bal ?? "") ?? 0.0)
                
                self.original_express_value = Double(Float(paymentData?.express_charges ?? "") ?? 0.0)
                
                self.original_bag_value = Double(Float(paymentData?.bag_charges ?? "") ?? 0.0)
                
                self.area_charge = Double(Float(paymentData?.area_charge ?? "") ?? 0.0)
                
                if (paymentData?.bag_charges_auto ?? "") == "Yes" {
                    self.btnBagCharge.isSelected = true
                    self.imgBagSelected.isHidden = false
                }
                
                
                self.lblFarmFreshVegiMesage.text = "Available Balance: \(paymentData?.display_wallet_bal ?? "")"
                
                self.lblBagChargePayText.text = (paymentData?.bag_label ?? "")
                
                self.lblBagChargePayMessage.text = (paymentData?.bag_text ?? "")
                
                self.lblExpressDeliveryPayText.text = (paymentData?.express_label ?? "")
                
                self.lblFarmFreshWalletNewMessage.text = (paymentData?.wallet_text ?? "")
                
                if (paymentData?.wallet_text ?? "") == "" {
                    self.lblFarmFreshWalletNewMessage.isHidden = true
                }else {
                    self.lblFarmFreshWalletNewMessage.isHidden = false
                }
                
                self.calculateAmount()
                
                
            }else {
                self.showTopMessage(message: message, type: .Error)
                self.navigationController?.popViewController(animated: true)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func didReceivePlaceOrderResponse(response: [PlaceOrder.ViewModel]?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                UserDefaultsManager.setCartCount(count: "0")
                UserDefaultsManager.setCartAmount(amount: "0")
                if let VC = OrderSuccessViewController.instance() {
                    VC.orderSuccess = true
                    VC.titleOrder = "Thank You"
                    VC.isFromPaytm = false
                    VC.modalPresentationStyle = .overCurrentContext
                    self.present(VC, animated: true, completion: nil)
                }
                
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else if successCode == 5 {
            if let data = response {
                if let frstObjj = data.first {
                    self.orderMasterId = frstObjj.orderMasterID  ?? ""
                    self.cashFreePayment(data: frstObjj)
                    
                }
            }
        }else if successCode == 7 {
            if let data = response {
                if let frstObjj = data.first {
                    //New payment
                    self.orderResponse = frstObjj
                    self.orderMasterId = frstObjj.orderMasterID  ?? ""
                    self.openRazorpayCheckout(data: frstObjj)
                    
                    
                }
            }
        }
        else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    func didReceivePayTmOrder(response: PaytmOrderResult.ViewModel?,message: String, successCode: Int) {
        if successCode == 0 {
        }
    }
}






extension PaymentOptionViewController:  ResultDelegate {
    
    func onPaymentCompletion(msg: String) {
        print("JSON value : \(msg)")
        let inputJSON = "\(msg)"
        let inputData = inputJSON.data(using: .utf8)!
        let decoder = JSONDecoder()
        if inputJSON != "" {
            do {
                let result2 = try decoder.decode(ResultPayment.self, from: inputData)
                let request = PaytmOrderResult.Request(orderId: result2.orderId, orderAmount: result2.orderAmount, referenceId: result2.referenceId, txStatus: result2.txStatus, paymentMode: result2.paymentMode, txMsg: result2.txMsg, txTime: result2.txTime, signature: result2.signature, rozerPayId: "")
                AddMoneyWorker.callCartPaymentStatusAPI(request: request) { (response, message, success) in
                    if success == 0 {
                        if let data = response {
                            if data.payment_status == "Success" {
                                if let VC = OrderSuccessViewController.instance() {
                                    UserDefaultsManager.setCartCount(count: "0")
                                    UserDefaultsManager.setCartAmount(amount: "0")
                                    VC.orderSuccess = true
                                    VC.message = data.msg2 ?? ""
                                    VC.titleOrder = data.msg1 ?? ""
                                    VC.isFromPaytm = false
                                    VC.modalPresentationStyle = .overCurrentContext
                                    self.present(VC, animated: true, completion: nil)
                                }
                            }else {
                                if let VC = OrderSuccessViewController.instance() {
                                    VC.orderSuccess = false
                                    VC.message = data.msg2 ?? ""
                                    VC.titleOrder = data.msg1 ?? ""
                                    VC.isFromPaytm = false
                                    VC.orderId = self.orderMasterId
                                    VC.dele = self
                                    VC.modalPresentationStyle = .overCurrentContext
                                    self.present(VC, animated: true, completion: nil)
                                }
                            }
                        }
                    }
                }
                
                
            } catch {
                // handle exception
                //print("BDEBUG: Error Occured while retrieving transaction response")
                do {
                    let result2 = try decoder.decode(FailResultPayment.self, from: inputData)
                    let request = PaytmOrderResult.Request(orderId: "", orderAmount: "", referenceId: "", txStatus: result2.txStatus, paymentMode: "", txMsg: result2.txMsg, txTime: "", signature: "", rozerPayId: "")
                    AddMoneyWorker.callCartPaymentStatusAPI(request: request) { (response, message, success) in
                        if success == 0 {
                            if let data = response {
                                if data.payment_status == "Success" {
                                    if let VC = OrderSuccessViewController.instance() {
                                        UserDefaultsManager.setCartCount(count: "0")
                                        UserDefaultsManager.setCartAmount(amount: "0")
                                        VC.orderSuccess = true
                                        VC.message = data.msg2 ?? ""
                                        VC.titleOrder = data.msg1 ?? ""
                                        VC.isFromPaytm = false
                                        VC.modalPresentationStyle = .overCurrentContext
                                        self.present(VC, animated: true, completion: nil)
                                    }
                                }else {
                                    if let VC = OrderSuccessViewController.instance() {
                                        VC.orderSuccess = false
                                        VC.message = data.msg2 ?? ""
                                        VC.titleOrder = data.msg1 ?? ""
                                        VC.isFromPaytm = false
                                        VC.orderId = self.orderMasterId
                                        VC.dele = self
                                        VC.modalPresentationStyle = .overCurrentContext
                                        self.present(VC, animated: true, completion: nil)
                                    }
                                }
                            }
                        }
                    }
                }catch {
                    
                }
                
            }
        } else {
            print("BDEBUG: transactionResult is empty")
        }
    }
    
    
    func getPaymentParams(data: PlaceOrder.ViewModel) -> Dictionary<String, Any> {
        return [
            "orderId": data.orderId ?? "",
            "appId": data.cashfree_clientID ?? "",
            "tokenData" : data.token ?? "",
            "orderAmount": data.orderAmount ?? "",
            "customerName": data.customerName ?? "",
            "orderNote": data.orderNote ?? "",
            "orderCurrency": data.orderCurrency ?? "",
            "customerPhone": data.customerPhone ?? "",
            "customerEmail": data.customerEmail ?? "",
            "notifyUrl": data.notifyUrl ?? "",
            "color1":  "#11823B",
            "color2": "#000000"
        ]
    }
}



extension PaymentOptionViewController: OrderStatusRedirection {
    
    func redirect(apiData: WSResponse<PlaceOrder.ViewModel>?) {
        self.dismiss(animated: false, completion: nil)
        if let detail = apiData {
            if detail.status == "0" {
                if let data = apiData?.arrayData?.first {
                    if let data = apiData {
                        if let frstObjj = data.arrayData?.first {
//                            self.cashFreePayment(data: frstObjj)
//                            self.orderMasterId = frstObjj.orderMasterID  ?? ""
                            
                            self.orderResponse = frstObjj
                            self.orderMasterId = frstObjj.orderMasterID  ?? ""
                            self.openRazorpayCheckout(data: frstObjj)
                        }
                    }else {
                        self.showTopMessage(message: apiData?.message ?? "", type: .Error)
                    }
                    
                }else {
                    self.showTopMessage(message: apiData?.message ?? "", type: .Error)
                }
            }
        }
        else {
            self.showTopMessage(message: apiData?.message ?? "", type: .Error)
        }
    }
}




extension PaymentOptionViewController {
    
    private func openRazorpayCheckout(data: PlaceOrder.ViewModel) {
        razorpayObj = RazorpayCheckout.initWithKey(AppConstant.razorpayKey, andDelegateWithData: self)
        
        let options: [String:Any] = [            
            "amount": "\((Int(data.orderAmount ?? "") ?? 0) * 100)",
            "currency": "INR",
            "description": data.orderNote ?? "",
            "order_id":  data.razorpayOrderId ?? "",
            "image": UIImage(named: "login_logo"),
            "name": AppInfo.kAppName,
            "prefill": [
                "contact": UserDefaultsManager.getLoggedUserDetails()?.phone ?? "",
                "email": UserDefaultsManager.getLoggedUserDetails()?.email ?? ""
            ],
            "notes": [
                "merchant_order_id": data.orderId ?? "",
                "master_types": "OrderPayment"
            ],
            "theme": [
                "color": "#11823B"
            ]
        ]
        
        
        if let rzp = self.razorpayObj {
            rzp.open(options)
        } else {
            print("Unable to initialize")
        }
    }
}





extension PaymentOptionViewController: RazorpayPaymentCompletionProtocolWithData {
    
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        print("error: ", code)
        self.callAPI(refrenceId: "", signature: "", status: "fail", riid: "")
    }
    
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        print("success: ", payment_id)
        
        guard let rPayId = response?["razorpay_payment_id"] as? String else {return}
        guard let rsignature = response?["razorpay_signature"] as? String else { return }
        guard let riddd  = response?["razorpay_order_id"] as? String else { return }
        
        
        self.callAPI(refrenceId: rPayId, signature: rsignature, status: "success", riid: riddd)
    }
    
    func callAPI(refrenceId: String, signature: String, status: String, riid: String) {
        
        let request = PaytmOrderResult.Request(orderId: self.orderResponse?.orderId ?? "", orderAmount: self.orderResponse?.orderAmount ?? "", referenceId: refrenceId, txStatus: status, paymentMode: "Rozarpay", txMsg: "", txTime: "", signature: signature, rozerPayId: riid)
        AddMoneyWorker.callCartPaymentStatusAPI(request: request) { (response, message, success) in
            if success == 0 {
                if let data = response {
                    if data.payment_status == "Success" {
                        if let VC = OrderSuccessViewController.instance() {
                            UserDefaultsManager.setCartCount(count: "0")
                            UserDefaultsManager.setCartAmount(amount: "0")
                            VC.orderSuccess = true
                            VC.message = data.msg2 ?? ""
                            VC.titleOrder = data.msg1 ?? ""
                            VC.isFromPaytm = false
                            VC.modalPresentationStyle = .overCurrentContext
                            self.present(VC, animated: true, completion: nil)
                        }
                    }else {
                        if let VC = OrderSuccessViewController.instance() {
                            VC.orderSuccess = false
                            VC.message = data.msg2 ?? ""
                            VC.titleOrder = data.msg1 ?? ""
                            VC.isFromPaytm = false
                            VC.orderId = self.orderMasterId
                            VC.dele = self
                            VC.modalPresentationStyle = .overCurrentContext
                            self.present(VC, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
}
