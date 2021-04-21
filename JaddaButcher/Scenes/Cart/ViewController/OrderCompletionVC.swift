//
//  OrderCompletionVC.swift
//  City Butcher
//
//  Created by Elattar on 12/7/20.
//  Copyright © 2020 Elattar. All rights reserved.
//

import UIKit
import BEMCheckBox
import CoreLocation
import SVProgressHUD


class OrderCompletionVC: UIViewController, BEMCheckBoxDelegate {
    
    @IBOutlet weak var viewX: UIView!
    @IBOutlet weak var name_tf: UITextField!
    @IBOutlet weak var address_tf: UITextField!
    @IBOutlet weak var phoneNum_tf: UITextField!
    @IBOutlet weak var paidWayCash: BEMCheckBox!
    @IBOutlet weak var paidWayVisa: BEMCheckBox!
    @IBOutlet weak var orderConfCall: BEMCheckBox!
    @IBOutlet weak var orderConfWhatsapp: BEMCheckBox!
    @IBOutlet weak var checkout_btn: UIButton!
    
    
    var checkout: Checkout?
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    var paidWayType: String = "عند الاستلام"
    var orderConfType: String = "اتصال"
    var address: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    
    
    var product_id: Int = 0
    var size: String = ""
    var quantity: String = ""
    var price: String = ""
    var session_code: String = ""
    var notes: String = ""
    var kersh: String = ""
    var soup_kilos: String = ""
    var minced_kilos: String = ""
    var minced: String = ""
    var category_id: String = ""
    var head: String = ""
    var meat_package: String = ""
    var parts: String = ""
    var type: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupView(){
        viewX.layer.cornerRadius = 30
        viewX.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        checkout_btn.layer.cornerRadius = 8
        
        let grayColor = UIColor.hexStringToUIColor(hex: "#ABABAB")
        name_tf.singleLine(lineColor: grayColor, lineHeight: 1)
        address_tf.singleLine(lineColor: grayColor, lineHeight: 1)
        phoneNum_tf.singleLine(lineColor: grayColor, lineHeight: 1)
        
        address_tf.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        
        paidWayCash.delegate = self
        paidWayVisa.delegate = self
        orderConfCall.delegate = self
        orderConfWhatsapp.delegate = self
        
        paidWayCash.setOn(true, animated: true)
        orderConfCall.setOn(true, animated: true)
        showAnimate()
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        downSwipe.direction = .down
        self.view.addGestureRecognizer(downSwipe)
        
    }
    
    @objc func myTargetFunction(textField: UITextField) {
        print("myTargetFunction")
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapVC") as! MapVC
        sb.delegate = self
        //navigationController?.pushViewController(sb, animated: true)
        present(sb, animated: true, completion: nil)
        
    }
    
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
        //        let name = Notification.Name(dismissView)
        //        NotificationCenter.default.post(name: name, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.5, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        
        if checkBox.tag == 0 {
            paidWayCash.setOn(true, animated: true)
            paidWayVisa.setOn(false, animated: true)
            paidWayType = "عندالاستلام"
        }else if checkBox.tag == 1 {
            paidWayVisa.setOn(true, animated: true)
            paidWayCash.setOn(false, animated: true)
            paidWayType = "بطاقة بنكية"
        }
        
