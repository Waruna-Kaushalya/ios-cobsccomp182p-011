//
//  HomeTableViewCell.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/19/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage



class HomeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var goingButton: UIButton!
    @IBOutlet weak var eventAddedDate: UILabel!
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    var delegate:CellDelegator!
    
    var eventIdentifire:[String] = [""]
    var goingCountNumber:[Int] = [0]
    var goingUserList:[String] = [""]
    var userPorofileImage:[String] = [""]
    var userFName:[String] = [""]
    
    let alertMSG = AlertMessages()
    let checkUserLoginStatus = CheckUserLoginStatus()
    
    let eventAtendingDB = AddGoingCountDataToFirebase()
    
    
    @IBAction func btnGoing_Clicked(_ sender: UIButton) {
        
        let aa = CheckUserLoginStatus()
        if aa.checkUserLoginStatus() == true {
            if goingButton.tag == 0 {
                
                GoingCountStruct.goingOrNot = true
                
                goingButton.tag = 1
                
                goingCountNumber[0] = goingCountNumber[0] + 1
                
                goingButton.goingButton(count: "\(goingCountNumber[0])")
                
                GoingCountStruct.goingCountNumber =  goingCountNumber[0]
                
                goingUserList.append(UserStruct.currentUserId)
                
                GoingCountStruct.goingUserList = goingUserList
                
                GoingCountStruct.eventID =  eventIdentifire[0]
                
                //Push data to firebase
                eventAtendingDB.addGoingCountDataToFirebase(eventIdentifire: eventIdentifire[0])
                
            }else {
                
                GoingCountStruct.goingOrNot = false
                
                goingButton.tag = 0
                
                goingCountNumber[0] = goingCountNumber[0] - 1
                
                goingButton.notGoing(count: "\(goingCountNumber[0])")
                
                GoingCountStruct.goingCountNumber =  goingCountNumber[0]
                
                goingUserList = goingUserList.filter {$0 !=  UserStruct.currentUserId }
                
                GoingCountStruct.goingUserList = goingUserList
                
                GoingCountStruct.eventID =  eventIdentifire[0]
                
                //Push data to firebase
                eventAtendingDB.addGoingCountDataToFirebase(eventIdentifire: eventIdentifire[0])
                
            }
            
        }else{
            UIAlertController(title: "Alert", message: "User must login", preferredStyle: .alert)
        }
    }
    
    @IBAction func postButtonAction(_ sender: Any) {
        
        let error = validateCommentTextField()
        
        if error != nil{
           print("textFildEmpty")
        }else{
            
            Comments.EventID =  eventIdentifire[0]
            
            Comments.userProfileImageURL = userPorofileImage[0]
            
            Comments.userName = userFName[0]
            
            let uuid = UUID().uuidString
            Comments.commentID = uuid
            
            Comments.comment = commentTextField.text!
            
            let commentAdd = AddCommentsToFireBase()
            
            commentAdd.addCommentsToFireBase()
            
        }
    }
}
