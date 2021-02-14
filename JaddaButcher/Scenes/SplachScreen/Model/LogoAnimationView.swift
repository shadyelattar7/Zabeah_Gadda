//
//  LogoAnimationView.swift
//  filter and lens
//
//  Created by Ayman Ata on 11/22/20.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit
import SwiftyGif

class LogoAnimationView: UIView {
    
    var logoGifImageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        logoGifImageView?.contentMode = .scaleToFill
        
        do {
            let logoGif = try UIImageView(gifImage: UIImage(gifName: "lens.gif"), manager: SwiftyGifManager(memoryLimit: 20), loopCount: 1)
                
            logoGif.contentMode = .scaleAspectFit
            self.logoGifImageView = logoGif
            
        } catch {
            print(error)
        }
        
        guard let logoGif = logoGifImageView else { return }
        logoGif.contentMode = .scaleToFill
        logoGif.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(logoGif)
        NSLayoutConstraint.activate([
            logoGif.topAnchor.constraint(equalTo: topAnchor),
            logoGif.bottomAnchor.constraint(equalTo: bottomAnchor),
            logoGif.leftAnchor.constraint(equalTo: leftAnchor),
            logoGif.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
    
}
