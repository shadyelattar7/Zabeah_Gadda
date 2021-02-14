//
//  Extenions.swift
//  City Butcher
//
//  Created by Elattar on 12/1/20.
//  Copyright © 2020 Elattar. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


extension UIViewController{
    func hideShadowNav(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setBackbtn(){
        let image = "back_btn"
        
        navigationItem.hidesBackButton = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: image)!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleBackBtn))
    }
    
    @objc func handleBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    
     func addLeftBarIcon(named:String) {
         let logoImage = UIImage.init(named: named)
         let logoImageView = UIImageView.init(image: logoImage)
         logoImageView.frame = CGRect(x:0.0,y:0.0, width:60,height:25.0)
         logoImageView.contentMode = .scaleAspectFit
         let imageItem = UIBarButtonItem.init(customView: logoImageView)
         let widthConstraint = logoImageView.widthAnchor.constraint(equalToConstant: 60)
         let heightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: 25)
         heightConstraint.isActive = true
         widthConstraint.isActive = true
         navigationItem.leftBarButtonItem =  imageItem
     }
    
    func openwhatsapp(phone: String) {
         let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(phone)")
         if UIApplication.shared.canOpenURL(whatsappURL!) {
             UIApplication.shared.open(whatsappURL!, options: [:])
         }
     }

}



extension UITextField{
    
    enum Direction {
        case left
        case right
    }
    
    // add image to textfield
    func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor) {
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 35))
        mainView.layer.cornerRadius = 5
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 35))
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = CGFloat(0.5)
        view.layer.borderColor = colorBorder.cgColor
        mainView.addSubview(view)
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 12.0, y: 5, width: 24.0, height: 24.0)
        view.addSubview(imageView)
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = colorSeparator
        mainView.addSubview(seperatorView)
        
        if Direction.left == direction { // image left
            seperatorView.frame = CGRect(x: 0, y: 0, width: 1, height: 35)
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
            seperatorView.frame = CGRect(x: 45, y: 0, width: 1, height: 35)
            self.rightViewMode = .always
            self.rightView = mainView
        }
        
        self.layer.borderColor = colorBorder.cgColor
        self.layer.borderWidth = CGFloat(1)
        self.layer.cornerRadius = 5
    }
    
    // Handle The Wrong Input Password Case
    func handleInvalidCasefor(message: String) {
        self.shake()
        self.text = ""
        self.attributedPlaceholder = NSAttributedString(
            string: message, attributes: [.foregroundColor: #colorLiteral(red: 1, green: 0.3529411765, blue: 0.2509803922, alpha: 1),
                                          .font: UIFont.boldSystemFont(ofSize: 16.0)]
        )
    }
    
    // shake animation for the view
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.4
        animation.values = [-15.0, 15.0, -15.0, 15.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    
    func singleLine(lineColor: UIColor, lineHeight: CGFloat){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 2, width: self.frame.size.width, height: lineHeight)
        bottomLine.backgroundColor = lineColor.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
    
    
}

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


extension UIView{
    
    func anchor(top: NSLayoutYAxisAnchor?,left: NSLayoutXAxisAnchor?,right: NSLayoutXAxisAnchor?,bottom: NSLayoutYAxisAnchor?, paddingTop: CGFloat,paddingLeft: CGFloat, paddingRight: CGFloat, paddingBottom: CGFloat, width: CGFloat, height: CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if  width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if  height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
    
    
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }
    
    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    func animate(mainColor: UIColor, subColor:UIColor, duration: CFTimeInterval) {
        let layer = CAGradientLayer()
        let startLocations = [0, 0]
        let endLocations = [1, 2]
        
        layer.colors = [mainColor.cgColor, subColor.cgColor]
        layer.frame = self.bounds
        layer.locations = startLocations as [NSNumber]
        layer.startPoint = CGPoint(x: 0.0, y: 1.0)
        layer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.layer.addSublayer(layer)
        
        let anim = CABasicAnimation(keyPath: "locations")
        anim.fromValue = startLocations
        anim.toValue = endLocations
        anim.duration = duration
        layer.add(anim, forKey: "loc")
        layer.locations = endLocations as [NSNumber]
    }
    
}


extension UIViewController {
    
    func showAlart(title: String,message: String,okTitle: String = "OK" , okHandler: ((UIAlertAction) -> Void)? = nil){
        
        let alart = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alart.addAction(UIAlertAction(title: okTitle, style: .cancel, handler: okHandler))
        
        self.present(alart, animated: true, completion: nil)
    }
}

extension String{
    var isBlank: Bool{
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    
    var localized: String{
        return NSLocalizedString(self, comment: "")
    }
}


extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

class DateFormat{
    static func dateFormat(dateEx: String,dateFormat: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = dateFormat   //"yyyy-MM-dd'T'HH:mm:ss"
        //"yyyy-MM-dd'T'HH:mm:ss.SSS"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM-dd-yyyy"
        
        if let date = dateFormatterGet.date(from: dateEx) {
            //  print(dateFormatterPrint.string(from: date))
            return dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string (Date)")
        }
        return "N/A"
    }
}


//MARK:- badge Navgation bar icon
extension CAShapeLayer {
    func drawRoundedRect(rect: CGRect, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        path = UIBezierPath(roundedRect: rect, cornerRadius: 7).cgPath
    }
}

private var handle: UInt8 = 0;

extension UIBarButtonItem {
    private var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    func setBadge(text: String?, withOffsetFromTopRight offset: CGPoint = CGPoint.zero, andColor color:UIColor = UIColor.red, andFilled filled: Bool = true, andFontSize fontSize: CGFloat = 11)
    {
        badgeLayer?.removeFromSuperlayer()
        
        if (text == nil || text == "") {
            return
        }
        
        addBadge(text: text!, withOffset: offset, andColor: color, andFilled: filled)
    }
    
    private func addBadge(text: String, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true, andFontSize fontSize: CGFloat = 11)
    {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        var font = UIFont.systemFont(ofSize: fontSize)
        
        if #available(iOS 9.0, *) { font = UIFont.monospacedDigitSystemFont(ofSize: fontSize, weight: UIFont.Weight.regular) }
        let badgeSize = text.size(withAttributes: [NSAttributedString.Key.font: font])
        
        // Initialize Badge
        let badge = CAShapeLayer()
        
        let height = badgeSize.height;
        var width = badgeSize.width + 2 /* padding */
        
        //make sure we have at least a circle
        if (width < height) {
            width = height
        }
        
        //x position is offset from right-hand side
        let x = view.frame.width - width + offset.x
        
        let badgeFrame = CGRect(origin: CGPoint(x: x, y: offset.y), size: CGSize(width: width, height: height))
        
        badge.drawRoundedRect(rect: badgeFrame, andColor: color, filled: filled)
        view.layer.addSublayer(badge)
        
        // Initialiaze Badge's label
        let label = CATextLayer()
        label.string = text
        label.alignmentMode = CATextLayerAlignmentMode.center
        label.font = font
        label.fontSize = font.pointSize
        
        label.frame = badgeFrame
        label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)
        
        // Save Badge as UIBarButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    private func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
    
}

extension UINavigationController{
    
 
    
}
