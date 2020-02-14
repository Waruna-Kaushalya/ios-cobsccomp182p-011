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
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 0/255, green: 148/255, blue: 253/255, alpha: 1).cgColor
        
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
}




//
//class TextFieldUtilities {
//
//    static func styleTextField(_ textfield:UITextField ) {
//
//        // Create the bottom line
//        let bottomLine = CALayer()
//
//        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
//
//        bottomLine.backgroundColor = UIColor.init(red: 0/255, green: 148/255, blue: 253/255, alpha: 1).cgColor
//
//        // Remove border on text field
//        textfield.borderStyle = .none
//
//        // Add the line to the text field
//        textfield.layer.addSublayer(bottomLine)
//
//    }
//
//    static func TextFieldRadius_All(_ textField:UITextField){
//        //button corner radius
//        textField.layer.cornerRadius = 9
//        textField.clipsToBounds = true
//        textField.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner,.layerMaxXMaxYCorner]
//
//    }
//
//    static func TextFieldRadius_MinX_MinY_MaxX_MinY(_ textField:UITextField){
//        //button corner radius
//        textField.layer.cornerRadius = 9
//        textField.clipsToBounds = true
//        textField.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
//
//    }
//    static func TextFieldRadius_MaxX_MinY_MaxX_MaxY(_ textField:UITextField){
//        //button corner radius
//        textField.layer.cornerRadius = 9
//        textField.clipsToBounds = true
//        textField.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
//
//    }
//}
