//
//  MyProfileExtension.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/28/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import Kingfisher

extension MyProfileViewController{
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if checkUserLoginStatus.checkUserLoginStatus() != true {
            let alert = AlertMessages()
            alert.ActionAlert(_title: "User not login", _message: "User must login to view profile", _viewCIdentifier: "LoginNavIVC", _viewControllerName: self)
        }else{
            let athentication = TouchFaceIDAuthentication()
            
            athentication.authenticateUser(_viewIdentifire: "HomeVC", _viewFrom: self)
        }
        
        setElements()
        setData()
        
    }
    func setData(){
        let abcd = getData()
        
        abcd.read({ (document) in
            let url = URL(string: document)
            self.profileImage.kf.setImage(with: url)
        }, _fieldname: "imageURL")
        
        
        abcd.read({ (document) in
            
            print(document)
            
            self.nameTextlabel.text = document
            
        }, _fieldname: "firstname")
        
        
        abcd.read({ (document) in
            
            print(document)
            
            self.contactNumberTextLabel.text = document
            
        }, _fieldname: "phoneNumber")
    }
    
    func setElements(){
        profileImage.roundedImage()
        
    }
}
