
import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet weak var clctnView: UICollectionView!
    @IBOutlet weak var btnPreview: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var currIndex = 0
    
    let resultList : NSArray = [["title":"Sourced From Farms Twice a Day","desc":"We pick produce from local farms harvested just 6hrs ago","image":"image-1.png"],["title":"Instant Delivery For Your Instant Needs","desc":"Everything delivered to your doorstep within 30-45mins","image":"image-2.png"],["title":"Genuine Prices. Unmatched Quality","desc":"No discount gimmicks. Quality products that you can trust upon.","image":"image-3.png"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnPreview.isHidden = true
        UserDefaultsManager.appLaunshFirst(launch: "1")
        
        self.btnPreview.layer.borderColor = #colorLiteral(red: 0.1647058824, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        self.btnPreview.layer.borderWidth = 1
        
        UserDefaultsManager.intoAdd(id: "1")
    }
    
    class func instance() -> IntroViewController? {
        return UIStoryboard(name: "Intro", bundle: nil).instantiateViewController(withIdentifier: "IntroViewController") as? IntroViewController
    }
    
    func redirection() {
        //        let user = UserDefaultsManager.getLoggedUserDetails()
        //        if user?.userId != ""  && user?.userId != nil {
        //            AppConstant.appDelegate.setRootViewController()
        //        }else {
        //            if let VC = AuthenticationViewController.instance() {
        //                self.navigationController?.pushViewController(VC, animated: true)
        //            }
        //        }
        //
        
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
    
    @IBAction func btnPreviewAction(_ sender: Any) {
        if currIndex >= 0 {
            self.btnNext.isHidden = false
            currIndex -= 1
            
            self.clctnView.isPagingEnabled = false
            self.clctnView.scrollToItem(at: IndexPath(item: self.currIndex, section: 0), at: .left, animated: true)
            self.clctnView.isPagingEnabled = true
            
            if currIndex == 0 {
                self.btnPreview.isHidden = true
            }else {
                self.btnPreview.isHidden = false
            }
        }
        
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        if currIndex < 2 {
            self.btnPreview.isHidden = false
            currIndex += 1
            // self.clctnView.scrollToItem(at: IndexPath(item: self.currIndex, section: 0), at: .right, animated: true)
            
            self.clctnView.isPagingEnabled = false
            self.clctnView.scrollToItem(at: IndexPath(item: self.currIndex, section: 0), at: .right, animated: true)
            self.clctnView.isPagingEnabled = true
            
            if currIndex == 2 {
                self.btnNext.setTitle("DONE", for: .normal)
            }else {
                self.btnNext.setTitle("NEXT", for: .normal)
            }
        }else {
            redirection()
        }
    }
    
    
}

extension IntroViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroCollectionViewCell", for: indexPath) as! IntroCollectionViewCell
        cell.lblTitle.text = (resultList[indexPath.row] as? NSDictionary)?.object(forKey: "title") as? String ?? ""
        cell.lblDesc.text =  (resultList[indexPath.row] as? NSDictionary)?.object(forKey: "desc") as? String ?? ""
        cell.imgLogo.image = UIImage(named: (resultList[indexPath.row] as? NSDictionary)?.object(forKey: "image") as? String ?? "")
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currIndex = indexPath.row
        
        if currIndex == 0 {
            self.btnPreview.isHidden = true
        }else {
            self.btnPreview.isHidden = false
        }
        
        if currIndex == 2 {
            self.btnNext.setTitle("DONE", for: .normal)
        }else {
            self.btnNext.setTitle("NEXT", for: .normal)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}
