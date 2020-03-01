//
//  Currentdate.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/27/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation


class Currentdate {
    
    static func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let myString = formatter.string(from: Date())
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd/MMM/yyyy HH:mm"
        let eventAddedDate = formatter.string(from: yourDate!)
        
        return eventAddedDate
    }
}
