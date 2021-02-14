//
//  CartVC.swift
//  City Butcher
//
//  Created by Elattar on 12/6/20.
//  Copyright © 2020 Elattar. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

let dimmingCheckout = UIView()

class CartVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var orderCompletion: UIButton!
    @IBOutlet weak var cartEmpty_iv: UIImageView!
    @IBOutlet weak var totalPrice_lbl: UIView!
    @IBOutlet weak var totalPrice_lb: UILabel!
    
    
    
    
    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    
    
    let cartCharityIdentfier = "CartCharityCell"
    let cartOtherCellIndentfier = "CartOtherCell"
    
    var cart: [Cart] = []
    var updateQuantity: UpdateQuantityInCart?
    
    
    let item = ["Car","Track","Motor"]
    let subItem = ["KIA","Marcedes","BMW"]
    
    
    let productImg = [
        UIImage(named: "demo11")!,
        UIImage(named: "camel")!,
        UIImage(named: "demo11")!,
        UIImage(named: "camel")!,
        UIImage(named: "demo11")!
    ]
    
    var totalPriceX: Double = 0.0
    var afterPMPrice: Double = 0.0
    
    //    var carts: [Cart] = []
    //    var filterCart: [FilterCart] = []
    //    var updateQuantity: UpdateQuantityInCart?
    
    var getSessionCode: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        totalPrice_lbl.layer.cornerRadius = 12
        orderCompletion.layer.cornerRadius = 8
        
        tableView.register(UINib(nibName: cartCharityIdentfier, bundle: nil), forCellReuseIdentifier: cartCharityIdentfier)
        tableView.register(UINib(nibName: cartOtherCellIndentfier, bundle: nil), forCellReuseIdentifier: cartOtherCellIndentfier)
        
        
        //        if Helper.getToken() == nil {
        //        }else {
        //            getSessionCode = Helper.getToken()!
        //        }
        //
        //        getCart(sessionCode: getSessionCode)
        //
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("123")
        //   var getSessionCode: String = ""
        if Helper.getToken() == nil {
        }else {
            getSessionCode = Helper.getToken()!
        }
        
        getCart(sessionCode: getSessionCode)
    }
    
    
    
    func getCart (sessionCode: String){
        totalPriceX = 0.0
        SVProgressHUD.show()
        APIManagerGetCart.getCart(sessionCode: sessionCode) { (err, success) in
            SVProgressHUD.dismiss()
            if let err = err {
                print(err)
            }else if let success  =  success {
                if success.status == 200{
                    self.cart = success.carts
                    if self.cart.count == 0 {
                        self.tableView.isHidden = true
                        self.orderCompletion.isEnabled = false
                        self.orderCompletion.alpha = 0.5
                    }else {
                        self.tableView.isHidden = false
                        self.orderCompletion.isEnabled = true
                        self.orderCompletion.alpha = 1
                    }
                    self.tableView.reloadData()
                    for i in 0..<success.carts.count {
                        let total = success.carts[i].total ?? ""
                        print("Total: \(total)")
                        self.totalPriceX = self.totalPriceX + Double(total)!
                    }
                    print("Total Price: \(self.totalPriceX)")
                    self.totalPrice_lb.text = "الاجمالي : \(self.totalPriceX) ريال سعودي"
                }else{
                    
                }
                
            }
        }
    }
    
    func updateQuantityInCart(sessionCode: String, carId: String,quantity: String){
        SVProgressHUD.show()
        APIManagerAddToCart.updateQuantity(sessionCode: sessionCode, cardId: carId, quantity: quantity) { (err, success) in
            SVProgressHUD.dismiss()
            if let err = err {
                print("Error \(err)")
            }else if let succ = success{
                self.updateQuantity = succ
            }
        }
    }
    
    func deleteCart(sessionCode: String, carId: String){
        SVProgressHUD.show()
        APIManagerAddToCart.deleteCart(sessionCode: sessionCode, cardId: carId) { (err, success) in
            SVProgressHUD.dismiss()
            if let err = err {
                print("Error \(err)")
            }else if let succ = success{
                self.updateQuantity = succ
                self.getCart(sessionCode: self.getSessionCode)
            }
        }
    }
    
    @IBAction func whatsapp(_ sender: Any) {
        self.openwhatsapp(phone: "+9660544298982")

    }
    
    @IBAction func orderDone_btn(_ sender: Any) {
        let popScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderCompletionVC") as! OrderCompletionVC
        popScreen.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        dimmingCheckout.alpha = 1
        dimmingCheckout.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        //   dimmingOrderView.alpha = 0.0
        dimmingCheckout.frame = self.view.frame
        self.view.addSubview(dimmingCheckout)
        //  dimmingOrderView.alpha = 1
        popScreen.type = "0"
        self.present(popScreen, animated: true, completion: nil)
    }
    
    
}


