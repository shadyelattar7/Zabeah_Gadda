//
//  FirstVC.swift
//  JaddaButcher
//
//  Created by Elattar on 1/17/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {

    @IBOutlet weak var next_btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        next_btn.layer.cornerRadius = 12
    }
    

    @IBAction func skip_btn(_ sender: Any) {
        Core.shared.setIsNotNewUser()
        let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let stry = UIStoryboard(name: "Main", bundle: nil)
        rootViewController.rootViewController = stry.instantiateViewController(withIdentifier: "TabBarVC")
    }
    
    @IBAction func next_btn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Onboarding", bundle: Bundle.main)
        let Sign = storyBoard.instantiateViewController(withIdentifier: "SecondeVC")as! SecondeVC
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        Sign.modalPresentationStyle = .overFullScreen
        self.present(Sign, animated: true, completion: nil)
    }
}
