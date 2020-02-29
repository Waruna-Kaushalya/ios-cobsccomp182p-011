//
//  UpdateEventDataToFirebase.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/27/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage

class UpdateEventDataToFirebase{
    static func updateEventDataToFirebase(eventIdentifire:String){
        
        let db = Firestore.firestore()
        db.collection("event").whereField("eventID", isEqualTo:  eventIdentifire)
            .addSnapshotListener { querySnapshot, error in
                
                if error != nil {
                    
                    print("err saving data")
                    CreateEventStruct.flag = false
                    
                }else{
                    
                    guard (querySnapshot?.documents) != nil else {
                        print("Error fetching documents: \(error!)")
                        return
                    }
                    let document = querySnapshot!.documents.first
                    
                    document!.reference.updateData(["eventdescription" : UpdateEventStruct.eventDescription])
                    
                    document!.reference.updateData(["eventtitle" : UpdateEventStruct.eventTitle])
                    
                    print("done")
                    CreateEventStruct.flag = true
                    
                }
                
                
        }
    }
}
