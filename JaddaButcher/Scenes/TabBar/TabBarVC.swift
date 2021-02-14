//
//  TabBarVC.swift
//  JaddaButcher
//
//  Created by Elattar on 1/13/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    
    
    let coustmeTabBarView:UIView = {
        
        //  daclare coustmeTabBarView as view
        let view = UIView(frame: .zero)
        
        // to make the cornerRadius of coustmeTabBarView
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8196078431, blue: 0.5803921569, alpha: 1)
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        
        // to make the shadow of coustmeTabBarView
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -8.0)
        view.layer.shadowOpacity = 0.12
        view.layer.shadowRadius = 10.0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        addcoustmeTabBarView()
        //        hideTabBarBorder()
        
        self.selectedIndex = 3
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //   coustmeTabBarView.frame = tabBar.frame
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //   var newSafeArea = UIEdgeInsets()
        
        // Adjust the safe area to the height of the bottom views.
        //     newSafeArea.bottom += coustmeTabBarView.bounds.size.height
        
        // Adjust the safe area insets of the
        //  embedded child view controller.
        //   self.children.forEach({$0.additionalSafeAreaInsets = newSafeArea})
    }
    
    private func addcoustmeTabBarView() {
        coustmeTabBarView.frame = tabBar.frame
        view.addSubview(coustmeTabBarView)
        view.bringSubviewToFront(self.tabBar)
    }
    func hideTabBarBorder()  {
        let tabBar = self.tabBar
        tabBar.backgroundImage = UIImage.from(color: .clear)
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
        
    }
}


extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
