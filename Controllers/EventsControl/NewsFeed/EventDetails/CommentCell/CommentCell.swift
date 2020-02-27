//
//  CommentTableViewCell.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/27/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var commenterProfileImage: UIImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    func setComments(comment:CommentsModel){
        
        commentLabel.text = comment.comment
        userName.text = comment.userName
        
        let url = URL(string: comment.userProfileImageURL ?? "")
        self.commenterProfileImage.kf.setImage(with: url)
    }
    
}
