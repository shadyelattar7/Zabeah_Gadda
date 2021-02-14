//
//  SecondeVC.swift
//  JaddaButcher
//
//  Created by Elattar on 1/17/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import UIKit

class SecondeVC: UIViewController {

    @IBOutlet weak var start_btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        start_btn.layer.cornerRadius = 12
    }
    

    @IBAction func start_btn(_ sender: Any) {
        
        Core.shared.setIsNotNewUser()
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC")
        sb.modalPresentationStyle = .fullScreen
        present(sb, animated: false, completion: nil)
    }
    
}
