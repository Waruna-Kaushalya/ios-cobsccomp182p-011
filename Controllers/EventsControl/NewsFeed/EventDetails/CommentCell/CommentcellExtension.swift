//
//  CommentcellExtension.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 3/1/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import FirebaseAuth

extension CommentCell{
    func setComments(comment:CommentsModel){
        
        commentLabel.text = comment.comment
        userName.text = comment.userName
        let commentID = comment.commentID
        let comentUserID = comment.userID
        
        let url = URL(string: comment.userProfileImageURL ?? "")
        self.commenterProfileImage.kf.setImage(with: url)
        
        let currentUserIDD = Auth.auth().currentUser!.uid as String
        if currentUserIDD != comment.userID {
            commentDeleteBtn.isHidden = true
        }
        
    }
}
