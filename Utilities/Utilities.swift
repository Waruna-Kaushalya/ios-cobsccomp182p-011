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
    
    //Button
    
    static func styleButton(_ button:UIButton) {
        
        //Button backdround color
        button.backgroundColor = UIColor.init(red: 0/255, green: 148/255, blue: 253/255, alpha: 1)
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

class TextFieldUtilities {
    static func styleTextField(_ textfield:UITextField ) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 0/255, green: 148/255, blue: 253/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func TextFieldRadius_All(_ textField:UITextField){
        //button corner radius
        textField.layer.cornerRadius = 9
        textField.clipsToBounds = true
        textField.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
    }
    
    static func TextFieldRadius_MinX_MinY_MaxX_MinY(_ textField:UITextField){
        //button corner radius
        textField.layer.cornerRadius = 9
        textField.clipsToBounds = true
        textField.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
    }
    static func TextFieldRadius_MaxX_MinY_MaxX_MaxY(_ textField:UITextField){
        //button corner radius
        textField.layer.cornerRadius = 9
        textField.clipsToBounds = true
        textField.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
    }
}


class PasswordUtilities {
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}

