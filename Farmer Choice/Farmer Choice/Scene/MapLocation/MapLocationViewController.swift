
import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces
import Alamofire

protocol SearchLocation {
    func getData(heading: String, title: String, lat: Double, long: Double)
}

protocol MapLocationDisplayLogic: class {
    func displaySomething(viewModel: MapLocation.Something.ViewModel)
}

class MapLocationViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAdrs: UILabel!
    @IBOutlet var viewMarkerIcon: UIView!
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var btnCurrentLocation: UIButton!
    
    var resData: DeliveryAddress.ViewModel?
    
    var mapView: GMSMapView!
    var marker: GMSMarker!
    
    var currLat = 0.0
    var currLong = 0.0
    let locationManager = CLLocationManager()
    var searchLong = 0.0
    var searchLat = 0.0
    
    var didApperCall = false
    
    var interactor: MapLocationBusinessLogic?
    var router: (NSObjectProtocol & MapLocationRoutingLogic & MapLocationDataPassing)?
    
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
        let interactor = MapLocationInteractor()
        let presenter = MapLocationPresenter()
        let router = MapLocationRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !didApperCall {
            didApperCall = true
            self.setMap(showPin: true, mapMode: "normal")
        }
        
    }
    
    func setUpLayout() {
        if (resData?.get_detail?[0].lat ?? "0.0") != "" {
            self.currLat = Double(resData?.get_detail?[0].lat ?? "0.0")!
        }
        
        if (resData?.get_detail?[0].longi ?? "0.0") != "" {
            self.currLong = Double(resData?.get_detail?[0].longi ?? "0.0")!
        }
        
        
        self.lblAdrs.text = resData?.get_detail?[0].mapLocation ?? ""
        marker = GMSMarker()
        btnCurrentLocation.layer.masksToBounds = false
        btnCurrentLocation.layer.cornerRadius = self.btnCurrentLocation.frame.width / 2
        self.navigationController?.navigationBar.isHidden = true
        if AppConstant.currLatitude == 0.0 {
            self.getLocation()
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    self.forceFullyLocationGrap()
                case .authorizedAlways, .authorizedWhenInUse:
                    self.getLocation()
                }
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
    }
    
    
    func forceFullyLocationGrap() {
        let alertController = UIAlertController(title:  "\(AppInfo.kAppName)", message: "Allow \(AppInfo.kAppName) to access your current location otherwise you are not abel to update address", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: NSLocalizedString("Settings", comment: ""), style: .default) { (UIAlertAction) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)! as URL, options: [:], completionHandler: nil)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func setMap(showPin: Bool, mapMode: String) {
        var camera = GMSCameraPosition.camera(withLatitude: self.currLat,
                                              longitude: self.currLong, zoom: 16)
        if mapMode == "normal" {
            mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.viewMap.bounds.height) , camera: camera)
        }else {
            camera = GMSCameraPosition.camera(withLatitude: self.currLat,
                                              longitude: self.currLong, zoom: 18)
            mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.viewMap.bounds.height) , camera: camera)
        }
        //mapView.isMyLocationEnabled = true
        mapView.delegate = self
        if mapMode == "normal" {
            mapView.isMyLocationEnabled = false
            mapView.mapType = .normal
        }else {
            mapView.isMyLocationEnabled = false
            mapView.mapType = .hybrid
        }
        
        for sbView in viewMap.subviews {
            if sbView == mapView {
                sbView.removeFromSuperview()
            }
        }
        self.viewMap.addSubview(mapView)
        marker.position = CLLocationCoordinate2D(latitude: self.currLat, longitude: self.currLong)
        marker.map = mapView
        if showPin {
            marker.iconView = self.viewMarkerIcon
            mapView.selectedMarker = marker
        }else {
            marker.iconView = UIView()
        }
        
        mapView.isIndoorEnabled = true
        mapView.settings.indoorPicker = true
        
    }
    
    
    
    func getCurrentAddress(at coordinate: CLLocationCoordinate2D) {
        let geoCoder = GMSGeocoder()
        geoCoder.reverseGeocodeCoordinate(coordinate) { (response, error) in
            if error == nil {
                if let address = response?.firstResult() {
                    let line = address.lines
                    let address = line?.joined(separator: ",")
                    self.lblAdrs.text = address ?? "No location found"
                }
            } else {
                print("Geocoder error:- \(error!.localizedDescription)")
            }
        }
    }
    
    
    class func instance() -> MapLocationViewController? {
        return UIStoryboard(name: "MapLocation", bundle: nil).instantiateViewController(withIdentifier: "MapLocationViewController") as? MapLocationViewController
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func btnCurrentLocationTapped(_ sender: UIButton) {
        self.currLat = AppConstant.currLatitude
        self.currLong = AppConstant.currLongitude
        self.setMap(showPin: true, mapMode: "normal")
        
    }
    
    
    @IBAction func btnChangeLocationAction(_ sender: Any) {
        if let VC = ChangeAddressViewController.instance() {
            var temp = self.resData
            var uDetail = temp?.get_detail?[0]
            uDetail?.mapLocation = self.lblAdrs.text ?? ""
            temp?.get_detail?[0] = uDetail!
            self.resData = temp
            VC.resData = self.resData
            VC.lat = "\(self.currLat)"
            VC.long = "\(self.currLong)"
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func btnSearchLocation(_ sender: Any) {
        if let VC = SearchLocationViewController.instance() {
            VC.searchLocationDelegate = self
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}



extension MapLocationViewController: MapLocationDisplayLogic {
    func displaySomething(viewModel: MapLocation.Something.ViewModel) {
        print("")
    }
    
    
}


extension MapLocationViewController:  GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        print("\(position.target.latitude) \(position.target.longitude)")
        marker.position = position.target
        self.searchLat = position.target.latitude
        self.searchLong = position.target.longitude
        self.getCurrentAddress(at: CLLocationCoordinate2D(latitude: self.searchLat, longitude: self.searchLong))
    }
    
    
}


extension MapLocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.currLat = (locValue.latitude)
        self.currLong = (locValue.longitude)
        AppConstant.currLongitude = (locValue.longitude)
        AppConstant.currLatitude = (locValue.latitude)
        
        //self.setMap(showPin: false, mapMode: "normal")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .notDetermined) || (status == .restricted) || (status == .denied) {
            forceFullyLocationGrap()
        }else if (status == .authorizedAlways) || (status == .authorizedWhenInUse) {
            
        }
    }
}

extension MapLocationViewController: SearchLocation {
    func getData(heading: String, title: String, lat: Double, long: Double) {
        self.navigationController?.popViewController(animated: true)
        self.lblAdrs.text = title
        self.lblTitle.text = heading
        self.currLat = lat
        self.currLong = long
        self.setMap(showPin: true, mapMode: "normal")
    }
    
    
}
