//
//  ProductTypeCell.swift
//  JaddaButcher
//
//  Created by Elattar on 1/13/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import UIKit

class ProductTypeCell: UICollectionViewCell {

    @IBOutlet weak var viewX: UIView!
    @IBOutlet weak var mainTitle_lbl: UILabel!
    @IBOutlet weak var subTitle_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewX.layer.cornerRadius = 12
        viewX.backgroundColor = .clear
        mainTitle_lbl.textColor = UIColor.lightGray
        subTitle_lbl.textColor = UIColor.lightGray
        
    }

    
    override var isSelected: Bool{
        didSet{
            mainTitle_lbl.textColor = isSelected ? UIColor.MainColor : UIColor.lightGray
            subTitle_lbl.textColor = isSelected ? UIColor.MainColor : UIColor.lightGray
            if isSelected == true {
                viewX.layer.borderWidth = 1
                viewX.layer.borderColor = UIColor.MainColor.cgColor
                viewX.backgroundColor = UIColor.white
            }else {
                 viewX.layer.borderWidth = 0
                viewX.backgroundColor = UIColor.clear

            }
            
        }
    }
    
}
