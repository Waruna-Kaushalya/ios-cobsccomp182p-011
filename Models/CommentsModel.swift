//
//  CommentsModel.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/27/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation

class CommentsModel {
    
    var commentID:String
    var EventID:String
    var userID:String
    var userName:String
    var userProfileImageURL:String
    var comment:String
    var commentDate:String
    
    init(commentID:String, EventID:String,userName:String,userID:String,userProfileImageURL:String,comment:String,commentDate:String) {
        
        self.commentID = commentID
        self.EventID = EventID
        self.userID = userID
        self.userName = userName
        self.userProfileImageURL = userProfileImageURL
        self.comment = comment
        self.commentDate = commentDate
        
    }
}
