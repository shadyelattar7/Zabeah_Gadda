//
//  MainVC.swift
//  JaddaButcher
//
//  Created by Elattar on 1/12/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

class MainVC: UIViewController {
    
    @IBOutlet weak var ImageSlider: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var productCollection: UICollectionView!
    
    
    let productIdentfier = "ProductCell"
    
    var categories: [Product] = []
    var banners: [DataBanners] = []
    
    var currentIndex = 0
    var timer: Timer?
    let imageSlider = [
        UIImage(named: "slidImageMOK")!,
        UIImage(named: "slidImageMOK")!,
        UIImage(named: "slidImageMOK")!,
        UIImage(named: "slidImageMOK")!,
        UIImage(named: "slidImageMOK")!,
        
    ]
    
    let productImg = [
        UIImage(named: "demo11")!,
        UIImage(named: "demo11")!,
        UIImage(named: "demo11")!,
    ]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTimer()
        getBanner()
    }
    
    
    
    private func setupView(){
        ImageSlider.delegate = self
        ImageSlider.dataSource = self
        
        productCollection.delegate = self
        productCollection.dataSource = self
        
        self.pageControl.numberOfPages = self.imageSlider.count
        
        let nibCell3 = UINib(nibName: productIdentfier, bundle: nil)
        productCollection.register(nibCell3, forCellWithReuseIdentifier: productIdentfier)
        
        getCategories()
    }
    
    func setupTimer(){
        timer = Timer.scheduledTimer(timeInterval:  3.0 , target: self, selector: #selector(handleTimerSliderImage), userInfo: nil, repeats: true)
    }
    
    @objc func handleTimerSliderImage(){
        let desiredScrollPostion = (currentIndex < imageSlider.count - 1) ? currentIndex + 1 : 0
        ImageSlider.scrollToItem(at: IndexPath(row: desiredScrollPostion, section: 0), at: .centeredHorizontally, animated: true)
        
    }
    
    
    private func getBanner(){
        ApiManagerBannner.banner() { (err, offer) in
            if let err = err {
                print("Err in get banner, \(err)")
            }else if let banners = offer{
                self.banners = banners.data ?? []
                self.ImageSlider.reloadData()
                self.pageControl.numberOfPages = self.banners.count
            }
        }
    }
    
    private func getCategories(){
        SVProgressHUD.show()
        APIManagerCategorie.categoryList { (success) in
            SVProgressHUD.dismiss()
            if success.status == 200 {
                self.categories = success.products
                self.productCollection.reloadData()
            }else{
                self.showAlart(title: "", message: "يوجد شي خطا")
            }
        }
    }
    
    @IBAction func whatsapp_btn(_ sender: Any) {
        print("WhatsApp")
        self.openwhatsapp(phone: "+9660544298982")
        
    }
    
}

//MARK:- First collection View , (Image slider)
extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ImageSlider{
            return banners.count
        } else {
            return categories.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == ImageSlider {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderImageCell", for: indexPath) as! SliderImageCell
            if let photoItem = banners[indexPath.row].imagePath{
                cell.slideImgs_iv.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.slideImgs_iv.sd_setImage(with: URL(string: photoItem), placeholderImage: UIImage(named: "logo"))
            }else{
                print("no image")
            }
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            cell.itemName_lbl.text = categories[indexPath.row].name
            
            if let photoItem = categories[indexPath.row].imagePath{
             //   var imgName: String = ""
             //   imgName = photoItem.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                cell.itemImage_iv.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                cell.itemImage_iv.sd_setImage(with: URL(string: photoItem), placeholderImage: UIImage(named: "logo"))
            }else{
                print("no image")
            }
            
            return cell
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == ImageSlider{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }else {
            return CGSize(width: (self.productCollection.frame.size.width - 20) / 2, height: 230)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if categories[indexPath.row].id == 85 { // حاشي
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
            sb.productName = categories[indexPath.row].name ?? ""
            sb.productImage = categories[indexPath.row].imagePath ?? ""
            sb.productPrice = categories[indexPath.row].prices?.first?.price ?? ""
            sb.prdouctID = categories[indexPath.row].id ?? 0
            sb.categoryID = categories[indexPath.row].categoryID ?? ""
            
            self.navigationController?.pushViewController(sb, animated: true)
        }else if categories[indexPath.row].id == 86{ // صداقات
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddToCartCharityVC") as! AddToCartCharityVC
            
            sb.productName = categories[indexPath.row].name ?? ""
            sb.productImage = categories[indexPath.row].imagePath ?? ""
            sb.productPrice = categories[indexPath.row].prices ?? []
            sb.prdouctID = categories[indexPath.row].id ?? 0
            sb.categoryID = categories[indexPath.row].categoryID ?? ""
            
            
            self.navigationController?.pushViewController(sb, animated: true)
        }else{ // الباقي
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addToCart") as! addToCart
            sb.productName = categories[indexPath.row].name ?? ""
            sb.productImage = categories[indexPath.row].imagePath ?? ""
            sb.productPrice = categories[indexPath.row].prices ?? []
            sb.prdouctID = categories[indexPath.row].id ?? 0
            //  sb.categoryID = categories[indexPath.row].categoryID ?? ""
            
            self.navigationController?.pushViewController(sb, animated: true)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / ImageSlider.frame.size.width)
        pageControl.currentPage = currentIndex
    }
}


//MARK:- UICollectionViewFlowLayout

extension UICollectionViewFlowLayout {
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
}
