//
//  MyProfileEventModel.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 3/1/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import UIKit

class MyEventModel {
    var iamage: String
    var title: String
    var goingCount:Int
    var eventDate:String
    
    init(image:String, title:String,goingCount:Int,eventDate:String) {
        
        self.iamage = image
        self.title = title
        self.goingCount = goingCount
        self.eventDate = eventDate
        
    }
}