        if checkBox.tag == 2 {
            orderConfCall.setOn(true, animated: true)
            orderConfWhatsapp.setOn(false, animated: true)
            orderConfType = "اتصال"
        }else if checkBox.tag == 3 {
            orderConfWhatsapp.setOn(true, animated: true)
            orderConfCall.setOn(false, animated: true)
            orderConfType = "واتساب"
        }
        
    }
    
    
    func addOrder(){
        let popScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SuccessfullyOrderVC") as! SuccessfullyOrderVC
        
        self.addChild(popScreen)
        popScreen.view.frame = self.view.frame
        self.view.addSubview(popScreen.view)
        popScreen.didMove(toParent: self)
        
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String)   {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    //                    print(pm.country)
                    //                    print(pm.locality)
                    //                    print(pm.subLocality)
                    //                    print(pm.thoroughfare)
                    //                    print(pm.postalCode)
                    //                    print(pm.subThoroughfare)
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    print(addressString)
                    self.address_tf.text = addressString
                    self.address = addressString
                }
        })
    }
    
    
    func checkout(session_code: String,_name :String, _phone: String, _address: String, postal_code: String, _pay_method: String,_deliverTime: String){
        
        let name = _name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let phone = _phone.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let pay_method = _pay_method.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let deliver_timeX = _deliverTime.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        print("DeliverTime \(deliver_timeX)")
        let _address = address.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        SVProgressHUD.show()
        ApiManagerCheckout.checkout(session_code: session_code, name: name, phone: phone, address: _address, postal_code: postal_code, pay_method: pay_method, deliver_time: deliver_timeX) { (err, sucess) in
            SVProgressHUD.dismiss()
            if let err = err {
                print("Error CheckOut, \(err)")
            }else if let message = sucess {
                print("Successfully checkout")
                let def = UserDefaults.standard
                def.removeObject(forKey: UDKey.cartCount)
                self.checkout = message
                self.addOrder()
            }
        }
        
    }
    
    
    @IBAction func dismissCard_btn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        dimmingCheckout.alpha = 0.0
        
    }
    @IBAction func onClickGesture(_ sender: Any) {
        let touchPoint = (sender as AnyObject).location(in: self.view?.window)
        
        if (sender as AnyObject).state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if (sender as AnyObject).state == UIGestureRecognizer.State.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if (sender as AnyObject).state == UIGestureRecognizer.State.ended || (sender as AnyObject).state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                //  let name = Notification.Name(dismissView)
                //  NotificationCenter.default.post(name: name, object: nil)
                dismiss(animated: true, completion: nil )
                dimmingCheckout.alpha = 0.0
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
        
    }
    
    
    private func addToCart(productId: String,size: String,quantity: String,  price: String,sessionCode: String, note: String,type: String,category_id: String,kersh: String,soup_kilos: String,minced_kilos: String,minced: String,head:String, meat_package: String,parts: String){
        SVProgressHUD.show()
        APIManagerAddToCart.addToCart(productId: productId, size: size, quantity: quantity, price: price, sessionCode: sessionCode, note: note, kersh: kersh, soup_kilos: soup_kilos, minced_kilos: minced_kilos, type: type, pay_method: "", minced: minced, category_id: category_id, head: head, meat_package: meat_package, parts: parts) { (err, sucess) in
            SVProgressHUD.dismiss()
            if let err = err {
                print(err)
            }else if let success = sucess{
                if success.status == 200 {
                    print(success.message ?? "")
                    //                      ToastManager.shared.showToast(message: "تم الطلب بنجاح", view: self.view, postion: .top, backgroundColor: .systemGreen)
                    
                    var getSessionCode: String = ""
                    if Helper.getToken() == nil {
                    }else {
                        getSessionCode = Helper.getToken()!
                    }
                    
                    let name = self.name_tf.text!
                    let phone = self.phoneNum_tf.text!
                    
                    self.checkout(session_code:getSessionCode , _name: name, _phone: phone, _address: self.address, postal_code: "999", _pay_method: self.paidWayType, _deliverTime: "صباحا")
                    
                }else{
                    print("Failer: \(success.errors?.first ?? "")")
                    ToastManager.shared.showToast(message: "يوجد خطا برجاء المحاوله مره ثانية", view: self.view, postion: .top, backgroundColor: .systemRed)
                }
            }
        }
    }
    
    private func validateTextField(){
        let isFormVaild = !name_tf.text!.isEmpty && !phoneNum_tf.text!.isEmpty && !address.isEmpty
        
        if isFormVaild{
            var getSessionCode: String = ""
            if Helper.getToken() == nil {
            }else {
                getSessionCode = Helper.getToken()!
            }
            
            let name = name_tf.text!
            let phone = phoneNum_tf.text!
            
            if type == "0" {
                checkout(session_code:getSessionCode , _name: name, _phone: phone, _address: address, postal_code: "999", _pay_method: paidWayType, _deliverTime: "صباحا")
            }else{
                addToCart(productId: "\(product_id)", size: size, quantity: quantity, price:price, sessionCode: getSessionCode, note: notes, type: "1", category_id: category_id, kersh: kersh, soup_kilos: soup_kilos, minced_kilos: minced_kilos, minced: minced, head: head, meat_package: meat_package, parts: parts)
            }
            
            
        }else{
            name_tf.shake()
            name_tf.handleInvalidCasefor(message: "برجاء ادخال الاسم")
            name_tf.singleLine(lineColor: .systemRed, lineHeight: 1)
            
            phoneNum_tf.shake()
            phoneNum_tf.handleInvalidCasefor(message: "برجاء ادخال رقم الجوال")
            phoneNum_tf.singleLine(lineColor: .systemRed, lineHeight: 1)
            
            address_tf.shake()
            address_tf.handleInvalidCasefor(message: "برجاء ادخال العنوان")
            address_tf.singleLine(lineColor: .systemRed, lineHeight: 1)
        }
    }
    
    
    @IBAction func checkout_btn(_ sender: Any) {
        print("PayWayType: \(paidWayType)")
        print("OrderConfType: \(orderConfType)")
        print("Address: \(address)")
        validateTextField()
    }
    
}


extension OrderCompletionVC: coordinateLocation{
    func userLocation(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        
        let lan = "\(latitude)"
        let long = "\(longitude)"
        
        getAddressFromLatLon(pdblLatitude: lan, withLongitude: long)
        
        print("Iam in Order Completion \(latitude), \(longitude)")
    }
    
    
}
