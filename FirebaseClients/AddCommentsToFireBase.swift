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
        
        let db = Firestore.firestore()
        db.collection("comments").addDocument(data: ["commentID":CommentsStruct.commentID,"EventID":CommentsStruct.EventID,"userID":CommentsStruct.userID,"userName":CommentsStruct.userName,"userProfileImageURL":CommentsStruct.userProfileImageURL,"comment":CommentsStruct.comment,"commentDate":commentDate]) { (error) in
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

