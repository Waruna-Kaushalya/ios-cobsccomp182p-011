//
//  Utilities.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/7/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//


import UIKit

extension UIButton {
    
    func styleButton() {
        let lightBlue = UIColor(red: 0/255, green: 148/255, blue: 253/255, alpha: 1)
        //Button backdround color
        self.backgroundColor = lightBlue
        //Button title color
        self.setTitleColor(UIColor.white, for: .normal)
        
        //Button Border
        //        button.layer.borderWidth = 1
        //        button.layer.borderColor = UIColor.black.cgColor
        
        
    }
    func buttonRadiusAll(){
        //button corner radius
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
    }
    
    func buttonRadius_MinX_MinY_MaxX_MinY(){
        //button corner radius
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
    }
    func buttonRadius_MaxX_MinY_MaxX_MaxY(){
        //button corner radius
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
    }
}
