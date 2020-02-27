//
//  CheckUserLoginStatus.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/12/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import FirebaseAuth

class CheckUserLoginStatus {
    
    
    func checkUserLoginStatus() -> Bool {
        var test = true
        
        if Auth.auth().currentUser != nil {
            test = true
            //print("true")
            
        }else{
            //print("user not log iN")
            
            test = false
            //print("false")
            
        }
        return test
    }
}
