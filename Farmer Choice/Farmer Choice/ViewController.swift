import UIKit
import CoreLocation
import FBSDKCoreKit

class ViewController: UIViewController {
    
    
    let locationManager = CLLocationManager()
    
    var setController = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //AppEventsLogger.log("OpenApp")
        
        AppEvents.logEvent(AppEvents.Name(rawValue: "OpenApp"))
        
        //main
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    if UserDefaultsManager.getMapAccess() == "1" {
                        self.setRedirection()
                    }else {
                        self.getLocation()
                    }
                case .authorizedAlways, .authorizedWhenInUse:
                    self.setRedirection()
                default:
                    self.setRedirection()
                }
            }else {
                self.setRedirection()
            }
        }
        
        //main till now
        
        
        //        //test paytm
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        //            if let VC = PaytmIntegrationViewController.instance() {
        //                self.navigationController?.pushViewController(VC, animated: true)
        //            }
        //        }
        
        
    }
    
    func setRedirection() {
        if UserDefaultsManager.getAppLaunshFirst() == "1" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.redirection()
            }
            
        }else {
            //            if let VC = IntroViewController.instance() {
            //                self.navigationController?.pushViewController(VC, animated: true)
            //            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.redirection()
            }
        }
    }
    
    
    
    
    func getLocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        self.redirection()
    }
    
    
    func forceFullyLocationGrap() {
        let alertController = UIAlertController(title:  "\(AppInfo.kAppName)", message: "Allow \(AppInfo.kAppName) to access your current location otherwise you are not abel to access application", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: NSLocalizedString("Settings", comment: ""), style: .default) { (UIAlertAction) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)! as URL, options: [:], completionHandler: nil)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    // Required
    
    func redirection() {
        if UserDefaultsManager.intoAdded() == "" {
            if let VC = IntroViewController.instance() {
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }else {
            if UserDefaultsManager.getCityId() == "" {
                if let VC = SelectCityViewController.instance() {
                    self.navigationController?.pushViewController(VC, animated: true)
                }
                
                
            }else {
                let user = UserDefaultsManager.getLoggedUserDetails()
                if user?.userId != ""  && user?.userId != nil {
                    AppConstant.appDelegate.setRootViewController()
                }else {
                    if let VC = AuthenticationViewController.instance() {
                        self.navigationController?.pushViewController(VC, animated: true)
                    }
                }
            }
        }
    }
    
}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        AppConstant.currLongitude = (locValue.longitude)
        AppConstant.currLatitude = (locValue.latitude)
        //self.setRedirection()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        UserDefaultsManager.setMapAccess(launch: "1")
        self.setRedirection()
    }
}

