//
//  UserData.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/21/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import UIKit



class UserModel {
    
    var userFirstName:String
    var userLastName:String
    var userContactNumber:String
    var userFBUrl:String
    var userProfileImageUrl:String
    
    var userID :String
    
    
    init(userFirstName:String, userLastName:String,userContactNumber:String,userFBUrl:String,userProfileImageUrl:String,userID:String) {
        
        self.userFirstName = userFirstName
        self.userLastName = userLastName
        self.userContactNumber = userContactNumber
        self.userFBUrl = userFBUrl
        self.userProfileImageUrl = userProfileImageUrl
        self.userID = userID
        
        
        
    }
}
