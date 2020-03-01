//
//  RetrieveCurrentUserDetails.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/27/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestore

class RetrieveCurrentUserDetails{
    
   static func retrieveCurrentUserDetailsFromFirebase(){
        
        let docRef = Firestore.firestore().collection("users").whereField("uid", isEqualTo: CommentsStruct.userID )
        
        docRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            } else if querySnapshot!.documents.count != 1 {
                print("More than one documents or none")
            } else {
                let document = querySnapshot!.documents.first
                let dataDescription = document?.data()
                
                CommentsStruct.userName = dataDescription?["firstname"] as! String
                CommentsStruct.userProfileImageURL = dataDescription?["imageURL"] as! String
                
                
                if GoingCountStruct.goingUserList.count != 0  {
                    
                }
                else{
                    GoingCountStruct.goingCountNumber = 0
                }
            }
        }
    }
}
