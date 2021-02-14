//
//  SliderImageCell.swift
//  City Butcher
//
//  Created by Elattar on 12/1/20.
//  Copyright © 2020 Elattar. All rights reserved.
//

import UIKit

class SliderImageCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImgs_iv: UIImageView!
    
    
    var image:UIImage!{
        didSet{
            slideImgs_iv.image = image
        }
    }

    
}
