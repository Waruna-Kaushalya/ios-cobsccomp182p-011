//
//  GoingButton.swift
//  NIBM EventsUITests
//
//  Created by Waruna Kaushalya on 2/28/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit

extension UIButton {
    
    func goingButton() {
        
        self.setTitle("Going", for: .normal)
        
        let white = UIColor.white
        //Button backdround color
        self.backgroundColor = white
        //Button title color
        self.setTitleColor(UIColor.green, for: .normal)
        
        //Button Border
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.green.cgColor
        
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
        
    }
}