//MARK:- TableView Delegate Data Source :-
extension CartVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if cart[indexPath.row].product?.id == 85 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartCharityCell", for: indexPath) as! CartCharityCell
            
            let cartId = cart[indexPath.row].id
            
            if let photoItem = cart[indexPath.row].product?.image{
                var imgName: String = ""
                imgName = photoItem.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                
                cell.productImage_iv.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                
                cell.productImage_iv.sd_setImage(with: URL(string: URLs.getImage(imgName)), placeholderImage: UIImage(named: "logo"))
            }else{
                print("no image")
            }
            cell.productName_lbl.text = cart[indexPath.row].product?.name
            
            cell.productSize_lbl.text = "صغير"
            
            cell.ChippingTitle_lbl.text = "لايوجد"
            
            cell.productPrice_lbl.text = cart[indexPath.row].total
            
            //   totalPrice_lb.text = "الاجمالي : \(cart[indexPath.row].total ?? "") ريال سعودي"
            
            
            let price = cart[indexPath.row].total
            let doublePrice = Double(price ?? "")!
            
            
            
            let quantity = cart[indexPath.row].quantity
            cell.adjCount = Int(quantity ?? "") ?? 0
            cell.counter_lbl.text = quantity
          
            
            
            var totalPrice: Int = 0

            
            cell.delete = {[weak self] in
                guard let self = self else {return}
                print("delete, \(self.getSessionCode)")
                
           
                self.deleteCart(sessionCode: self.getSessionCode, carId: "\(cartId ?? 0)")
//                self.afterPMPrice = self.totalPriceX + Double(totalPrice)
//                           self.totalPrice_lb.text = "الاجمالي : \(self.afterPMPrice) ريال سعودي"
            }
            
            
            
            cell.adjustCount = { (adjustCount) in
                print("indexPath: \(indexPath.row), Count: \(adjustCount)")
                
                let price = self.cart[indexPath.row].price
                let PriceInteger = (price! as NSString).integerValue
                totalPrice = PriceInteger  * adjustCount
                cell.productPrice_lbl.text = "\(totalPrice)"
                print("qunatity: \(totalPrice)")
                
                if cell.plus == true {
                    self.afterPMPrice = self.totalPriceX + Double(price ?? "")!
                }else{
                    self.afterPMPrice = self.totalPriceX - Double(price ?? "")!
                }
                
                self.totalPrice_lb.text = "الاجمالي : \(self.afterPMPrice) ريال سعودي"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.updateQuantityInCart(sessionCode: self.getSessionCode, carId: "\(cartId ?? 0)", quantity: "\(adjustCount)")
                }
            }
            
            
            return cell
            
            
        }else if cart[indexPath.row].product?.id == 86{ // صدقات
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartCharityCell", for: indexPath) as! CartCharityCell
            
            cell.Chipping_lbl.text = "توزيع"
            
            let cartId = cart[indexPath.row].id
            
            if let photoItem = cart[indexPath.row].product?.imagePath{
               // var imgName: String = ""
               // imgName = photoItem.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                
            
                
                cell.productImage_iv.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                
                cell.productImage_iv.sd_setImage(with: URL(string: photoItem ), placeholderImage: UIImage(named: "logo"))
            }else{
                print("no image")
            }
            cell.productName_lbl.text = cart[indexPath.row].product?.name
            
            cell.productSize_lbl.text = "صغير"
            
            cell.ChippingTitle_lbl.text = cart[indexPath.row].parts ?? ""
            
            cell.productPrice_lbl.text = cart[indexPath.row].total
            
            //     totalPrice_lb.text = "الاجمالي : \(cart[indexPath.row].total ?? "") ريال سعودي"
            
            let price = cart[indexPath.row].total
            let doublePrice = Double(price ?? "")!
            
            
            let quantity = cart[indexPath.row].quantity
            cell.adjCount = Int(quantity ?? "") ?? 0
            cell.counter_lbl.text = quantity
            
            cell.delete = {[weak self] in
                guard let self = self else {return}
                print("delete, \(self.getSessionCode)")
                
                self.deleteCart(sessionCode: self.getSessionCode, carId: "\(cartId ?? 0)")
            }
            
            var totalPrice: Int = 0
            cell.adjustCount = { (adjustCount) in
                print("indexPath: \(indexPath.row), Count: \(adjustCount)")
                
                let price = self.cart[indexPath.row].price
                let PriceInteger = (price! as NSString).integerValue
                totalPrice = PriceInteger  * adjustCount
                cell.productPrice_lbl.text = "\(totalPrice)"
                print("qunatity: \(totalPrice)")
                
                if cell.plus == true {
                    self.afterPMPrice = self.totalPriceX + Double(price ?? "")!
                }else{
                    self.afterPMPrice = self.totalPriceX - Double(price ?? "")!
                }
                
                self.totalPrice_lb.text = "الاجمالي : \(self.afterPMPrice) ريال سعودي"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.updateQuantityInCart(sessionCode: self.getSessionCode, carId: "\(cartId ?? 0)", quantity: "\(adjustCount)")
                }
            }
            
            return cell
            
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartOtherCell", for: indexPath) as! CartOtherCell
            
            let cartId = cart[indexPath.row].id
            
            if let photoItem = cart[indexPath.row].product?.image{
                var imgName: String = ""
                imgName = photoItem.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                
                cell.productImage_iv.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                
                cell.productImage_iv.sd_setImage(with: URL(string: URLs.getImage(imgName)), placeholderImage: UIImage(named: "logo"))
            }else{
                print("no image")
            }
            cell.productName_lbl.text = cart[indexPath.row].product?.name
            
            
            cell.productSize_lbl.text  = cart[indexPath.row].size ?? ""
            
            cell.ChippingTitle_lbl.text = cart[indexPath.row].parts ?? ""
            cell.Packaging_lbl.text = cart[indexPath.row].meatPackage ?? "لا يوجد"
            cell.head_lbl.text = cart[indexPath.row].head ?? ""
            cell.Stomach_lbl.text = cart[indexPath.row].kersh ?? ""
            cell.Chopped_lbl.text = cart[indexPath.row].mincedKilos ?? "0"
            cell.soup_lbl.text = cart[indexPath.row].soupKilos ?? "0"
            
            cell.productPrice_lbl.text = cart[indexPath.row].total
            
            let price = cart[indexPath.row].total
            let doublePrice = Double(price ?? "")!
            
            
            let quantity = cart[indexPath.row].quantity
            cell.adjCount = Int(quantity ?? "") ?? 0
            cell.counter_lbl.text = quantity
            
            cell.delete = {[weak self] in
                guard let self = self else {return}
                print("delete, \(self.getSessionCode)")
                
                self.deleteCart(sessionCode: self.getSessionCode, carId: "\(cartId ?? 0)")
            }
            
            
            cell.adjustCount = { (adjustCount) in
                print("indexPath: \(indexPath.row), Count: \(adjustCount)")
                
                let price = self.cart[indexPath.row].price
                let PriceInteger = (price! as NSString).integerValue
                let totalPrice = PriceInteger  * adjustCount
                cell.productPrice_lbl.text = "\(totalPrice)"
                print("qunatity: \(totalPrice)")
                
                if cell.plus == true {
                    self.afterPMPrice = self.totalPriceX + Double(price ?? "")!
                }else{
                    self.afterPMPrice = self.totalPriceX - Double(price ?? "")!
                }
                
                print("Total: \(self.totalPriceX)")
                
                self.totalPrice_lb.text = "الاجمالي : \(self.afterPMPrice) ريال سعودي"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.updateQuantityInCart(sessionCode: self.getSessionCode, carId: "\(cartId ?? 0)", quantity: "\(adjustCount)")
                }
            }
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.cart[indexPath.row].product?.id == 85 || self.cart[indexPath.row].product?.id == 86 {
            return 200
        }else{
            return 390
        }
        
    }
}



//MARK:- UIViewControllerTransitioningDelegate

extension CartVC : UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }
}
