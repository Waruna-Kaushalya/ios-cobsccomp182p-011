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
    
  
    
    let eventAtendingDB = PushGoingDataFirbase()
    
    func setEvent(event: Event)  {
        
        userProfileImage.roundedImage()
        
        postTitle.text = event.title
        
        eventDescription.text = event.eventDescription
        
        userName.text = event.userFirstName
        
        let url = URL(string: event.iamage ?? "")
        self.postImageView.kf.setImage(with: url)
        
        let uurl = URL(string: event.userProfileImage ?? "")
        self.userProfileImage.kf.setImage(with: uurl)
        
//        let FirstName = event.userFirstName
//
//        let LastName = event.userLastName
        
        UserStruct.userFirstName = event.userFirstName
        UserStruct.userLastName = event.userLastName
        
//        print("===================================")
//        print(FirstName)
//         print(LastName)
//         print("===================================")
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
        
        //Get the indexpath of cell where button was tapped
//                    let indexPath = self.collectionView.indexPathForCell(cell)
//                    print(indexPath!.row)
        
        let indexPath = (self.superview as! UITableView).indexPath(for: self)
        print("00000000000000000000004004004000404004400404044000404")
        print(indexPath?.row)

        
        let destination = storyboard.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileViewController
        
        //        print("tapped")
        let v = Event(image: "rrr", title: "rrr", eventDescription: "rrr", userFirstName: UserStruct.userFirstName, userLastName: UserStruct.userLastName, userProfileImage: UserStruct.userProfileImageUrl , goingCount: 333, eventIdentifire: "vvv", goingUsers: ["fff"], userID: UserStruct.currentUserId, currntUserID: UserStruct.currentUserId, contactNumber: UserStruct.userContactNumber, userFBUrl: UserStruct.userFBUrl )
        
//        let v = Eve(userFirstName:   UserStruct.userFirstName, userLastName:   UserStruct.userLastName, userContactNumber:   UserStruct.userContactNumber, userFBUrl:    UserStruct.userFBUrl, userProfileImageUrl:    UserStruct.userProfileImageUrl, userID:   UserStruct.currentUserId)
        
        if (self.delegate != nil) { //Just to be safe.
//            self.delegate.callSegueFromCell(data: v)
            self.delegate.callSegueFromCell(data: v, cellForRowAt: indexPath!)
        }
        
//        func btnCloseTapped(cell: MyCell) {
//            //Get the indexpath of cell where button was tapped
//            let indexPath = self.collectionView.indexPathForCell(cell)
//            print(indexPath!.row)
//        }
        
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



