

import UIKit

protocol ChangeCity {
    func changed(success: Bool)
}

protocol AddCartQty {
    func updateQty()
}

protocol RedirectToDetails {
    func redirect(id: String)
}

protocol RedirectToCat {
    func redirectCat(id: String)
}

protocol DashBoardDisplayLogic: class {
    func didReceiveDashBoardResponse(response: DashBoard.ViewModel?, message: String, successCode: Int)
    func didReceiveDashBoardListResponse(response: DashBoardList.ViewModel?, message: String, successCode: Int)
    func didReceiveClearCartResponse(response: AddCart.ViewModel?, message: String, successCode: Int)
}

class DashBoardViewController: BaseViewController {
    
    @IBOutlet weak var clctnShopBrand: UICollectionView!
    
    @IBOutlet weak var viewFooter: UIView!
    
    
    @IBOutlet weak var viewReferImageNew: UIView!
    @IBOutlet weak var imgReferNew: UIImageView!
    
    
    @IBOutlet weak var viewWalletNavigation: UIView!
    
    @IBOutlet weak var lblWalletAmount: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var vwSrch: UIView!
    @IBOutlet weak var clctnViewFirst: UICollectionView!
    @IBOutlet weak var imgFrstCat: UIImageView!
    @IBOutlet weak var lblFrstCat: UILabel!
    @IBOutlet weak var imgSecondCat: UIImageView!
    @IBOutlet weak var lblSecondCat: UILabel!
    @IBOutlet weak var imgCatThird: UIImageView!
    @IBOutlet weak var lblcatThird: UILabel!
    @IBOutlet weak var imgcatFourth: UIImageView!
    @IBOutlet weak var lblCatFourth: UILabel!
    // @IBOutlet weak var clctnViewSecond: UICollectionView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewCart: UIView!
    @IBOutlet weak var lblCartCount: UILabel!
    
    @IBOutlet weak var vwNewFooter: UIView!
    @IBOutlet weak var imgNewFooter: UIImageView!
    
    @IBOutlet weak var clctCategoryTop: UICollectionView!
    
    @IBOutlet weak var viewHeaderHeight: NSLayoutConstraint!
    @IBOutlet weak var clctnCatHeight: NSLayoutConstraint!
    @IBOutlet weak var lblCityame: UILabel!
    
    
    
    var lstBannerPosition = 0
    var lstOfferPosition = 0
    
    var pageCode = 0
    var nextPageAva = true
    var apiInProgress = false
    
    var apperCall = false
    
    var changeAddress = false
    
    
    var appUpdate = false
    var forceUpdate = false
    var appMessage = ""
    
    var interactor: DashBoardBusinessLogic?
    var router: (NSObjectProtocol & DashBoardRoutingLogic & DashBoardDataPassing)?
    
    var bannerList = [DashBoard.Banner_list]()
    var shopBrand = [DashBoard.DashBoardBrandList]()
    var offerList = [DashBoard.Offer_banner]()
    var categoryList = [DashBoard.Home_category_list]()
    var tableData = [DashBoardList.Home_category_products]()
    
