//
//  ElementsStyle.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/10/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField



class TextFieldUtilities {
    
    static func setTextFieldStyle(_textFieldsName:SkyFloatingLabelTextField,_placeHolder:String)  {
        
        let lightBlue = UIColor(red: 0/255, green: 148/255, blue: 253/255, alpha: 1)
        let lightBlue2 = UIColor(red: 0/255, green: 140/255, blue: 250/255, alpha: 1)
        let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
        let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
        let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
        
        _textFieldsName.placeholder = _placeHolder
        _textFieldsName.title = _placeHolder
        
        
        _textFieldsName.tintColor =   lightBlue2  //overcastBlueColor
        _textFieldsName.textColor =    darkGreyColor
        _textFieldsName.lineColor =   lightBlue2  //lightGreyColor
        _textFieldsName.selectedTitleColor = lightBlue2 //overcastBlueColor
        _textFieldsName.selectedLineColor = lightBlue //overcastBlueColor
        
        _textFieldsName.lineHeight = 1.0
        _textFieldsName.selectedLineHeight = 2.0
        
    }
    
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
