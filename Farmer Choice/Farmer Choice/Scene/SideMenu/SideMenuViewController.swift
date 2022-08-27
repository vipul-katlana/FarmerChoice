
import UIKit
import SJSwiftSideMenuController


class SideMenuViewController: UIViewController {
    
    //MARK: IBOutlet and Constants
    var sideMenuItem = ["Categories","Your Last Choice","Offers & Promotions","My WishList","Order History","Contact Us","Help Center","Rate Us","About Us","Logout"]
    
    var sideMenuItemGuest = ["Categories","Your Last Choice","Offers & Promotions","My WishList","Order History","Contact Us","Help Center","Rate Us","About Us","Login"]
    
    var sideMenuImage = ["sidemenu_category","sidemenu_lastChoice","sidemenu_offer","sidemenu_mywishlist","sidemenu_orderhistory","sidemenu_contactus","sidemenu_helpcenter","sidemenu_rateUs","sidemenu_aboutus","sidemenu_logout"]
    
    @IBOutlet weak var imgUserprofile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfile), name: NSNotification.Name.init("updateProfile"), object: nil)
        if GuestUser.isUserGuest {
            self.lblName.text = "Guest User"
            self.lblPhone.text = ""
            self.imgUserprofile.image = UIImage(named: "user_profile")
            //var tm = sideMenuItem
            sideMenuItem  = sideMenuItemGuest
            
            
        }else {
            self.setUserData()
        }
        
    }
    
    @objc func updateProfile(n: Notification) {
        self.setUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if GuestUser.isUserGuest {
        }else {
            setUserData()
        }
        
    }
    
    func setUserData() {
        let user = UserDefaultsManager.getLoggedUserDetails()
        self.lblName.text = "\(user?.name ?? "") \(user?.lastname ?? "")"
        self.lblPhone.text = user?.phone ?? ""
        self.imgUserprofile.setImage(with: user?.userimage ?? "",placeHolder: UIImage(named: "user_profile"))
    }
    
    //MARK: Class Instance
    class func instance() -> SideMenuViewController? {
        return UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController") as? SideMenuViewController
    }
    
    //MARK: Class Method
    func setViewControllers(index: Int) {
        SJSwiftSideMenuController.hideLeftMenu()
        switch index {
        case 0:
            if let VC = CategoryViewController.instance() {
                SJSwiftSideMenuController.pushViewController(VC, animated: true)
            }
            return
        case 1:
            if GuestUser.isUserGuest {
                self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                    if let VC = AuthenticationViewController.instance() {
                        let navVC = UINavigationController(rootViewController: VC)
                        AppConstant.appDelegate.window?.rootViewController = navVC
                    }
                }, cancelAction: nil)
            }else {
                if let VC = WishListViewController.instance() {
                    VC.isFrom = "lastChoice"
                    SJSwiftSideMenuController.pushViewController(VC, animated: true)
                }
            }
            
            return
            
        case 2:
            if GuestUser.isUserGuest {
                self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                    if let VC = AuthenticationViewController.instance() {
                        let navVC = UINavigationController(rootViewController: VC)
                        AppConstant.appDelegate.window?.rootViewController = navVC
                    }
                }, cancelAction: nil)
            }else {
                if let VC = OfferPromotionViewController.instance() {
                    SJSwiftSideMenuController.pushViewController(VC, animated: true)
                }
            }
            
            return
//        case 3:
//            if GuestUser.isUserGuest {
//                self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
//                    if let VC = AuthenticationViewController.instance() {
//                        let navVC = UINavigationController(rootViewController: VC)
//                        AppConstant.appDelegate.window?.rootViewController = navVC
//                    }
//                }, cancelAction: nil)
//            }else {
//                if let VC = WalletHistoryViewController.instance() {
//                    SJSwiftSideMenuController.pushViewController(VC, animated: true)
//                }
//            }
//
//            return
        case 3:
            if GuestUser.isUserGuest {
                self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                    if let VC = AuthenticationViewController.instance() {
                        let navVC = UINavigationController(rootViewController: VC)
                        AppConstant.appDelegate.window?.rootViewController = navVC
                    }
                }, cancelAction: nil)
            }else {
                if let VC = WishListViewController.instance() {
                    VC.isFrom = "wishList"
                    SJSwiftSideMenuController.pushViewController(VC, animated: true)
                }
            }
            
            return
        case 4:
            if GuestUser.isUserGuest {
                self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                    if let VC = AuthenticationViewController.instance() {
                        let navVC = UINavigationController(rootViewController: VC)
                        AppConstant.appDelegate.window?.rootViewController = navVC
                    }
                }, cancelAction: nil)
            }else {
                if let VC = OrderHistoryViewController.instance() {
                    SJSwiftSideMenuController.pushViewController(VC, animated: true)
                }
            }
            
            return
