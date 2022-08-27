
import UIKit

class SelectAreaListViewController: UIViewController {
    
    @IBOutlet weak var tblHeigth: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    
    var cityData : AvailableCity?
    var selectDele: SelctArearList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tblHeigth.constant = CGFloat(((cityData?.User_data?.city_list?.count ?? 0) * 120))
        
        
        if (UIScreen.main.bounds.height - 180.0) < CGFloat((cityData?.User_data?.city_list?.count ?? 0) * 80) {
            self.tblHeigth.constant = (UIScreen.main.bounds.height - 180.0)
        }else {
            self.tblHeigth.constant = CGFloat((cityData?.User_data?.city_list?.count ?? 0) * 80)
        }
        
    }
    
    
    class func instance() -> SelectAreaListViewController? {
        return UIStoryboard(name: "SelectCity", bundle: nil).instantiateViewController(withIdentifier: "SelectAreaListViewController") as? SelectAreaListViewController
    }
    
    @IBAction func btnDismissActipon(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
}

extension SelectAreaListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityData?.User_data?.city_list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectAreaListTableViewCell", for: indexPath) as! SelectAreaListTableViewCell
        cell.lblArea.text =  (cityData?.User_data?.city_list?[indexPath.row].name ?? "")
        //cell.vwBG.setShadow()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectDele?.area(id: (cityData?.User_data?.city_list?[indexPath.row].cityID ?? ""), area: (cityData?.User_data?.city_list?[indexPath.row].name ?? ""))
    }
    
}
