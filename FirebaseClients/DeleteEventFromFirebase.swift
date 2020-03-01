//
//  DeleteEventFromFirebase.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/29/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation

import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class DeleteEventFromFirebase{
   static func DeleteEvent(eventIdentifire:String){
        let db = Firestore.firestore()

        db.collection("event").whereField("eventID", isEqualTo:eventIdentifire).getDocuments() { (querySnapshot, err) in
            if let err = err {
                UpdateEventStruct.flag = false
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    document.reference.delete()
                    UpdateEventStruct.flag = true
                }
            }
        }
    }
}
