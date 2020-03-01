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

        //Set elements
        userProfileImage.roundedImage()
        postTitle.text = event.title
        eventDescription.text = event.eventDescription
        userName.text = event.userFirstName
        
        commentTextField.commentTextFieldUtilities()
        
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
        
        postButton.styleButton()
        postButton.buttonRadiusAll()
        
        userPorofileImage[0] = event.userProfileImage
        userFName[0] = event.userFirstName
        
        tapedLabel()
        setPLike(event:event)
        
        currentUserDetaiilsRetriving()
    }
    
    
    func setPLike(event: EventModel){
        
        let aa = CheckUserLoginStatus()
        
        if aa.checkUserLoginStatus() == true {
            UserStruct.currentUserId = Auth.auth().currentUser!.uid
            
            var flagC:[Bool] = [false]

            if event.goingUsers.count != 0 && event.goingCount != 0{
                for i in 0..<event.goingUsers.count {
                    
                    if event.goingUsers[i] ==  UserStruct.currentUserId  {
                        flagC[0] = true
                    }else{
                        flagC[0] = false
                    }
                }
                
                if flagC[0] == true{
                    
                    goingButton.goingButton(count: "\(goingCountNumber[0])")
                    
                    goingButton.tag = 1
                    
                    GoingCountStruct.goingOrNot = true
                    
                }else{
                    
                    goingButton.notGoing(count: "\(goingCountNumber[0])")
                    
                    goingButton.tag = 0
                    GoingCountStruct.goingOrNot = false
                }
            }
            else{
                
                goingButton.notGoing(count: "\(goingCountNumber[0])")
                goingButton.tag = 0
                GoingCountStruct.goingOrNot = false
                
            }
        }else{
            goingButton.notGoing(count: "\(goingCountNumber[0])")
            goingButton.isEnabled = false
        }
        
        
        
        
    }
    
    func currentUserDetaiilsRetriving(){
        
        if checkUserLoginStatus.checkUserLoginStatus() == true {
            CommentsStruct.userID  = Auth.auth().currentUser!.uid as String
            
            
        }else{
            postButton.isEnabled = false
            commentTextField.isEnabled = false
            //             goingButton.isEnabled = false
            
        }
    }
    
    func validateCommentTextField() -> String? {
        
        if commentTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            
        }
        return nil
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

