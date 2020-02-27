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


class AddEventDataFireBase {
    
    
    func addEventDataToFirebase()  {
        
        
        var goingCount:Int = 0
        var goingUsers = [String]()
        
        //Sort table view as newst date

        let eventAddedDate = Currentdate.getCurrentDate()
        
        let db = Firestore.firestore()
        db.collection("event").addDocument(data: ["userID":CreateEventStruct.userID,"eventtitle":CreateEventStruct.eventTitleTxt,"eventdescription":CreateEventStruct.eventDescriptionTxt,"eventImageUrl":CreateEventStruct.metaImageUrl,"eventID":CreateEventStruct.eventID ,"goingCount":goingCount,"goingUsers":goingUsers,"eventAddedDate":eventAddedDate,"userCurrentLocation": CreateEventStruct.userCurrentLocation ]) { (error) in
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
