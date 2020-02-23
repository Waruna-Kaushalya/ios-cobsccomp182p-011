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
    
    init(image:String, title:String,eventDescription:String,userName:String,userProfileImage:String) {
        
        self.iamage = image
        self.title = title
        self.eventDescription = eventDescription
        self.userName = userName
        self.userProfileImage = userProfileImage
        

    }
}



