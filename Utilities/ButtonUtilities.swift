//
//  Utilities.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/7/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import UIKit

class ButtonUtilities {
    
    static func styleButton(_ button:UIButton) {
        let lightBlue = UIColor(red: 0/255, green: 148/255, blue: 253/255, alpha: 1)
        //Button backdround color
        button.backgroundColor = lightBlue
        //Button title color
        button.setTitleColor(UIColor.white, for: .normal)
        
        //Button Border
        //        button.layer.borderWidth = 1
        //        button.layer.borderColor = UIColor.black.cgColor
        
        
    }
    static func ButtonRadius_All(_ button:UIButton){
        //button corner radius
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
    }
    
    static func ButtonRadius_MinX_MinY_MaxX_MinY(_ button:UIButton){
        //button corner radius
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
    }
    static func ButtonRadius_MaxX_MinY_MaxX_MaxY(_ button:UIButton){
        //button corner radius
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
    }
}
