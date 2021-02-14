//
//  SuccessfullyOrderVC.swift
//  City Butcher
//
//  Created by Elattar on 12/8/20.
//  Copyright © 2020 Elattar. All rights reserved.
//

import UIKit

class SuccessfullyOrderVC: UIViewController {

    @IBOutlet weak var back_btn: UIButton!
    @IBOutlet weak var viewX: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        
        //   self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        // self.viewX.backgroundColor = .clear
        back_btn.layer.cornerRadius = 8
        showAnimate()
        
    }
    
    func showAnimate()
       {
           self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
           self.view.alpha = 0.0;
           UIView.animate(withDuration: 0.5, animations: {
               self.view.alpha = 1.0
               self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           });
       }
       
       func removeAnimate()
       {
           UIView.animate(withDuration: 0.25, animations: {
               self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
               self.view.alpha = 0.0;
           }, completion:{(finished : Bool)  in
               if (finished)
               {
                   self.view.removeFromSuperview()
               }
           });
       }
       

    @IBAction func back_btn(_ sender: Any) {
        guard let window = UIApplication.shared.keyWindow else {return}
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC")
        window.rootViewController = sb
        UIView.transition(with: window, duration: 0.5, options: .autoreverse, animations: nil, completion: nil)
    }
    

}
