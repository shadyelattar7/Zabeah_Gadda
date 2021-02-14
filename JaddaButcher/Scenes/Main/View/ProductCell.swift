//
//  ProductCell.swift
//  JaddaButcher
//
//  Created by Elattar on 1/12/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage_iv: UIImageView!
    @IBOutlet weak var itemName_lbl: UILabel!
    @IBOutlet weak var viewx: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewx.layer.cornerRadius = 12
        
        itemImage_iv.layer.cornerRadius = 12
        itemImage_iv.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        itemImage_iv.layer.masksToBounds = true
        
        itemName_lbl.layer.cornerRadius = 12
        itemName_lbl.layer.masksToBounds = true
        itemName_lbl.clipsToBounds = true
        itemName_lbl.layer.maskedCorners = [.layerMaxXMaxYCorner  , .layerMinXMaxYCorner]

    }
    
}
