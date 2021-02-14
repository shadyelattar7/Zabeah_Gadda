//
//  addToCart.swift
//  JaddaButcher
//
//  Created by Elattar on 1/13/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import UIKit
import BEMCheckBox
import DropDown
import UITextView_Placeholder
import SDWebImage
import SVProgressHUD

class addToCart: UIViewController, BEMCheckBoxDelegate {
    
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
    @IBOutlet weak var prductTypeCollV: UICollectionView!
    @IBOutlet weak var choppingMethodView: UIView!
    @IBOutlet weak var yesCheck: BEMCheckBox!
    @IBOutlet weak var noCheck: BEMCheckBox!
    @IBOutlet weak var headMethodView: UIView!
    @IBOutlet weak var stomachView: UIView!
    @IBOutlet weak var plusSoup_btn: UIButton!
    @IBOutlet weak var counterSoup_lbl: UILabel!
    @IBOutlet weak var minSoup_btn: UIButton!
    @IBOutlet weak var counterSoupView: UIView!
    @IBOutlet weak var soupPrice_lbl: UILabel!
    @IBOutlet weak var meatChoppingMethodPrice_lbl: UILabel!
    @IBOutlet weak var meatChoppingMethodPlus_btn: UIButton!
    @IBOutlet weak var meatChoppingMethod_lbl: UILabel!
    @IBOutlet weak var meatChoppingMethodMin_btn: UIButton!
    @IBOutlet weak var meatChoppingMethodView: UIView!
    @IBOutlet weak var choppingMethod_lbl: UILabel!
    @IBOutlet weak var head_lbl: UILabel!
    @IBOutlet weak var mosran_lbl: UILabel!
    
     let productIdentfier = "ProductTypeCell"
     let choppingMethodDropDownMenu = DropDown()
     let headMethodDropDownMenu = DropDown()
     let stomachDropDownMenu = DropDown()
    
    var adjCount: Int = 1
    var adjCounterSoup: Int = 0
    var adjCounterMincedmeat: Int = 0
    
     var selectIndexPath = IndexPath(item: 0, section: 0)
    
    var categoryID: String = ""
    var prdouctID: Int = 0
    var productImage: String = ""
    var productName: String = ""
    var productPrice: [Price] = []
    var price: String = ""
    var chopping: String = ""
    var head: String = ""
    var minced: String = ""
    var size: String = ""
    var parts: String = ""
    var Packaging: String = ""

    var selectedPrice: Double = 0.0
    var totalPrice: Double = 0.0
    
    var buttonSelectionSoup:Bool = false
    var buttonSelectionChipping:Bool = false
    
    var totalPriceWithExtention: Double = 0.0
    
    var priceX: String = ""
    
    
    
    var choppingMethod = [
        "ثلاجة",
        "أرباع",
        "أنصاف",
        "حضرمي (مفاصل)",
        "مفطح"
    ]
    
    var headMethod = [
    "شلوطة",
    "سلخ",
    "غير مطلوب",
    ]
    
