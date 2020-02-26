//
//  PushEventDataFireBase.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/25/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage


class PushDataToFireBase {
    
    
    func pushDataToFireBase()  {
        
        
        var goingCount:Int = 0
        var goingUsers = [String]()
        
        //Sort table view as newst date
        
        let formatter = DateFormatter()
    
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date())
      
        let yourDate = formatter.date(from: myString)
      
        formatter.dateFormat = "dd/MMM/yyyy HH:mm:ss"
        
        let eventAddedDate = formatter.string(from: yourDate!)
        
        print(eventAddedDate)
        

        
        let db = Firestore.firestore()
        db.collection("event").addDocument(data: ["userID":CreateEventStruct.userID,"eventtitle":CreateEventStruct.eventTitleTxt,"eventdescription":CreateEventStruct.eventDescriptionTxt,"eventImageUrl":CreateEventStruct.metaImageUrl,"eventID":CreateEventStruct.eventID ,"goingCount":goingCount,"goingUsers":goingUsers,"eventAddedDate":eventAddedDate ]) { (error) in
            if error != nil {
                
                
                print("err saving data")
                CreateEventStruct.flag = false
                
                
            }else{
                
                 print("done")
                CreateEventStruct.flag = true
                
            }
        }
    }
}
