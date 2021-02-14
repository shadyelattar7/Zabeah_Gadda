//
//  MyOrdersCell.swift
//  JaddaButcher
//
//  Created by Elattar on 1/13/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import UIKit

class MyOrdersCell: UITableViewCell {

    @IBOutlet weak var orderDate_lbl: UILabel!
    @IBOutlet weak var orderNumber_lbl: UILabel!
    @IBOutlet weak var orderElMostaqbl_lbl: UILabel!
    @IBOutlet weak var orderPrice_lbl: UILabel!
    @IBOutlet weak var collV: UICollectionView!
    @IBOutlet weak var orderPrepare_iv: UIImageView!
    @IBOutlet weak var orderPrepareView: UIView!
    @IBOutlet weak var orderUnderDelivery_iv: UIImageView!
    @IBOutlet weak var orderUnderDeliveryView: UIView!
    @IBOutlet weak var orderPlaced_iv: UIImageView!
    @IBOutlet weak var orderPlaceView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        orderPrepareView.layer.cornerRadius = 15
        orderUnderDeliveryView.layer.cornerRadius = 15
        orderPlaceView.layer.cornerRadius = 15
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
         collV.delegate = dataSourceDelegate
         collV.dataSource = dataSourceDelegate
         collV.tag = row
       //  collV.reloadData()
     }
    
}
