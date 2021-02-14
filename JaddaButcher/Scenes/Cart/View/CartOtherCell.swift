//
//  CartOtherCell.swift
//  JaddaButcher
//
//  Created by Elattar on 1/16/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import UIKit

class CartOtherCell: UITableViewCell {

    @IBOutlet weak var viewX: UIView!
    @IBOutlet weak var productName_lbl: UILabel!
    @IBOutlet weak var productImage_iv: UIImageView!
    @IBOutlet weak var productSize_lbl: UILabel!
    @IBOutlet weak var ChippingTitle_lbl: UILabel!
    @IBOutlet weak var productPrice_lbl: UILabel!
    @IBOutlet weak var counter_lbl: UILabel!
    @IBOutlet weak var plus_btn: UIButton!
    @IBOutlet weak var min_btn: UIButton!
    @IBOutlet weak var Packaging_lbl: UILabel!
    @IBOutlet weak var head_lbl: UILabel!
    @IBOutlet weak var Stomach_lbl: UILabel!
    @IBOutlet weak var Chopped_lbl: UILabel!
    @IBOutlet weak var soup_lbl: UILabel!
    
    var plus: Bool = false
    
    
    var delete: (() -> ())?
    var adjustCount: ((Int) -> ())?
    var adjCount: Int = 1
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewX.layer.cornerRadius = 8
        plus_btn.layer.cornerRadius = 9.5
        min_btn.layer.cornerRadius = 9.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func adjCount_btn(_ sender: Any) {
        let tag: Int = (sender as AnyObject).tag
        if tag == 0{
            plus = true
            if adjCount >= 1 {
                adjCount = adjCount + 1
            }
        }else{
            plus = false
            if adjCount > 1 {
                adjCount = adjCount - 1
            }
        }
        
        adjustCount?((adjCount))
        counter_lbl.text = String(adjCount)
    }
    
       
       
       @IBAction func delete_btn(_ sender: Any) {
           delete?()

       }
    
}
