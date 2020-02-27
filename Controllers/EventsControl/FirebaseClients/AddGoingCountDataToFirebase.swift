//
//  EventAtendingDB.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/25/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//


import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage

class AddGoingCountDataToFirebase{
    func addGoingCountDataToFirebase(eventIdentifire:String){
        
        let db = Firestore.firestore()
        db.collection("event").whereField("eventID", isEqualTo:  eventIdentifire)
            .addSnapshotListener { querySnapshot, error in
                
                
                print(eventIdentifire)
                guard (querySnapshot?.documents) != nil else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                let document = querySnapshot!.documents.first
                
                document!.reference.updateData(["goingCount":  GoingCountStruct.goingCountNumber])
                
                
                document!.reference.updateData(["goingUsers":  GoingCountStruct.goingUserList])
        }
    }
}