    var newCategorydata = [DashBoardList.categoy_master_listArray]()
    
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
        let interactor = DashBoardInteractor()
        let presenter = DashBoardPresenter()
        let router = DashBoardRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //MARK: ClassInsatance
    class func instance() -> DashBoardViewController? {
        return UIStoryboard(name: "DashBoard", bundle: nil).instantiateViewController(withIdentifier: "DashBoardViewController") as? DashBoardViewController
    }
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(updateDashboard), name: NSNotification.Name.init("updateDashboard"), object: nil)
        if GuestUser.isUserGuest {
            self.viewWalletNavigation.isHidden = true
        }
        self.lblCityame.text = UserDefaultsManager.getCityName()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCartCount()
        if GlobalUtility.shared.OrderSuccess {
            GlobalUtility.shared.OrderSuccess = false
            //self.rediretToOrderList()
            
            if let VC = OrderHistoryViewController.instance() {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
        
        if GlobalUtility.shared.paytmMoneyAdd {
            GlobalUtility.shared.paytmMoneyAdd = false
            if let VC = WalletHistoryViewController.instance() {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
        
        if apperCall {
            self.pageCode = 0
            let request = DashBoardList.Request(pageCode: self.pageCode)
            interactor?.callDashBoardListAPI(request: request, loader: false)
        }else {
            apperCall = true
        }
        
        
        if AppConstant.appDelegate.pushDict != nil {
            AppConstant.appDelegate.pushDict = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
            if let VC = OfferPromotionViewController.instance() {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
    
        
        

    }
    
    @objc func updateDashboard(n: Notification) {
        //let request = DashBoardList.Request(pageCode: self.pageCode)
        //interactor?.callDashBoardListAPI(request: request, loader: false)
    }
    
    
    func setCartCount() {
        //        if UserDefaultsManager.getCartCount() == "" || UserDefaultsManager.getCartCount() == "0" {
        //            self.viewCart.isHidden = true
        //        }else {
        //            self.viewCart.isHidden = false
        //            self.lblCartCount.text = UserDefaultsManager.getCartCount()
        //        }
        
        self.viewCart.isHidden = false
        self.lblCartCount.text = UserDefaultsManager.getCartCount()
    }
    
    func setUpLayout() {
        callAPI(loader: true)
        self.vwSrch.setShadow()
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    func callAPI(loader: Bool) {
        let tm = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        
        let request = DashBoard.Request(deviceId: "", tokenId: UserDefaultsManager.deviceToken, appVersion: "\(tm)")
        interactor?.callDashBoardApi(request: request)
    }
    
    
    @objc func fireTimer() {
        
        if self.bannerList.count > 0 {
            if lstBannerPosition < self.bannerList.count - 1 {
                lstBannerPosition = lstBannerPosition + 1
                self.clctnViewFirst.scrollToItem(at: IndexPath(item: lstBannerPosition, section: 0), at: .right, animated: true)
            }else {
                lstBannerPosition = 0
                self.clctnViewFirst.scrollToItem(at: IndexPath(item: lstBannerPosition, section: 0), at: .right, animated: true)
            }
        }
        //        if offerList.count > 0 {
        //            if lstOfferPosition < self.offerList.count - 1 {
        //                lstOfferPosition = lstOfferPosition + 1
        //                self.clctnViewSecond.scrollToItem(at: IndexPath(item: lstOfferPosition, section: 0), at: .right, animated: true)
        //            }else {
        //                lstOfferPosition = 0
        //                self.clctnViewSecond.scrollToItem(at: IndexPath(item: lstOfferPosition, section: 0), at: .right, animated: true)
        //            }
        //        }
        
    }
    
    @IBAction func btnChangeCityAction(_ sender: Any) {
        if GuestUser.isUserGuest {
            self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                if let VC = AuthenticationViewController.instance() {
                    let navVC = UINavigationController(rootViewController: VC)
                    AppConstant.appDelegate.window?.rootViewController = navVC
                }
            }, cancelAction: nil)
        }else {
            if UserDefaultsManager.getCartCount() == "0" {
                self.interactor?.callClearCartApi()
            }else {
                self.displayAlert(msg: "To change area need to empty your cart, are you sure you want to empty your cart?", ok: "Proceed", cancel: "No") {
                    self.interactor?.callClearCartApi()
                } cancelAction: {
                    print("No")
                }
            }
        }
    }
    
    @IBAction func btnReferNewAction(_ sender: Any) {
        if GuestUser.isUserGuest {
            self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                if let VC = AuthenticationViewController.instance() {
                    let navVC = UINavigationController(rootViewController: VC)
                    AppConstant.appDelegate.window?.rootViewController = navVC
                }
            }, cancelAction: nil)
        }else {
            if let VC = ReferEarnViewController.instance() {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
    }
    
    @IBAction func btnNotiAction(_ sender: Any) {
        if GuestUser.isUserGuest {
            self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                if let VC = AuthenticationViewController.instance() {
                    let navVC = UINavigationController(rootViewController: VC)
                    AppConstant.appDelegate.window?.rootViewController = navVC
                }
            }, cancelAction: nil)
        }else {
            if let VC = OfferPromotionViewController.instance() {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
    }
    
    @IBAction func btnTopWalletAction(_ sender: Any) {
        //        self.redirectToWallet()
        
        if let VC = WalletHistoryViewController.instance() {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    
    @IBAction func btnLeftMenuAction(_ sender: Any) {
        self.showLeftMenu()
    }
    
    @IBAction func btnSearchAction(_ sender: Any) {
        if let VC = SearchProductViewController.instance(){
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnCartAction(_ sender: Any) {
        self.redirectToCart()
    }
    
    
    @IBAction func btnCatFrstAction(_ sender: Any) {
        if let VC = WishListViewController.instance() {
            VC.isFrom = "category"
            VC.catId = categoryList[0].catID ?? ""
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnCatSecondAction(_ sender: Any) {
        if let VC = WishListViewController.instance() {
            VC.isFrom = "category"
            VC.catId = categoryList[1].catID ?? ""
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    
    @IBAction func btnCatThirdAction(_ sender: Any) {
        if let VC = WishListViewController.instance() {
            VC.isFrom = "category"
            VC.catId = categoryList[2].catID ?? ""
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnCatFourthAction(_ sender: Any) {
        if let VC = WishListViewController.instance() {
            VC.isFrom = "category"
            VC.catId = categoryList[3].catID ?? ""
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    
    @IBAction func btnHomeAction(_ sender: Any) {
        //self.tblView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        self.tblView.setContentOffset( CGPoint(x: 0, y: 0) , animated: true)
        
    }
    
    @IBAction func btnInfoAction(_ sender: Any) {
        self.redirectToHelp()
    }
    
    @IBAction func btnListAction(_ sender: Any) {
        self.rediretToOrderList()
    }
    
    @IBAction func btnWalletAction(_ sender: Any) {
        self.redirectToWallet()
    }
    
    @IBAction func btnAcountAction(_ sender: Any) {
        if GuestUser.isUserGuest {
            self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                if let VC = AuthenticationViewController.instance() {
                    let navVC = UINavigationController(rootViewController: VC)
                    AppConstant.appDelegate.window?.rootViewController = navVC
                }
            }, cancelAction: nil)
        }else {
            if let VC = MyAccountViewController.instance() {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
    }
    
    
    @IBAction func btnShopCateogryAction(_ sender: Any) {
        if let VC = CategoryViewController.instance() {
            self.navigationController?.pushViewController(VC, animated: true)
        }
        
    }
    
    
    @IBAction func btnShopBrandAllAction(_ sender: Any) {
        if let VC = BrandViewController.instance(){
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnNewFooterAction(_ sender: Any) {
        
        if let VC = HelpCenterViewController.instance(){
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
}


extension DashBoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clctnViewFirst {
            return bannerList.count
        }else if collectionView == clctCategoryTop {
            return categoryList.count
        }else if collectionView == clctnShopBrand {
            return shopBrand.count
        }else {
            //return offerList.count
            
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == clctCategoryTop {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCategoryCollectionViewCell", for: indexPath) as!  DashboardCategoryCollectionViewCell
            cell.imgIcon.setImage(with: "\(categoryList[indexPath.row].icon ?? "")",placeHolder: UIImage(named: ""))
            cell.lblTitke.text = categoryList[indexPath.row].name ?? ""
            return cell
            
        }else if collectionView == clctnShopBrand {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardShopBrandCollectionViewCell", for: indexPath) as! DashboardShopBrandCollectionViewCell
            cell.imgIcon.setImage(with: self.shopBrand[indexPath.row].image ?? "")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCollectionViewCell", for: indexPath) as! DashboardCollectionViewCell
            
            if collectionView == clctnViewFirst {
                cell.setBannerData(data: self.bannerList[indexPath.row])
            }else {
                cell.setOfferData(data: self.offerList[indexPath.row])
            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == clctCategoryTop {
            return CGSize(width: ((UIScreen.main.bounds.width - 10) / 3), height: 120.0)
        }else if collectionView == clctnShopBrand {
            return CGSize(width: ((UIScreen.main.bounds.width - 10) / 3.3), height: 70.0)
        } else {
            return CGSize(width: (UIScreen.main.bounds.width), height: 150.0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == clctCategoryTop {
            if let VC = WishListViewController.instance() {
                VC.isFrom = "category"
                VC.catId = categoryList[indexPath.row].catID ?? ""
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }else if collectionView == clctnShopBrand {
            if let VC = WishListViewController.instance() {
                VC.isFrom = "brand"
                VC.brandId = shopBrand[indexPath.row].brandID ?? ""
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
        //        else if collectionView ==  clctnViewSecond {
        //            if let VC = WishListViewController.instance() {
        //                VC.isFrom = "category"
        //                VC.catId = offerList[indexPath.row].catID ?? ""
        //                self.navigationController?.pushViewController(VC, animated: true)
        //            }
        //        }
        else if collectionView ==  clctnViewFirst {
            if let VC = WishListViewController.instance() {
                VC.isFrom = "category"
                VC.catId = bannerList[indexPath.row].catID ?? ""
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
    }
    
}

extension DashBoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if offerList.count > 0{
            return tableData.count + newCategorydata.count + 1
        }else {
            return tableData.count + newCategorydata.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashBoardTableViewCell", for: indexPath) as! DashBoardTableViewCell
        
        if tableData.count > indexPath.row {
            cell.setData(data: tableData[indexPath.row])
        }else if (tableData.count) == indexPath.row {
            cell.setOfferData(data: self.offerList)
        }
        else {
            cell.catDelegate = self
            cell.setNewDesign(data: newCategorydata[ indexPath.row - (tableData.count + 1)])
        }
        
        
        cell.viewClouser = {
            if GuestUser.isUserGuest {
                self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                    if let VC = AuthenticationViewController.instance() {
                        let navVC = UINavigationController(rootViewController: VC)
                        AppConstant.appDelegate.window?.rootViewController = navVC
                    }
                }, cancelAction: nil)
            }else {
                if let VC = WishListViewController.instance() {
                    VC.isFrom = "category"
                    VC.catId = self.tableData[indexPath.row].catID ?? ""
                    self.navigationController?.pushViewController(VC, animated: true)
                }
            }
            
        }
        cell.cartDelegate = self
        cell.redirectDele = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !apiInProgress && (indexPath.row == tableData.count - 1) &&  nextPageAva {
            print("API CALL")
            nextPageAva = true
            self.pageCode += 1
            let request = DashBoardList.Request(pageCode: self.pageCode)
            interactor?.callDashBoardListAPI(request: request, loader: false)
        }
    }
    
    
}

extension DashBoardViewController: AddCartQty {
    func updateQty() {
        self.setCartCount()
    }
}

extension DashBoardViewController: RedirectToDetails {
    func redirect(id: String) {
        if let VC = ProductDetailsViewController.instance() {
            VC.productId = id
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}

extension DashBoardViewController: DashBoardDisplayLogic {
    
    func didReceiveClearCartResponse(response: AddCart.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            UserDefaultsManager.selectCityId(id: "")
            UserDefaultsManager.selectCityName(name: "")
            UserDefaultsManager.selectAreaId(areaId: "")
            UserDefaultsManager.setCartCount(count: "0")
            self.lblCartCount.text = "0"
            if let VC = SelectCityViewController.instance() {
                VC.modalPresentationStyle = .fullScreen
                VC.isFormDashboard = true
                VC.dele = self
                self.present(VC, animated: false, completion: nil)
            }
        }else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    
    func didReceiveDashBoardResponse(response: DashBoard.ViewModel?, message: String, successCode: Int) {
        if successCode == 0 {
            if let data = response {
                print(successCode)
                
                if (data.userCityId ?? "") != "" &&  (data.userCityName ?? "") != ""  {
                    UserDefaultsManager.selectCityId(id: data.userCityId ?? "")
                    UserDefaultsManager.selectCityName(name: data.userCityName ?? "")
                    //UserDefaultsManager.selectAreaId(areaId: data.userCityId ?? "")
                    UserDefaultsManager.setCartCount(count: "0")
                    self.lblCartCount.text = "0"
                    self.lblCityame.text = UserDefaultsManager.getCityName()
                    callAPI(loader: true)
                    
                }else {
                    if data.brand_list != nil {
                        self.shopBrand = data.brand_list!
                    }
                    
                    //version, message
                    let serverVersion = Double(data.iphone_version ?? "") ?? 1.0
                    let currAppVersion = Double(AppConstant.appVersion ?? "1.0") ?? 1.0
                    
                    self.appUpdate = false
                    self.forceUpdate = false
                    
                    if serverVersion > currAppVersion {
                        
                        if let VC = ForceUpdateViewController.instance() {
                            VC.titleMessage =  data.iphone_msg ?? ""
                            if (data.iphone_update_force ?? "") == "Yes" {
                                VC.forceUpdate = true
                            }else {
                                VC.forceUpdate = false
                            }
                            VC.modalPresentationStyle = .overCurrentContext
                            VC.clouer = {
                                if let url = URL(string: "https://apps.apple.com/us/app/apple-store/id\(AppInfo.kAppstoreID)?ls=1") {
                                    if #available(iOS 10.0, *) {
                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                    } else {
                                        // Earlier versions
                                        if UIApplication.shared.canOpenURL(url as URL) {
                                            UIApplication.shared.openURL(url as URL)
                                        }
                                    }
                                }
                            }
                            self.present(VC, animated: false, completion: nil)
                        }
                        
                    }
                    if (data.banner_bootom_image ?? "") == "" {
                        self.tblView.tableFooterView?.frame.size = CGSize(width: tblView.frame.width, height: 0)
                        self.vwNewFooter.isHidden = true
                    }else {
                        self.vwNewFooter.isHidden = false
                        self.imgNewFooter.setImage(with: data.banner_bootom_image ?? "")
                    }
                    
                    
                    if let bl = data.banner_list {
                        self.bannerList = bl
                    }
                    if let ob = data.offer_banner {
                        self.offerList = ob
                    }
                    
                    if let hc = data.home_category_list {
                        self.categoryList = hc
                    }
                    
                    self.clctnViewFirst.reloadData()
                    self.clctnShopBrand.reloadData()
                    
                    self.lblMessage.text = data.dashboardMsg ?? ""
                    
                    self.lblWalletAmount.text = "₹\(data.wallet ?? "0")"
                    var clctnHghtCount = 0
                    clctnHghtCount = categoryList.count / 3
                    
                    if categoryList.count % 3 != 0 {
                        clctnHghtCount += 1
                    }
                    
                    
                    var earnConstant = 0
                    
                    if data.refer_image == "" {
                        earnConstant = 0
                        self.viewReferImageNew.isHidden = true
                    }else {
                        earnConstant = 150
                        self.viewReferImageNew.isHidden = false
                        self.imgReferNew.setImage(with: data.refer_image ?? "")
                    }
                    
                    self.clctnCatHeight.constant = CGFloat(120 * clctnHghtCount)
                    self.clctCategoryTop.reloadData()
                    let HEADER_HEIGHT = 300 + earnConstant + (120 * clctnHghtCount)
                    tblView.tableHeaderView?.frame.size = CGSize(width: tblView.frame.width, height: CGFloat(HEADER_HEIGHT))
                    
                    let request = DashBoardList.Request(pageCode: self.pageCode)
                    interactor?.callDashBoardListAPI(request: request, loader: true)

                }
            }else {
                self.showTopMessage(message: message, type: .Error)
            }
        }else if successCode == 2 {
            UserDefaultsManager.logoutUser()
            UserDefaultsManager.selectCityName(name: "")
            UserDefaultsManager.selectCityId(id: "")
            UserDefaultsManager.selectAreaId(areaId: "")
            if let VC = SelectCityViewController.instance() {
                let navVC = UINavigationController(rootViewController: VC)
                AppConstant.appDelegate.window?.rootViewController = navVC
            }
        }
        else {
            self.showTopMessage(message: message, type: .Error)
        }
    }
    
    
    func didReceiveDashBoardListResponse(response: DashBoardList.ViewModel?, message: String, successCode: Int){
        if successCode == 0 {
            if let data = response {
                if self.pageCode == 0 {
                    if let tmHC = data.home_category_products {
                        self.tableData = tmHC
                    }
                    if let tmCM = data.categoy_master_list {
                        self.newCategorydata = tmCM
                    }
                }else {
                    self.tableData.append(contentsOf: data.home_category_products!)
                }
                self.tblView.reloadData()
                self.nextPageAva = true
                self.apiInProgress = false
            }else {
                //self.showTopMessage(message: message, type: .Error)
                self.nextPageAva = false
            }
        }else {
            if pageCode == 0 {
                // self.showTopMessage(message: message, type: .Error)
            }
            self.nextPageAva = false
            
            if changeAddress {
                changeAddress = false
                self.tableData.removeAll()
                self.tblView.reloadData()
            }
            
        }
    }
}

extension DashBoardViewController: ChangeCity {
    
    func changed(success: Bool) {
        apperCall = false
        self.dismiss(animated: false, completion: nil)
        if success {
            changeAddress = true
            self.viewDidLoad()
        }else {
            
            if let VC = CityFormViewController.instance() {
                VC.zipCode = ""
                VC.cityID = ""
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
        
    }
}



extension DashBoardViewController : RedirectToCat {
    func redirectCat(id: String) {
        if let VC = WishListViewController.instance() {
            VC.isFrom = "category"
            VC.catId = id
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
