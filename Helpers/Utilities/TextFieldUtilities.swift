//
//  ElementsStyle.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/10/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    func styleTextField() {
        
        let blue =  UIColor(red: 20/255, green: 168/255, blue: 255/255, alpha: 1.0)
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 2)
        
        bottomLine.backgroundColor =  blue.cgColor
        
        // Remove border on text field
        self.borderStyle = .none
        
        // Add the line to the text field
        self.layer.addSublayer(bottomLine)
        
    }
    func textFieldRadius_All(){
        //button corner radius
        self.layer.cornerRadius = 9
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
    }
    
    func textFieldRadius_MinX_MinY_MaxX_MinY(_ textField:UITextField){
        //button corner radius
        self.layer.cornerRadius = 9
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
    }
    func textFieldRadius_MaxX_MinY_MaxX_MaxY(_ textField:UITextField){
        //button corner radius
        self.layer.cornerRadius = 9
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
    }
    
    func commentTextFieldUtilities(){
        
        let blue =  UIColor(red: 20/255, green: 168/255, blue: 255/255, alpha: 1.0)
        //Border
        self.layer.borderWidth = 1
        self.layer.borderColor = blue.cgColor
        
        self.layer.cornerRadius = 9
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
    }
}
