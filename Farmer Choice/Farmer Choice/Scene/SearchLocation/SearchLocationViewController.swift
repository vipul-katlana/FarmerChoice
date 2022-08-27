

import UIKit
import GooglePlaces
import IQKeyboardManagerSwift

class SearchLocationViewController: BaseViewController {
    
    @IBOutlet  weak var searchBar : UISearchBar!
    @IBOutlet weak var tblView : UITableView!
    
    var tableData = [GMSAutocompletePrediction]()
    var fetcher: GMSAutocompleteFetcher?
    var completion:((GMSAutocompletePrediction?, Error?) -> Void)!
    
    var searchLocationDelegate: SearchLocation?
    var searchLat = 0.0
    var searchLong = 0.0
    var searchArea = ""
    var searchLocation = ""
    var zipCode = ""
    
    
    class func instance() -> SearchLocationViewController? {
        return UIStoryboard(name: "SearchLocation", bundle: nil).instantiateViewController(withIdentifier: "SearchLocationViewController") as? SearchLocationViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSPlacesClient.provideAPIKey(AppInfo.googlKey)
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        filter.country = "IN"
        fetcher = GMSAutocompleteFetcher()
        fetcher?.autocompleteFilter = filter
        fetcher?.delegate = self
        
    }
    
    func setSearchDetailsAddress(addressComponent: [GMSAddressComponent]) {
        for address in addressComponent {
            var addressStr = "\(address)"
            addressStr = addressStr.replacingOccurrences(of: "Types:", with: "")
            let addressArr = addressStr.components(separatedBy: ":")
            
            if addressStr.contains("street_number, Name") {
                if addressArr.count > 0 {
                    if self.searchArea == "" {
                        self.searchArea = (addressArr.last ?? "")
                    }else {
                        self.searchArea = self.searchArea + "," + (addressArr.last ?? "")
                    }
                }
            }
            
            if addressStr.contains("route, Name") {
                if addressArr.count > 0 {
                    self.searchLocation = addressArr.last ?? ""
                }
            }
            
            if addressStr.contains("locality, political, Name") {
                if addressArr.count > 0 {
                    if self.searchArea == "" {
                        self.searchArea = (addressArr.last ?? "")
                    }else {
                        self.searchArea = self.searchArea + "," + (addressArr.last ?? "")
                    }
                }
            }
            
            if addressStr.contains("postal_code") &&  !addressStr.contains("postal_code_suffix") {
                if addressArr.count > 0 {
                    self.zipCode = addressArr.last ?? ""
                }
            }
        }
        print("Location: \(self.searchLocation)")
        print("Area: \(self.searchArea)")
        print("ZipCode: \(self.zipCode)")
        
        
    }
    
    
    @IBAction func btnBcakAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}


extension SearchLocationViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell
        aCell?.lblHeading.text = tableData[indexPath.row].attributedPrimaryText.string
        aCell?.lblAdrs.text = tableData[indexPath.row].attributedSecondaryText?.string
        return aCell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeClient = GMSPlacesClient.shared()
        placeClient.lookUpPlaceID(tableData[indexPath.row].placeID) { (place, error) in
            if error == nil {
                self.searchLat = place?.coordinate.latitude ?? 0.0
                self.searchLong = place?.coordinate.longitude ?? 0.0
                self.searchArea = (place?.formattedAddress) ?? ""
                self.searchLocation = (place?.name) ?? ""
                
                self.searchLocationDelegate?.getData(heading: self.searchLocation, title: self.searchArea, lat: self.searchLat, long: self.searchLong)
                
//                self.setSearchDetailsAddress(addressComponent: ((place?.addressComponents)!))
//
                
            }else {
                print(error)
            }
        }
    }
    
}

extension SearchLocationViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //self.searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //self.searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if self.internetAvailable() {
            fetcher?.sourceTextHasChanged(searchBar.text!)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
}

extension SearchLocationViewController : GMSAutocompleteFetcherDelegate {
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        tableData.removeAll()
        for prediction in predictions {
            tableData.append(prediction)
        }
        tblView.reloadData()
        
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        //completion(nil,error)
        print(error)
        //dismiss(animated: true, completion: nil)
    }
}
