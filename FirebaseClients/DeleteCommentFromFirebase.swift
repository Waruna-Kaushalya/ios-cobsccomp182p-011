//
//  DeleteCommentFromFirebase.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 3/1/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation

import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class DeleteCommentFromFirebase{
    static func DeleteComment(commentIdentifier:String){
        let db = Firestore.firestore()
        
        db.collection("comments").whereField("commentID", isEqualTo: commentIdentifier).getDocuments() { (querySnapshot, err) in
            if let err = err {
                CommentDeleteStruct.flag = false
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    document.reference.delete()
                    print("gone")
                    CommentDeleteStruct.flag = true
                }
            }
        }
    }
}
