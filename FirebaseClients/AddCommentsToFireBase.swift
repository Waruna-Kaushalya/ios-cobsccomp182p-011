//
//  AddCommentsToFireBase.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/27/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation

import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class AddCommentsToFireBase {
    
    func addCommentsToFireBase()  {
        
        let commentDate = Currentdate.getCurrentDate()
        
//        let userID : String = (Auth.auth().currentUser?.uid)!
        
        let db = Firestore.firestore()
        db.collection("comments").addDocument(data: ["commentID":Comments.commentID,"EventID":Comments.EventID,"userID":Comments.userID,"userName":Comments.userName,"userProfileImageURL":Comments.userProfileImageURL,"comment":Comments.comment,"commentDate":commentDate]) { (error) in
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

