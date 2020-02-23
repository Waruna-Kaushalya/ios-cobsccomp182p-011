//
//  eventImage.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/19/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import UIKit

class Video {
    var iamage: String
    var title: String
    var eventDescription: String
    
    var userName:String
    var userProfileImage:String
    var goingCount:Int
    var eventIdentifire:String
    var goingUsers = [String]()
    var userID: String
    var currntUserID:String
    
    init(image:String, title:String,eventDescription:String,userName:String,userProfileImage:String,goingCount:Int,eventIdentifire:String,goingUsers:[String],userID:String,currntUserID:String) {
        
        self.iamage = image
        self.title = title
        self.eventDescription = eventDescription
        self.userName = userName
        self.userProfileImage = userProfileImage
        self.goingCount = goingCount
        self.eventIdentifire = eventIdentifire
        self.goingUsers = goingUsers
        self.userID = userID
        self.currntUserID = currntUserID
        

    }
}