    var Mincedmeat = [
    "مطلوب",
    "غير مطلوب"
    ]
    
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
        setupview()
        setDate()
    }
    
    private func setupview(){
        self.tabBarController?.tabBar.isHidden = true

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
        
        plusSoup_btn.layer.cornerRadius = 8
        minSoup_btn.layer.cornerRadius = 8
        counterSoupView.layer.cornerRadius = 12
        counterSoupView.backgroundColor = .ThiredColor
        counterSoupView.layer.borderWidth = 1
        counterSoupView.layer.borderColor = UIColor.MainColor.cgColor
        
        meatChoppingMethodPlus_btn.layer.cornerRadius = 8
        meatChoppingMethodMin_btn.layer.cornerRadius = 8
        meatChoppingMethodView.layer.cornerRadius = 12
        meatChoppingMethodView.backgroundColor = .ThiredColor
        meatChoppingMethodView.layer.borderWidth = 1
        meatChoppingMethodView.layer.borderColor = UIColor.MainColor.cgColor
        
        notesView.layer.cornerRadius = 12
        notesView.layer.borderWidth = 1
        notesView.layer.borderColor = UIColor.MainColor.cgColor
        note_tv.placeholder = "ملاحظات"
        
        addToCart_btn.layer.cornerRadius = 12
        buyNow_btn.layer.cornerRadius = 12
        buyNow_btn.layer.borderWidth = 1
        buyNow_btn.layer.borderColor = UIColor.MainColor .cgColor
        
        yesCheck.delegate = self
        noCheck.delegate = self
        
        yesCheck.setOn(true, animated: true)
        
        
        choppingMethodDropDownMenu.anchorView = choppingMethodView
        headMethodDropDownMenu.anchorView = headMethodView
        stomachDropDownMenu.anchorView = stomachView
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapitem))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        choppingMethodView.addGestureRecognizer(tapGesture)
       
        let tapGestureHeadMethod = UITapGestureRecognizer(target: self, action: #selector(didTapHead))
        tapGestureHeadMethod.numberOfTapsRequired = 1
        tapGestureHeadMethod.numberOfTouchesRequired = 1
        headMethodView.addGestureRecognizer(tapGestureHeadMethod)
        
        let tapGestureStomach = UITapGestureRecognizer(target: self, action: #selector(didTapStomach))
        tapGestureStomach.numberOfTapsRequired = 1
        tapGestureStomach.numberOfTouchesRequired = 1
        stomachView.addGestureRecognizer(tapGestureStomach)
        
        choppingMethodDropDownMenu.dataSource = choppingMethod
        headMethodDropDownMenu.dataSource = headMethod
        stomachDropDownMenu.dataSource = Mincedmeat
        
        choppingMethodDropDownMenu.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else {return}
            print("Selected item: \(item) at index: \(index)")
            self.chopping = item
            self.choppingMethod_lbl.text = item
        }
     
        
        headMethodDropDownMenu.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else {return}
            print("Selected item: \(item) at index: \(index)")
            self.head = item
            self.head_lbl.text = item
        }
        
        stomachDropDownMenu.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else {return}
            print("Selected item: \(item) at index: \(index)")
            self.minced = item
            self.mosran_lbl.text = item
        }
        
        
        let nibCell3 = UINib(nibName: productIdentfier, bundle: nil)
        prductTypeCollV.register(nibCell3, forCellWithReuseIdentifier: productIdentfier)
        prductTypeCollV.delegate = self
        prductTypeCollV.dataSource = self
        
        
        self.prductTypeCollV.selectItem(at: self.selectIndexPath, animated: false, scrollPosition: .centeredHorizontally)
        productPrice_lbl.text = productPrice[0].price ?? ""
        let price = productPrice[0].price ?? ""
        selectedPrice = Double(price)!
        totalPrice = Double(price)!
        priceX = price
         yesCheck.setOn(true, animated: true)
         Packaging = "نعم"

    }
    
    func setDate(){
//        let imgName = self.productImage.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
          let imgName = self.productImage
        print("Image: \(imgName)")
        product_iv.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        product_iv.sd_setImage(with: URL(string: imgName), placeholderImage: UIImage(named: "logo"))
        self.productName_lbl.text = productName
    }
  
    
    @objc func didTapitem() {
        choppingMethodDropDownMenu.show()
        print("123")
    }
    
    @objc func didTapHead(){
        headMethodDropDownMenu.show()
        print("456")
    }
    
  @objc func didTapStomach(){
    stomachDropDownMenu.show()
        print("789")
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        
        if checkBox.tag == 0 {
            yesCheck.setOn(true, animated: true)
            noCheck.setOn(false, animated: true)
            Packaging = "نعم"
        }else if checkBox.tag == 1 {
            noCheck.setOn(true, animated: true)
            yesCheck.setOn(false, animated: true)
            Packaging = "لا"
        }
        
        
    }
    
    private func addToCart(productId: String,size: String,quantity: String, price: String,sessionCode: String, note: String,type: String,category_id: String,kersh: String,soup_kilos: String,minced_kilos: String,minced: String,head:String, meat_package: String,parts: String){
         SVProgressHUD.show()
         APIManagerAddToCart.addToCart(productId: productId, size: size, quantity: quantity, price: price, sessionCode: sessionCode, note: note, kersh: kersh, soup_kilos: soup_kilos, minced_kilos: minced_kilos, type: type, pay_method: "", minced: minced, category_id: category_id, head: head, meat_package: meat_package, parts: parts) { (err, sucess) in
             SVProgressHUD.dismiss()
             if let err = err {
                 print(err)
             }else if let success = sucess{
                 if success.status == 200 {
                     print(success.message ?? "")
                     ToastManager.shared.showToast(message: "تم الطلب بنجاح", view: self.view, postion: .top, backgroundColor: .systemGreen)
                 }else{
                     print("Failer: \(success.errors?.first ?? "")")
                     ToastManager.shared.showToast(message: "يوجد خطا برجاء المحاوله مره ثانية", view: self.view, postion: .top, backgroundColor: .systemRed)
                 }
             }
         }
     }
    
    @IBAction func adjQuantity(_ sender: Any) {
        let tag: Int = (sender as AnyObject).tag
        if tag == 0{
            
            if adjCount >= 1 {
                adjCount = adjCount + 1
            }
        }else{
            
            if adjCount > 1 {
                adjCount = adjCount - 1
            }
            
            adjCounterSoup = 0
            adjCounterMincedmeat = 0
            counterSoup_lbl.text = String(adjCounterSoup)
            meatChoppingMethod_lbl.text = String(adjCounterMincedmeat)
            buttonSelectionSoup = false
            buttonSelectionChipping = false
        }
        
        let total = (selectedPrice) * Double(adjCount)
       // print("totalPrice: \(total)")
        productPrice_lbl.text = String(total)
        counter_lbl.text = String(adjCount)
        totalPrice = total
    
        
        
        
    }
    
    @IBAction func adjSoup_btn(_ sender: Any) {
        let tag: Int = (sender as AnyObject).tag
        if tag == 0{
            
            if buttonSelectionSoup == false{
                totalPrice =  totalPrice + 30.0
                buttonSelectionSoup = true
            }
            
            if adjCounterSoup >= 0 {
                adjCounterSoup = adjCounterSoup + 1
            }
        }else{
            
            if adjCounterSoup > 0 {
                adjCounterSoup = adjCounterSoup - 1
            }
            
            if adjCounterSoup <= 0 {
                if buttonSelectionSoup == true{
                    totalPrice =  totalPrice - 30.0
                    buttonSelectionSoup = false
                }
            }
            
        }
        
        productPrice_lbl.text = String(totalPrice)
        counterSoup_lbl.text = String(adjCounterSoup)
    }
    
    @IBAction func adjMeatChoppingMethodPlus_btn(_ sender: Any) {
        let tag: Int = (sender as AnyObject).tag
        if tag == 0{
            
            if buttonSelectionChipping == false{
                totalPrice =  totalPrice + 35.0
                buttonSelectionChipping = true
            }
            
            
            if adjCounterMincedmeat >= 0 {
                adjCounterMincedmeat = adjCounterMincedmeat + 1
            }
        }else{
            
            if adjCounterMincedmeat > 0 {
                adjCounterMincedmeat = adjCounterMincedmeat - 1
            }
            
            if adjCounterSoup <= 0 {
                if buttonSelectionChipping == true{
                    totalPrice =  totalPrice - 35.0
                    buttonSelectionChipping = false
                }
            }
        }
        
        productPrice_lbl.text = String(totalPrice)
        meatChoppingMethod_lbl.text = String(adjCounterMincedmeat)
    }
    
    
    
    @IBAction func back_btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func whatsapp_btn(_ sender: Any) {
        print("Whatsapp")
        print("Packaging: \(Packaging)")
        self.openwhatsapp(phone: "+9660544298982")

    }
    
    
    @IBAction func addToCart(_ sender: Any) {
        var getSessionCode: String = ""
        if Helper.getToken() == nil {
        }else {
            getSessionCode = Helper.getToken()!
        }
        //price
        //"\(totalPrice)"
        addToCart(productId: "\(prdouctID)", size: size, quantity: "\(adjCount)", price: priceX, sessionCode: getSessionCode, note: note_tv.text, type: "0", category_id: categoryID, kersh: minced, soup_kilos: "\(adjCounterSoup)", minced_kilos: "\(adjCounterMincedmeat)", minced: minced, head: head, meat_package: Packaging, parts: chopping)
        
        
        print("Total Price: \(priceX)")
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
        popScreen.price = "\(totalPrice)"
        popScreen.notes = note_tv.text
        popScreen.category_id = categoryID
        popScreen.size = size
        popScreen.kersh = minced
        popScreen.soup_kilos = "\(adjCounterSoup)"
        popScreen.minced_kilos = "\(adjCounterMincedmeat)"
        popScreen.parts = Packaging
        popScreen.head = head
        
       self.present(popScreen, animated: true, completion: nil)
    }
    
}




//MARK:- CollectionView Products Type
extension addToCart: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productPrice.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductTypeCell", for: indexPath) as! ProductTypeCell
        cell.mainTitle_lbl.text = productPrice[indexPath.row].name
        cell.subTitle_lbl.text = productPrice[indexPath.row].price
        
        size = productPrice[indexPath.row].name ?? ""
        price = productPrice[indexPath.row].price ?? ""
        print("Total Price: \(price)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        productPrice_lbl.text = productPrice[indexPath.row].price ?? ""
        let price = productPrice[indexPath.row].price ?? ""
        priceX = price
        selectedPrice = Double(price)!
        totalPrice = Double(price)!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.prductTypeCollV.frame.size.width / 3) - 5, height: self.prductTypeCollV.frame.size.height)
    }
    

}
