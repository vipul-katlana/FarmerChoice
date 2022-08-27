
import Foundation
import UIKit

extension UIView {
    
    func setRoundCorner(radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setCornerRadiusAndShadow(cornerRe: CGFloat) {
        self.layer.cornerRadius = cornerRe
        self.setShadow()
    }
    
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 2
    }
    
    func addShadow(ofColor color: UIColor = UIColor.black, radius: CGFloat = 10, offset: CGSize = .zero, opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    func addLoginButtonShadowAndCornerRadius() {
        self.layer.cornerRadius = 22.5
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = #colorLiteral(red: 0.4666666667, green: 0.08235294118, blue: 0.04705882353, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
    
    func addSocialButtonAppShadowAndCornerRadius() {
        self.layer.cornerRadius = 35
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false
    }
    
    func setBorder() {
        self.layer.borderColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5
    }
    
    func setBorderWithColor(color: UIColor, width: CGFloat = 1.0) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func setRoundBorder(radius:CGFloat, color:UIColor = UIColor.clear, size:CGFloat = 1) {
        self.setRoundCorner(radius: radius)
        self.setBorder()
    }
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat,bounds:CGRect = CGRect.zero) {
        let aApplyBound = bounds == CGRect.zero ? self.bounds : bounds
        let path = UIBezierPath(roundedRect:aApplyBound, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    
    func addCircularShadow(_ radius:CGFloat) {
        let aRect = CGRect(x: 0, y: -2, width: frame.size.width + 2, height: frame.size.height + 2)
        let shadowPath = UIBezierPath(roundedRect: aRect , cornerRadius: radius)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 0.5
        layer.shadowPath = shadowPath.cgPath
        layer.shadowRadius = 1.0
    }
    
    
    
    func addViewShadow(ofColor color: UIColor = UIColor.black, radius: CGFloat = 5, offset: CGSize = .zero, opacity: Float = 0.1) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}

extension UIButton {
    func changeColor(color: UIColor, image: String) {
        let origImage = UIImage(named: "\(image)")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }
}
