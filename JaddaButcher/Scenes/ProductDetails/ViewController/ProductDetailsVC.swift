//
//  ProductDetailsVC.swift
//  JaddaButcher
//
//  Created by Elattar on 1/13/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import UIKit
import UITextView_Placeholder
import SDWebImage
import SVProgressHUD

class ProductDetailsVC: UIViewController {
    
    @IBOutlet weak var product_iv: UIImageView!
    @IBOutlet weak var productName_lbl: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var productPrice_lbl: UILabel!
    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var plus_btn: UIButton!
    @IBOutlet weak var counter_lbl: UILabel!
    @IBOutlet weak var min_btn: UIButton!
    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var note_tv: UITextView!
    @IBOutlet weak var addToCart_btn: UIButton!
    @IBOutlet weak var buyNow_btn: UIButton!
    
    var adjCount: Int = 10
    
    var prdouctID: Int = 0
    var productImage: String = ""
    var productName: String = ""
    var productPrice: String = ""
    var categoryID: String = ""
    var totalPrice: Double = 0.0
    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setData()
    }
    
    private func setupView(){
        
        product_iv.layer.cornerRadius = 12
        product_iv.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        product_iv.layer.masksToBounds = true
        
        productName_lbl.layer.cornerRadius = 12
        productName_lbl.layer.masksToBounds = true
        
        productName_lbl.layer.maskedCorners = [.layerMaxXMaxYCorner  , .layerMinXMaxYCorner]
        
        priceView.layer.cornerRadius = 12
        plus_btn.layer.cornerRadius = 8
        min_btn.layer.cornerRadius = 8
        
        
        counterView.layer.cornerRadius = 12
        counterView.backgroundColor = .ThiredColor
        counterView.layer.borderWidth = 1
        counterView.layer.borderColor = UIColor.MainColor.cgColor
        
        notesView.layer.cornerRadius = 12
        notesView.layer.borderWidth = 1
        notesView.layer.borderColor = UIColor.MainColor.cgColor
        note_tv.placeholder = "ملاحظات"
        
        addToCart_btn.layer.cornerRadius = 12
        buyNow_btn.layer.cornerRadius = 12
        buyNow_btn.layer.borderWidth = 1
        buyNow_btn.layer.borderColor = UIColor.MainColor .cgColor
        
    }
    
    private func setData(){
        
     //   let imgName = self.productImage.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let imgName = self.productImage

        product_iv.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        product_iv.sd_setImage(with: URL(string: imgName), placeholderImage: UIImage(named: "logo"))
        self.productName_lbl.text = productName
        
        let productPriceDouble = Double(productPrice)
        self.productPrice_lbl.text = "\((productPriceDouble ?? 0.0) * 10) ريال"
        
    }
    
    
    private func addToCartHashi(productId: String,quantity: String,  price: String,sessionCode: String, note: String,type: String,category_id: String){
        SVProgressHUD.show()
        APIManagerAddToCart.addToCart(productId: productId, size: "1", quantity: quantity, price: price, sessionCode: sessionCode, note: note, kersh: "", soup_kilos: "", minced_kilos: "", type: type, pay_method: "", minced: "", category_id: category_id, head: "", meat_package: "", parts: "") { (err, sucess) in
            SVProgressHUD.dismiss()
            if let err = err {
                print(err)
            }else if let success = sucess{
                if success.status == 200 {
                    print(success.message ?? "")
                    ToastManager.shared.showToast(message: "تم الاضافة الي السلة بنجاح", view: self.view, postion: .top, backgroundColor: .systemGreen)
                }else{
                    print("Failer: \(success.errors?.first ?? "")")
                    ToastManager.shared.showToast(message: "يوجد خطا برجاء المحاوله مره ثانية", view: self.view, postion: .top, backgroundColor: .systemRed)
                }
            }
        }
    }
    
    

    @IBAction func adjCounter_btn(_ sender: Any) {
        let tag: Int = (sender as AnyObject).tag
        if tag == 0{
            
            if adjCount >= 1 {
                adjCount = adjCount + 1
            }
        }else{
            
            if adjCount > 10 {
                adjCount = adjCount - 1
            }
        }
        
        
        counter_lbl.text = String(adjCount)
        let priceDouble =  Double(productPrice)
        
        let total = (priceDouble ?? 0.0) * Double(adjCount)
        
        self.productPrice_lbl.text = "\(total) ريال"
        self.totalPrice = total
    }
    
    
    
    @IBAction func back_btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func whatsapp_btn(_ sender: Any) {
        print("Wahtsapp")
        self.openwhatsapp(phone: "+9660544298982")

    }
    
    
    @IBAction func addToCart_btn(_ sender: Any) {
       var getSessionCode: String = ""
        if Helper.getToken() == nil {
        }else {
            getSessionCode = Helper.getToken()!
        }
        
        addToCartHashi(productId: "\(prdouctID)", quantity: "\(adjCount)", price: productPrice, sessionCode: getSessionCode, note: note_tv.text, type: "0", category_id: categoryID)
        
        print("Total Price: \(productPrice)")
    }
    
    
    @IBAction func buyNow_btn(_ sender: Any) {
        print("Buy Now")
        let popScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderCompletionVC") as! OrderCompletionVC
        popScreen.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        dimmingCheckout.alpha = 1
        dimmingCheckout.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        //   dimmingOrderView.alpha = 0.0
        dimmingCheckout.frame = self.view.frame
        self.view.addSubview(dimmingCheckout)
        //  dimmingOrderView.alpha = 1
        popScreen.type = "1"
        popScreen.product_id = prdouctID
        popScreen.quantity = "\(adjCount)"
        popScreen.price = productPrice
        popScreen.notes = note_tv.text
        popScreen.category_id = categoryID
        self.present(popScreen, animated: true, completion: nil)
    }
    
}


//MARK:- UIViewControllerTransitioningDelegate

extension ProductDetailsVC : UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }
}
