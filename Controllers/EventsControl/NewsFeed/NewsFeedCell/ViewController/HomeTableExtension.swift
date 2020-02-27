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
    
    func tapedLabel(){
        
        userName.isUserInteractionEnabled = true
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.doSomethingOnTap))
        userName.addGestureRecognizer(labelTapGesture)
    }
    
    @objc func doSomethingOnTap() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        //Get the indexpath of cell where label was tapped
        let indexPath = (self.superview as! UITableView).indexPath(for: self)
        
        let v = EventModel(image: "rrr", title: "rrr", eventDescription: "rrr", userFirstName: UserStruct.userFirstName, userLastName: UserStruct.userLastName, userProfileImage: UserStruct.userProfileImageUrl , goingCount: 333, eventIdentifire: "vvv", goingUsers: ["fff"], userID: UserStruct.currentUserId, currntUserID: UserStruct.currentUserId, contactNumber: UserStruct.userContactNumber, userFBUrl: UserStruct.userFBUrl,eventAddedDate:UserStruct.eventAddedDate, userCurrentLocation: UserStruct.userCurrentLocation )
        
        if (self.delegate != nil) {
            self.delegate.callSegueFromCell(data: v, cellForRowAt: indexPath!)
        }
    }
}
