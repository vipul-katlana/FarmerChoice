

import UIKit

class ChangeCategoryViewController: UIViewController {
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    var data = [ProductList.Cate_list]()
    var catDelegate: CategoryChange?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CGFloat((((52)*data.count) + 60)) > UIScreen.main.bounds.height - 200 {
            self.viewHeight.constant = UIScreen.main.bounds.height - 200
        }else {
            self.viewHeight.constant = CGFloat((((52)*data.count) + 60))
        }
        
    }
    
    
    class func instance() -> ChangeCategoryViewController? {
        return UIStoryboard(name: "WishList", bundle: nil).instantiateViewController(withIdentifier: "ChangeCategoryViewController") as? ChangeCategoryViewController
    }
    
    
    @IBAction func btnDismissAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}

extension ChangeCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeCategoryTableViewCell", for: indexPath) as! ChangeCategoryTableViewCell
        cell.lblTtle.text = data[indexPath.row].name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        catDelegate?.change(id: data[indexPath.row].catID ?? "")
        self.dismiss(animated: false, completion: nil)
    }
    
}