//        case 6:
//            if GuestUser.isUserGuest {
//                self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
//                    if let VC = AuthenticationViewController.instance() {
//                        let navVC = UINavigationController(rootViewController: VC)
//                        AppConstant.appDelegate.window?.rootViewController = navVC
//                    }
//                }, cancelAction: nil)
//            }else {
//                if let VC = ReferEarnViewController.instance() {
//                    SJSwiftSideMenuController.pushViewController(VC, animated: true)
//                }
//            }
//
//            return
        case 5:
            if let VC = ContactUsViewController.instance() {
                SJSwiftSideMenuController.pushViewController(VC, animated: true)
            }
            return
        case 6:
            if let VC = HelpCenterViewController.instance() {
                SJSwiftSideMenuController.pushViewController(VC, animated: true)
            }
            return
        case 7:
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
            return
            
        case 8:
            if let VC = StaticPagesViewController.instance() {
                SJSwiftSideMenuController.pushViewController(VC, animated: true)
            }
            return
        case 9:
            if GuestUser.isUserGuest {
                UserDefaultsManager.logoutUser()
                UserDefaultsManager.selectCityName(name: "")
                UserDefaultsManager.selectAreaId(areaId: "")
                UserDefaultsManager.selectCityId(id: "")
                if let VC = SelectCityViewController.instance() {
                    let navVC = UINavigationController(rootViewController: VC)
                    AppConstant.appDelegate.window?.rootViewController = navVC
                }
            }else {
                self.displayAlert(msg: "Are you sure you want to logout?", ok: "Yes", cancel: "No", okAction: {
                    UserDefaultsManager.logoutUser()
                    UserDefaultsManager.selectCityName(name: "")
                    UserDefaultsManager.selectAreaId(areaId: "")
                    UserDefaultsManager.selectCityId(id: "")
                    if let VC = SelectCityViewController.instance() {
                        let navVC = UINavigationController(rootViewController: VC)
                        AppConstant.appDelegate.window?.rootViewController = navVC
                    }
                    
                    
                }, cancelAction: nil)
                return
            }
            
        default:
            print("Index not found")
        }
    }
    
    
    //MARK: IBAction
    @IBAction func btnMyAccountAction(_ sender: Any) {
        if GuestUser.isUserGuest {
            self.displayAlert(msg: GuestUser.guestUserMessage, ok: "Yes", cancel: "No", okAction: {
                if let VC = AuthenticationViewController.instance() {
                    let navVC = UINavigationController(rootViewController: VC)
                    AppConstant.appDelegate.window?.rootViewController = navVC
                }
            }, cancelAction: nil)
        }else {
            if let VC = MyAccountViewController.instance() {
                SJSwiftSideMenuController.hideLeftMenu()
                SJSwiftSideMenuController.pushViewController(VC, animated: true)
            }
        }
        
    }
    
    
}

extension SideMenuViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as? SideMenuTableViewCell
        cell?.lblTitle.text = sideMenuItem[indexPath.row]
        if indexPath.row == 2 || indexPath.row == 6 || indexPath.row == 10 {
            cell?.viewSeprator.isHidden = false
        }else {
            cell?.viewSeprator.isHidden = true
        }
        cell?.imgIcon.image = UIImage(named: sideMenuImage[indexPath.row])
        
        cell?.imgIcon.image = cell?.imgIcon.image?.withRenderingMode(.alwaysTemplate)
        cell?.imgIcon.tintColor = AppConstant.appGreenColor!
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.setViewControllers(index: indexPath.row)
    }
    
}
