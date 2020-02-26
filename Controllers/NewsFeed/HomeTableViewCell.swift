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
    @IBOutlet weak var goingCountLabel: UILabel!
    
    
    var delegate:CellDelegator!
    
    var eventIdentifire:[String] = [""]
    
    let eventAtendingDB = PushGoingDataFirbase()
    
    func setEvent(event: Event)  {
        
        
        
        //Set elements
        userProfileImage.roundedImage()
        postTitle.text = event.title
        eventDescription.text = event.eventDescription
        userName.text = event.userFirstName
        
        
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
        
        GoingCountStruct.eventIdentifire = event.eventIdentifire
        GoingCountStruct.goingCountNumber =  event.goingCount
        
        print("====================111111================================")
        print(GoingCountStruct.goingCountNumber )
         print("======================111111===============================")
        GoingCountStruct.goingUserList  = event.goingUsers
        
        eventIdentifire[0] = event.eventIdentifire
        
        GoingCountStruct.eventID =  eventIdentifire[0]
        
        goingCountLabel.text = String ("Count " + "\(GoingCountStruct.goingCountNumber)")
        
        tapedLabel()
        
        setPLike(event:event)
        
    }
    func setPLike(event: Event){
        
        
        let aa = CheckUserLoginStatus()
        
        if aa.checkUserLoginStatus() == true {
            UserStruct.currentUserId = Auth.auth().currentUser!.uid
            
            
            var flagC:[Bool] = [false]
            
            if GoingCountStruct.goingUserList.count != 0 && GoingCountStruct.goingCountNumber != 0{
                for i in 0..<GoingCountStruct.goingUserList.count {
                    
                    if GoingCountStruct.goingUserList[i] ==  UserStruct.currentUserId  {
                        flagC[0] = true
                    }else{
                        flagC[0] = false
                    }
                }
                
                if flagC[0] == true{
                    goingButton.setImage(UIImage(named: "NotGoingBtn"), for: .normal)
                    goingButton.tag = 1
                    
                    GoingCountStruct.goingOrNot = true
                    
                }else{
                    goingButton.setImage(UIImage(named: "GoingBtn"), for: .normal)
                    goingButton.tag = 0
                    GoingCountStruct.goingOrNot = false
                }
            }
            else{
                
                goingButton.setImage(UIImage(named: "GoingBtn"), for: .normal)
                goingButton.tag = 0
                GoingCountStruct.goingOrNot = false
                
            }
        }else{
            goingButton.isHidden = false
        }
    }
    
    
    @IBAction func btnGoing_Clicked(_ sender: UIButton) {
        
        let aa = CheckUserLoginStatus()
        if aa.checkUserLoginStatus() == true {
            if goingButton.tag == 0 {
                
                GoingCountStruct.goingOrNot = true
                
                goingButton.setImage(UIImage(named: "NotGoingBtn"), for: .normal)
                goingButton.tag = 1
                
                GoingCountStruct.goingCountNumber = GoingCountStruct.goingCountNumber + 1
                
                print("===================222222=================================")
                print(GoingCountStruct.goingCountNumber )
                print("======================222222===============================")
                
                goingCountLabel.text = String ("Count " + "\(GoingCountStruct.goingCountNumber)")
                
                GoingCountStruct.goingUserList.append(UserStruct.currentUserId)
                
                GoingCountStruct.eventID =  eventIdentifire[0]
                
                //Push data to firebase
                eventAtendingDB.eventAtendingDB(eventIdentifire: eventIdentifire[0])
                
                print("going")
                
            }else {
                
                GoingCountStruct.goingOrNot = false
                
                goingButton.setImage(UIImage(named: "GoingBtn"), for: .normal)
                goingButton.tag = 0
                
                GoingCountStruct.goingCountNumber = GoingCountStruct.goingCountNumber - 1
                
                print("=====================333333===============================")
                print(GoingCountStruct.goingCountNumber )
                print("======================333333===============================")
                
                goingCountLabel.text = String ("Count " + "\(GoingCountStruct.goingCountNumber)")
                
                GoingCountStruct.goingUserList = GoingCountStruct.goingUserList.filter {$0 !=  UserStruct.currentUserId }
                
                GoingCountStruct.eventID =  eventIdentifire[0]
                
                //Push data to firebase
                eventAtendingDB.eventAtendingDB(eventIdentifire: eventIdentifire[0])
                print("not going")
            }
            
        }else{
            UIAlertController(title: "Alert", message: "User must login", preferredStyle: .alert)
        }
        
    }
    
    
    func tapedLabel(){
        
        userName.isUserInteractionEnabled = true
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.doSomethingOnTap))
        userName.addGestureRecognizer(labelTapGesture)
    }
    
    @objc func doSomethingOnTap() {
        
        
        //        print("tapped")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        //Get the indexpath of cell where button was tapped
        
        let indexPath = (self.superview as! UITableView).indexPath(for: self)
        
        let destination = storyboard.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileViewController
        
        
        let v = Event(image: "rrr", title: "rrr", eventDescription: "rrr", userFirstName: UserStruct.userFirstName, userLastName: UserStruct.userLastName, userProfileImage: UserStruct.userProfileImageUrl , goingCount: 333, eventIdentifire: "vvv", goingUsers: ["fff"], userID: UserStruct.currentUserId, currntUserID: UserStruct.currentUserId, contactNumber: UserStruct.userContactNumber, userFBUrl: UserStruct.userFBUrl,eventAddedDate:UserStruct.eventAddedDate )
        
        //        let v = Eve(userFirstName:   UserStruct.userFirstName, userLastName:   UserStruct.userLastName, userContactNumber:   UserStruct.userContactNumber, userFBUrl:    UserStruct.userFBUrl, userProfileImageUrl:    UserStruct.userProfileImageUrl, userID:   UserStruct.currentUserId)
        
        if (self.delegate != nil) {
            self.delegate.callSegueFromCell(data: v, cellForRowAt: indexPath!)
        }
    }
}



