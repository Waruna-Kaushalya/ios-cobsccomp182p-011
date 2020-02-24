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
    
    var goingCountArray:[Int] = [0]
    var goingUsers:[String] = [""]
    var eventIdentifire:[String] = [""]
    var currentUserId:[String] = [""]
    
    
    
    //    let userIdd = "Aw2nt3h4DI9ZBdwJzQ4k3jVKRvWI3"
    
    func setVideo(video: Video)  {
        
        
        var arr = video.goingUsers
        
        
        //        var arr = ["a", "b", "c", "d"]
        //add element
        //        numbers.append(100)
        
        
        //remove element
        //        var farray = arr.filter {$0 != "b"}
        //        goingButton.setImage(UIImage(named: "Going"), for: .normal)
        //        goingButton.tag = 0
        userProfileImage.roundedImage()
        
        let url = URL(string: video.iamage ?? "")
        self.postImageView.kf.setImage(with: url)
        postTitle.text = video.title
        
        eventDescription.text = video.eventDescription
        
        userName.text = video.userName
        let uurl = URL(string: video.userProfileImage ?? "")
        self.userProfileImage.kf.setImage(with: uurl)
        
        
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
        
        print("tapped")
    }
    
    
    @IBAction func btnGoing_Clicked(_ sender: UIButton) {
        print(currentUserId[0])
        let aa = CheckUserLoginStatus()
        
        if aa.checkUserLoginStatus() == true {
            if goingButton.tag == 0 {
                
                goingButton.setImage(UIImage(named: "NotGoingBtn"), for: .normal)
                goingButton.tag = 1
                
                goingCountArray[0] = goingCountArray[0] + 1
                
                goingCountLabel.text = String ("Count " + "\(goingCountArray[0])")
                
                
                print("==================================")
                print(currentUserId[0])
                
                print(currentUserId[0])
                
                
                goingUsers.append(currentUserId[0])
                
                lick()
                print("going")
                
            }else {
                
                goingButton.setImage(UIImage(named: "GoingBtn"), for: .normal)
                goingButton.tag = 0
                
                goingCountArray[0] = goingCountArray[0] - 1
                goingCountLabel.text = String ("Count " + "\(goingCountArray[0])")
                
                goingUsers = goingUsers.filter {$0 != currentUserId[0]}
                
                lick()
                print("not going")
            }
            
        }else{
            print("{[[[[[[[[[[[[[]]]]]]]]]]]]]}")
            UIAlertController(title: "Alert", message: "User must login", preferredStyle: .alert)
            
            
        }
        
        
        
    }
    func lick(){
        
        print(goingCountArray[0])
        print(eventIdentifire[0])
        
        let db = Firestore.firestore()
        db.collection("event").whereField("eventID", isEqualTo: eventIdentifire[0])
            .addSnapshotListener { querySnapshot, error in
                guard (querySnapshot?.documents) != nil else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                let document = querySnapshot!.documents.first
                let goingInt:Int = self.goingCountArray[0]
                document!.reference.updateData(["goingCount": goingInt])
                document!.reference.updateData(["goingUsers": self.goingUsers])
                
        }
        
    }
    func setPLike(video: Video){
        
        
        let aa = CheckUserLoginStatus()
        
        if aa.checkUserLoginStatus() == true {
            currentUserId[0] = Auth.auth().currentUser!.uid
            goingCountArray[0] = video.goingCount
            eventIdentifire[0] = video.eventIdentifire
            
            goingCountLabel.text = String ("Count " + "\(goingCountArray[0])")
            
            goingUsers = video.goingUsers
            
            var flagC:[Bool] = [false]
            
            for i in 0..<goingUsers.count {
                
                if goingUsers[i] ==  currentUserId[0] {
                    flagC[0] = true
                }else{
                    flagC[0] = false
                }
                print(goingUsers[i])
            }
            
            if flagC[0] == true{
                goingButton.setImage(UIImage(named: "NotGoingBtn"), for: .normal)
                goingButton.tag = 1
            }
        }else{
            
            goingButton.isHidden = true
        }
    }
}



