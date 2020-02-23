//
//  UserData.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/21/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import UIKit

//class UserData {
//    static let eventTitle = UserData()
//    static let eventDescription = UserData()
//    static let eventImageUrl = UserData()
//
//
//    static let userID = UserData()
//    static let firstName = UserData()
//    static let lastName = UserData()
//    static let fbUrl = UserData()
//
//    var one: String {
//        get {
//            return UserDefaults.standard.object(forKey: "userdata") as? String ?? ""
//        }
//        set(newValue) {
//            UserDefaults.standard.set(newValue, forKey: "userData")
//        }
//    }
//}


class aFileName {
    // this stores the actual data, do not access it directly, consider it private
   static var theFileName: String?
    
    // this is the real interface
    var fileName: String {
        get {
            return aFileName.theFileName!
        }
        set(name) {
            aFileName.theFileName = name
//            print(name)
        }
    }
}
