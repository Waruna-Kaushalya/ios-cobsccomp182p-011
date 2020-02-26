//
//  eventImage.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/19/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import UIKit

class Event {
    var iamage: String
    var title: String
    var eventDescription: String
    
    var userFirstName:String
    var userLastName:String
    var userProfileImage:String
    var goingCount:Int
    var eventIdentifire:String
    var goingUsers = [String]()
    var userID: String
    var currntUserID:String
    var contactNumber:String
    var userFBUrl:String
    var eventAddedDate:String
    
    
    init(image:String, title:String,eventDescription:String,userFirstName:String,userLastName:String,userProfileImage:String,goingCount:Int,eventIdentifire:String,goingUsers:[String],userID:String,currntUserID:String,contactNumber:String,userFBUrl:String,eventAddedDate:String) {
        
        self.iamage = image
        self.title = title
        self.eventDescription = eventDescription
        self.userFirstName = userFirstName
        self.userLastName = userLastName
        self.userProfileImage = userProfileImage
        self.goingCount = goingCount
        self.eventIdentifire = eventIdentifire
        self.goingUsers = goingUsers
        self.userID = userID
        self.currntUserID = currntUserID
        self.contactNumber = contactNumber
        self.userFBUrl = userFBUrl
        self.eventAddedDate = eventAddedDate
        

    }
}



