//
//  MainTabelViewCell.swift
//  City Butcher
//
//  Created by Elattar on 12/7/20.
//  Copyright © 2020 Elattar. All rights reserved.
//

import UIKit

class MainTabelViewCell: UITableViewCell {
    
    @IBOutlet weak var viewX: UIView!
    @IBOutlet weak var itemImage_iv: UIImageView!
    @IBOutlet weak var itemTitle_lbl: UILabel!
    @IBOutlet weak var min_btn: UIButton!
    @IBOutlet weak var countQuantity_lbl: UILabel!
    @IBOutlet weak var plus_btn: UIButton!
    @IBOutlet weak var itemPrice_lbl: UILabel!
    @IBOutlet weak var insideTableView: UITableView!
    @IBOutlet weak var delete_btn: UIButton!
    
    var delete: (() -> ())?
    var adjustCount: ((Int) -> ())?
    var adjCount: Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewX.layer.cornerRadius = 8
        plus_btn.layer.cornerRadius = 9.5
        min_btn.layer.cornerRadius = 9.5
        
        insideTableView.tableFooterView = UIView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func adjustCount_btn(_ sender: Any) {
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
        
        adjustCount?((adjCount))
        countQuantity_lbl.text = String(adjCount)
        
    }
    
    @IBAction func delete_btn(_ sender: Any) {
        delete?()
    }
    
}

extension MainTabelViewCell{
    
    func setTableViewDataSourceDelegate <D: UITableViewDelegate & UITableViewDataSource>
        (_ dataSoucreDelegate: D, forRow row: Int){
        
        insideTableView.delegate = dataSoucreDelegate
        insideTableView.dataSource = dataSoucreDelegate
        
        insideTableView.reloadData()
        
    }
    
}
