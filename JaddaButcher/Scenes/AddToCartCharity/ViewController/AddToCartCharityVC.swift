//
//  AddToCartCharityVC.swift
//  JaddaButcher
//
//  Created by Elattar on 1/15/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import UIKit
import UITextView_Placeholder
import DropDown
import SDWebImage
import SVProgressHUD

class AddToCartCharityVC: UIViewController {
    
    @IBOutlet weak var productImage_iv: UIImageView!
    @IBOutlet weak var producttitle_lbl: UILabel!
    @IBOutlet weak var collV: UICollectionView!
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var plus_btn: UIButton!
    @IBOutlet weak var min_btn: UIButton!
    @IBOutlet weak var DistributionView: UIView!
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var note_tf: UITextView!
    @IBOutlet weak var addToCart_btn: UIButton!
    @IBOutlet weak var payNow_btn: UIButton!
    @IBOutlet weak var counter_lbl: UILabel!
    @IBOutlet weak var distribute_lbl: UILabel!
    
    
    let productIdentfier = "ProductTypeCell"
    var selectIndexPath = IndexPath(item: 0, section: 0)
    
    
    var adjCount: Int = 1
    
    var categoryID: String = ""
    var prdouctID: Int = 0
    var productImage: String = ""
    var productName: String = ""
    var productPrice: [Price] = []
    
    var price: String = ""
    var selectDistribution = ""
    
    var distribution = [
        "الجمعيات الخيرية",
        "المطلقات و الارامل",
        "الفقراء و المساكين",
        "الايتام"
    ]
    
    let distributionDropDownMenu = DropDown()
    
    
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
        setDate()
    }
    
    private func setupView(){
        productImage_iv.layer.cornerRadius = 12
        productImage_iv.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        productImage_iv.layer.masksToBounds = true
        
        producttitle_lbl.layer.cornerRadius = 12
        producttitle_lbl.layer.masksToBounds = true
        
        producttitle_lbl.layer.maskedCorners = [.layerMaxXMaxYCorner  , .layerMinXMaxYCorner]
        
        plus_btn.layer.cornerRadius = 8
        min_btn.layer.cornerRadius = 8
        
        quantityView.layer.cornerRadius = 12
        quantityView.backgroundColor = .ThiredColor
        quantityView.layer.borderWidth = 1
        quantityView.layer.borderColor = UIColor.MainColor.cgColor
        
        
        noteView.layer.cornerRadius = 12
        noteView.layer.borderWidth = 1
        noteView.layer.borderColor = UIColor.MainColor.cgColor
        note_tf.placeholder = "ملاحظات"
        
        
        addToCart_btn.layer.cornerRadius = 12
        payNow_btn.layer.cornerRadius = 12
        payNow_btn.layer.borderWidth = 1
        payNow_btn.layer.borderColor = UIColor.MainColor .cgColor
        
        
        let nibCell3 = UINib(nibName: productIdentfier, bundle: nil)
        collV.register(nibCell3, forCellWithReuseIdentifier: productIdentfier)
        collV.delegate = self
        collV.dataSource = self
        self.collV.selectItem(at: self.selectIndexPath, animated: false, scrollPosition: .centeredHorizontally)
        self.price = productPrice[0].price ?? ""
        distributionDropDownMenu.anchorView = DistributionView
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapitem))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        DistributionView.addGestureRecognizer(tapGesture)
        
        distributionDropDownMenu.dataSource = distribution
        
        distributionDropDownMenu.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else {return}
            print("Selected item: \(item) at index: \(index)")
            self.selectDistribution = item
            self.distribute_lbl.text = item
        }
        
    }
    
    func setDate(){
//        let imgName = self.productImage.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let imgName = self.productImage
        productImage_iv.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        productImage_iv.sd_setImage(with: URL(string: imgName), placeholderImage: UIImage(named: "logo"))
        self.producttitle_lbl.text = productName
    }
    
    @objc func didTapitem() {
        distributionDropDownMenu.show()
        print("123")
    }
    
    @IBAction func adjCounter_btn(_ sender: Any) {
        let tag: Int = (sender as AnyObject).tag
        if tag == 0{
            
            if adjCount >= 1 {
                adjCount = adjCount + 1
            }
        }else{
            
            if adjCount > 1 {
                adjCount = adjCount - 1
            }
        }
        
        
        counter_lbl.text = String(adjCount)
    }
    
    @IBAction func back_btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func addToCartChirty(productId: String,size: String,quantity: String, price: String,sessionCode: String, note: String,type: String,category_id: String,kersh: String,soup_kilos: String,minced_kilos: String,minced: String,head:String, meat_package: String,parts: String){
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
    
    @IBAction func whatsapp_btn(_ sender: Any) {
        self.openwhatsapp(phone: "+9660544298982")

    }
    
    @IBAction func addToCart_btn(_ sender: Any) {
        var getSessionCode: String = ""
        if Helper.getToken() == nil {
        }else {
            getSessionCode = Helper.getToken()!
        }
        addToCartChirty(productId: "\(prdouctID)", size: "1", quantity: "\(adjCount)", price: price, sessionCode: getSessionCode, note: note_tf.text, type: "0", category_id: categoryID, kersh: "", soup_kilos: "", minced_kilos: "", minced: "", head: "", meat_package: "", parts: selectDistribution)
        
        print("Total Price: \(price)")
    }
    
    
    @IBAction func payNow_btn(_ sender: Any) {
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
        popScreen.price = price
        popScreen.notes = note_tf.text
        popScreen.category_id = categoryID
        self.present(popScreen, animated: true, completion: nil)
    }
    
}


//MARK:- CollectionView Products Type
extension AddToCartCharityVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productPrice.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductTypeCell", for: indexPath) as! ProductTypeCell
        cell.mainTitle_lbl.text = productPrice[indexPath.row].name
        cell.subTitle_lbl.text = productPrice[indexPath.row].price
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.price =  productPrice[indexPath.row].price ?? ""
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collV.frame.size.width / 3) - 5, height: self.collV.frame.size.height)
    }
    
    
    
}
