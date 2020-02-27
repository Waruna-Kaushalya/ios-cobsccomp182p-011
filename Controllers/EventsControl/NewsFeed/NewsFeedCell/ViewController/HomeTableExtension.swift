//
//  HomeTableExtension.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/27/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage


extension HomeTableViewCell {
    
    func setEvent(event: EventModel)  {
        
        
        print(event.goingCount)
        print(event.goingUsers.count)
        
        //Set elements
        userProfileImage.roundedImage()
        postTitle.text = event.title
        eventDescription.text = event.eventDescription
        userName.text = event.userFirstName
        goingCountLabel.text = String (event.goingCount)
        eventAddedDate.text = event.eventAddedDate
        
        let url = URL(string: event.iamage ?? "")
        self.postImageView.kf.setImage(with: url)
        
        let uurl = URL(string: event.userProfileImage ?? "")
        self.userProfileImage.kf.setImage(with: uurl)
        
        UserStruct.userFirstName = event.userFirstName
        UserStruct.userLastName = event.userLastName
        UserStruct.userContactNumber = event.contactNumber
        UserStruct.userFBUrl = event.userFBUrl
        UserStruct.userProfileImageUrl = event.userProfileImage
        UserStruct.currentUserId = event.userID
        
        eventIdentifire[0] = event.eventIdentifire
        goingCountNumber[0] = event.goingCount
        goingUserList =  event.goingUsers
        
        tapedLabel()
        setPLike(event:event)
    }
    
    
    func setPLike(event: EventModel){
        
        let aa = CheckUserLoginStatus()
        
        if aa.checkUserLoginStatus() == true {
            UserStruct.currentUserId = Auth.auth().currentUser!.uid
            
            var flagC:[Bool] = [false]
            
            print(event.goingUsers.count)
            print(event.goingCount)
            
            if event.goingUsers.count != 0 && event.goingCount != 0{
                for i in 0..<event.goingUsers.count {
                    
                    if event.goingUsers[i] ==  UserStruct.currentUserId  {
                        flagC[0] = true
                    }else{
                        flagC[0] = false
                    }
                }
                
                if flagC[0] == true{
                    goingButton.setImage(UIImage(named: "GoingToEventBtn"), for: .normal)
                    goingButton.tag = 1
                    
                    GoingCountStruct.goingOrNot = true
                    
                }else{
                    goingButton.setImage(UIImage(named: "NotGoingToEventBtn"), for: .normal)
                    goingButton.tag = 0
                    GoingCountStruct.goingOrNot = false
                }
            }
            else{
                
                goingButton.setImage(UIImage(named: "NotGoingToEventBtn"), for: .normal)
                goingButton.tag = 0
                GoingCountStruct.goingOrNot = false
                
            }
        }else{
            goingButton.isHidden = false
        }
    }
}
