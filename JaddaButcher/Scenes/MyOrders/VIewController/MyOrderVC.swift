//
//  MyOrderVC.swift
//  JaddaButcher
//
//  Created by Elattar on 1/14/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

class MyOrderVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var myorders: [DateMyOrder] = []
    var products: [ProductMyOrder] = []
    
    
    var selectIndexPath = IndexPath(item: 0, section: 0)
    var myRow = 0 // set the index path row of your tableview cell
    var mySection = 0
    
    let item: [UIImage] = [
    UIImage(named: "1")!,
    UIImage(named: "2")!,
    UIImage(named: "3")!,
    UIImage(named: "4")!,
    UIImage(named: "5")!,
    ]
    
    let itemTitle: [String] = [
    "تيس بلدي",
    "حري",
    "حاشي",
    "سواكني",
    "خروف حري"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        var getSessionCode: String = ""
        if Helper.getToken() == nil {
        }else {
            getSessionCode = Helper.getToken()!
        }
        getMyOrders(sessionCode: getSessionCode)
    }
    
    func getMyOrders(sessionCode: String){
        SVProgressHUD.show()
        ApiManagerMyOrders.getMyOrders(sessionCode: sessionCode) { (err, order) in
            SVProgressHUD.dismiss()
            if let err = err {
                print("error in my orders, ", err)
            }else if let orders = order {
                self.myorders = orders.data ?? []
                self.tableView.reloadData()
                
            }
        }
    }
    
    @IBAction func whatsapp_btn(_ sender: Any) {
        print("whatsapp")
        self.openwhatsapp(phone: "+9660544298982")

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myorders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrdersCell", for: indexPath) as! MyOrdersCell
   
        
        let date = myorders[indexPath.row].updatedAt
        let finalDate =  DateFormat.dateFormat(dateEx: date ?? "", dateFormat: "yyy-MM-dd HH:mm:ss")
        cell.orderDate_lbl.text = finalDate
        let orderId = myorders[indexPath.row].id
        cell.orderNumber_lbl.text = "\(orderId ?? 0)"
        cell.orderElMostaqbl_lbl.text = "المنزل"
        cell.orderPrice_lbl.text = myorders[indexPath.row].totalPrice
    
        products.removeAll()
        for i in myorders[indexPath.row].details ?? []{
        
            
            products.append(i.product!)
        
              print("Not Found Products")
        }
        
//        if let product = myorders[indexPath.row].details?[indexPath.row].product{
//            products.append(product)
//        }else{
//            print("Not Found Products")
//        }
//
        let status = myorders[indexPath.row].statusID
        
        if status == 0 { // تحت المراجعة
            cell.orderPrepare_iv.image = #imageLiteral(resourceName: "reviewingOn")
            cell.orderPrepareView.backgroundColor = .black
        }else if status == 1 { // جاري الشحن
            cell.orderUnderDelivery_iv.image = #imageLiteral(resourceName: "shipping_iconOn")
            cell.orderUnderDeliveryView.backgroundColor = .black
            
            cell.orderPrepare_iv.image = #imageLiteral(resourceName: "reviewingOff")
            cell.orderPrepareView.backgroundColor = .lightGray
            
        }else { // تم الاستلام
            cell.orderPlaced_iv.image = #imageLiteral(resourceName: "delivered_icon_un_activeOn")
            cell.orderPlaceView.backgroundColor = .black
            
            cell.orderUnderDelivery_iv.image = #imageLiteral(resourceName: "shipping_iconOff")
            cell.orderUnderDeliveryView.backgroundColor = .lightGray
            
            cell.orderPrepare_iv.image = #imageLiteral(resourceName: "reviewingOff")
            cell.orderPrepareView.backgroundColor = .lightGray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? MyOrdersCell else { return }

        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

}

extension MyOrderVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyOrderCollCell", for: indexPath) as! MyOrderCollCell
        
        cell.orderTitle_lbl.text = products[indexPath.row].name
        
        if let photoItem = products[indexPath.row].imagePath{
         //   var imgName: String = ""
          //  imgName = photoItem.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            
            cell.order_iv.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.order_iv.sd_setImage(with: URL(string: photoItem), placeholderImage: UIImage(named: "no_imageX"))
        }else{
            print("no image")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("IndexPath: \(indexPath.row)")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }

    
    
}
