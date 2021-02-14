//
//  BankVC.swift
//  JaddaButcher
//
//  Created by Elattar on 1/17/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import UIKit

class BankVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func whatsapp_btn(_ sender: Any) {
        self.openwhatsapp(phone: "+9660544298982")

    }
    
    @IBAction func back_btn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    

}
