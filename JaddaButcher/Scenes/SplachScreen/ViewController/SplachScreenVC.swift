//
//  SplachScreenVC.swift
//  JaddaButcher
//
//  Created by Elattar on 1/17/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import UIKit
import SwiftyGif

class SplachScreenVC: UIViewController {

     let logoAnimationView = LogoAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logoAnimationView.logoGifImageView?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           logoAnimationView.logoGifImageView?.startAnimatingGif()
       }
       
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           logoAnimationView.frame = view.bounds
           logoAnimationView.contentMode = .scaleAspectFit
           view.addSubview(logoAnimationView)
    }
   

}


extension SplachScreenVC: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        if Core.shared.isNewUser(){
            //show onboarding
            let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)!
            let stry = UIStoryboard(name: "Onboarding", bundle: nil)
            rootViewController.rootViewController = stry.instantiateViewController(withIdentifier: "FirstVC")
        }else{
            let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)!
                 let stry = UIStoryboard(name: "Main", bundle: nil)
                 rootViewController.rootViewController = stry.instantiateViewController(withIdentifier: "TabBarVC")
        }
    }
}
