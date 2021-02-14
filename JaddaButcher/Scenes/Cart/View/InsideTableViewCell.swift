//
//  InsideTableViewCell.swift
//  City Butcher
//
//  Created by Elattar on 12/7/20.
//  Copyright © 2020 Elattar. All rights reserved.
//

import UIKit

class InsideTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var secTitle_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
