//
//  CommentTableViewCell.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/27/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import FirebaseAuth

class CommentCell: UITableViewCell {
  
    
    @IBOutlet weak var commenterProfileImage: UIImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var commentDeleteBtn: UIButton!
    
    var currentCell:[CommentsModel] = []
    

    @IBAction func deleteComment(_ sender: Any) {
        
        
        let indexPath = (self.superview as! UITableView).indexPath(for: self)
        
        let currentDataFromCell:CommentsModel = currentCell[indexPath!.row]
        
        DeleteCommentFromFirebase.DeleteComment(commentIdentifier: currentDataFromCell.commentID)
        
       
        if CommentDeleteStruct.flag == true{
         
        }
        else{
            
        }
    }
    
}
