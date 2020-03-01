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
        
        
        let blue =  UIColor(red: 20/255, green: 168/255, blue: 255/255, alpha: 1.0) /* #14a8ff */
        
        //        let lightBlue = UIColor(red: 0/255, green: 148/255, blue: 253/255, alpha: 1)
        let red = UIColor(red: 255/255, green: 51/255, blue: 51/255, alpha: 1)
        
        //Button backdround color
        self.backgroundColor = blue
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
    
    func goingButton(count:String) {
        
        //Green
        let setClor = UIColor(red: 23/255, green: 196/255, blue: 104/255, alpha: 1.0) /* #17c468 */
        
        self.setTitle("Going" + " " + "\(count)", for: .normal)
        
        //Button backdround color
        self.backgroundColor = setClor
        //Button title color
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font =  UIFont(name: "HelveticaNeue-Bold", size: 18)
        
        //Button Border
        self.layer.borderWidth = 1
        self.layer.borderColor = setClor.cgColor
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
    }
    
    func notGoing(count:String) {
        
        //Green
        let setClor = UIColor(red: 23/255, green: 196/255, blue: 104/255, alpha: 1.0) /* #17c468 */
        
        self.setTitle("Going" + " " + "\(count)", for: .normal)
        
        let white = UIColor.white
        //Button backdround color
        self.backgroundColor = white
        //Button title color
        self.setTitleColor(setClor, for: .normal)
        self.titleLabel?.font =  UIFont(name: "HelveticaNeue-Bold", size: 18)
        
        //Button Border
        self.layer.borderWidth = 1
        self.layer.borderColor = setClor.cgColor
        
        self.layer.cornerRadius = 10
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
