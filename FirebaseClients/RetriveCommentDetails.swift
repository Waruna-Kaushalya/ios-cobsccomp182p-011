//
//  RetriveCommentDetails.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 3/1/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

//class RetriveCommentDetails  {
//    static func retrieveComments(EventID:String){
//        
//        self.commentsList.removeAll()
//        
//        let dataRef = Firestore.firestore().collection("comments").whereField("EventID", isEqualTo: EventID)
//        dataRef.getDocuments { (querySnapshot, err) in
//            
//            for document in querySnapshot!.documents {
//                
//                let dataDescription = document.data()
//                
//                let commentIDV = dataDescription["commentID"] as? String
//                let EventIDV = dataDescription["EventID"] as? String
//                let userIDV = dataDescription["userID"] as? String
//                let userNameV = dataDescription["userName"] as? String
//                let userProfileImageURLV = dataDescription["userProfileImageURL"] as? String
//                let commentV = dataDescription["comment"] as? String
//                let commentDate = dataDescription["commentDate"] as? String
//                
//                let comment:CommentsModel = CommentsModel(commentID: commentIDV!, EventID: EventIDV!, userName: userNameV!, userID: userIDV!, userProfileImageURL: userProfileImageURLV!, comment: commentV!, commentDate:commentDate! )
//                
//                DispatchQueue.main.async {
//                    self.commentsList.append(comment)
//                    self.commentsList.sort(by: {$0.commentDate > $1.commentDate})
//                    self.commentTableView.reloadData()
//                }
//            }
//        }
//    }
//}
