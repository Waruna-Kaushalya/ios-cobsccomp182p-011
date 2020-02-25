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
    
    let eventAtendingDB = EventAtendingDB()

    func setEvent(event: Event)  {
        
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
        
        tapedLabel()
        
    }
    func tapedLabel(){
        userName.isUserInteractionEnabled = true
        
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.doSomethingOnTap))
        
        userName.addGestureRecognizer(labelTapGesture)
    }
    
    @objc func doSomethingOnTap() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileViewController
        
        //        print("tapped")
        
        
        let v = User(userFirstName:   UserStruct.userFirstName, userLastName:   UserStruct.userLastName, userContactNumber:   UserStruct.userContactNumber, userFBUrl:    UserStruct.userFBUrl, userProfileImageUrl:    UserStruct.userProfileImageUrl, userID:   UserStruct.currentUserId)
        
        if (self.delegate != nil) { //Just to be safe.
            self.delegate.callSegueFromCell(data: v)
        }
    }
    
    
    @IBAction func btnGoing_Clicked(_ sender: UIButton) {
        //        print(currentUserId[0])
        let aa = CheckUserLoginStatus()
        
        if aa.checkUserLoginStatus() == true {
            if goingButton.tag == 0 {
                
                GoingCountStruct.goingOrNot = true
                
                goingButton.setImage(UIImage(named: "NotGoingBtn"), for: .normal)
                goingButton.tag = 1
                
                GoingCountStruct.goingCountNumber = GoingCountStruct.goingCountNumber + 1
                
                goingCountLabel.text = String ("Count " + "\(GoingCountStruct.goingCountNumber)")
                
                GoingCountStruct.goingCountNumber =  GoingCountStruct.goingCountNumber
                
                GoingCountStruct.goingUserList.append( UserStruct.currentUserId )
                eventAtendingDB.eventAtendingDB()
                //                lick()
                print("going")
                
            }else {
                
                GoingCountStruct.goingOrNot = false
                
                print("222222222222222222")
                
                goingButton.setImage(UIImage(named: "GoingBtn"), for: .normal)
                goingButton.tag = 0
                
                GoingCountStruct.goingCountNumber = GoingCountStruct.goingCountNumber - 1
                goingCountLabel.text = String ("Count " + "\(GoingCountStruct.goingCountNumber)")
                
                GoingCountStruct.goingCountNumber =  GoingCountStruct.goingCountNumber
                
                GoingCountStruct.goingUserList = GoingCountStruct.goingUserList.filter {$0 !=  UserStruct.currentUserId }
                
                eventAtendingDB.eventAtendingDB()
                //                lick()
                print("not going")
            }
            
        }else{
            UIAlertController(title: "Alert", message: "User must login", preferredStyle: .alert)
        }
        
    }
    
    func setPLike(event: Event){
        
        
        let aa = CheckUserLoginStatus()
        
        if aa.checkUserLoginStatus() == true {
            UserStruct.currentUserId = Auth.auth().currentUser!.uid
            
            GoingCountStruct.goingCountNumber =  event.goingCount
            GoingCountStruct.eventIdentifire = event.eventIdentifire
            
            GoingCountStruct.goingUserList  = event.goingUsers
            
            goingCountLabel.text = String ("Count " + "\(GoingCountStruct.goingCountNumber)")
            
            var flagC:[Bool] = [false]
            
            if GoingCountStruct.goingUserList.count != 0{
                for i in 0..<GoingCountStruct.goingUserList.count {
                    
                    if GoingCountStruct.goingUserList[i] ==   UserStruct.currentUserId  {
                        flagC[0] = true
                    }else{
                        flagC[0] = false
                    }
                }
                
                if flagC[0] == true{
                    goingButton.setImage(UIImage(named: "NotGoingBtn"), for: .normal)
                    goingButton.tag = 1
                    GoingCountStruct.goingOrNot = true
                    
                    print("3333333333333333333")
                }else{
                    GoingCountStruct.goingOrNot = false
                    print("4444444444444444444444")
                }
                
            }else{
                goingButton.isHidden = false
                
            }
        }
    }
}



