//
//  EventDetailsViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/21/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage

class EventDetailsViewController: UIViewController {
    
    var video:Video?
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventAdedDate: UILabel!
    @IBOutlet weak var goingBtn: UIButton!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var goingCountLabel: UILabel!
    
    
    
    var goingCountArray:[Int] = [0]
    var goingUsers:[String] = [""]
    var eventIdentifire:[String] = [""]
    var currentUserId:[String] = [""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        setData()
        
        userProfileImage.roundedImage()
        
        
    
        //==========================
        let dd = Firestore.firestore()
        dd.collection("event").whereField("eventID", isEqualTo: eventIdentifire[0])
            .addSnapshotListener { querySnapshot, error in
                
//                guard (querySnapshot?.documents) != nil else {
//                    print("Error fetching documents: \(error!)")
//                    return
//                }
                
                
                
                  let document = querySnapshot!.documents.first
                print(document)
                
//                eventId = querySnapshot.value?["eventID"] as? String ?? ""
                
                let eventId  = document!.get("eventID") as! String
                
              
                
               
                
//                let goingCount = document!.get("goingCount") as! Int
                
             
//                let goingUsersList = document!.get("goingUsers") as! [String]
                
                
//                self.currentUserId[0] = Auth.auth().currentUser!.uid
//                self.goingCountArray[0] = goingCount
//                self.eventIdentifire[0] = eventId
                
                self.goingCountLabel.text = String ("Count " + "\(self.goingCountArray[0])")
                
//                self.goingUsers = goingUsersList
                
                
                
                
        }
        //=======================
        
        
        if let video = self.video {
            
            
            
            let aa = CheckUserLoginStatus()
            
            if aa.checkUserLoginStatus() == true {
                //===============
                //                currentUserId[0] = Auth.auth().currentUser!.uid
                //                goingCountArray[0] = video.goingCount
                //                eventIdentifire[0] = video.eventIdentifire
                //
                //                goingCountLabel.text = String ("Count " + "\(goingCountArray[0])")
                //
                //                goingUsers = video.goingUsers
                //=================
                
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
                    goingBtn.setImage(UIImage(named: "NotGoingBtn"), for: .normal)
                    goingBtn.tag = 1
                }
            }else{
                
                goingBtn.isHidden = true
            }
            
            
            var arr = video.goingUsers //
            
            eventTitle.text = video.title
            
            eventDescriptionLabel.text = video.eventDescription
            
            eventDescriptionLabel.text = video.eventDescription
            
            let userProfileUrl = URL(string: video.userProfileImage ?? "")
            self.userProfileImage.kf.setImage(with: userProfileUrl)
            
            let eventImageurl = URL(string: video.iamage ?? "")
            self.eventImage.kf.setImage(with: eventImageurl)
            
        }
        
    }
    func setData (){
//        let dd = Firestore.firestore()
//        dd.collection("event").whereField("eventID", isEqualTo: eventIdentifire[0])
//            .addSnapshotListener { querySnapshot, error in
//
//                guard (querySnapshot?.documents) != nil else {
//                    print("Error fetching documents: \(error!)")
//                    return
//                }
//
//                let document = querySnapshot!.documents.first
//
//                let goingCount = document?.get("goingCount") as! Int
//
//                let eventId = document!.get("eventID") as! String
//                let goingUsersList = document!.get("goingUsers") as! [String]
//
//
//                self.currentUserId[0] = Auth.auth().currentUser!.uid
//                self.goingCountArray[0] = goingCount
//                self.eventIdentifire[0] = eventId
//
//                self.goingCountLabel.text = String ("Count " + "\(self.goingCountArray[0])")
//
//                self.goingUsers = goingUsersList
//
//
//
//
//        }
    }
    
    func lick(){
        
        print(goingCountArray[0])
        print(eventIdentifire[0])
        
        print(eventIdentifire[0])
        
        let dd = Firestore.firestore()
        dd.collection("event").whereField("eventID", isEqualTo: eventIdentifire[0])
            .addSnapshotListener { querySnapshot, error in
                
                guard (querySnapshot?.documents) != nil else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                let document = querySnapshot!.documents.first
                let latMax = document!.get("goingCount") as! Int
                print("666666666666666666666666666666666666666666")
                print(latMax)
                
                let goingInt:Int = self.goingCountArray[0]
                print(goingInt)
                document!.reference.updateData(["goingCount": goingInt])
                document!.reference.updateData(["goingUsers": self.goingUsers])
                
        }
        
    }
    
    
    //    func setPLike(video: Video){
    //
    //
    //        let aa = CheckUserLoginStatus()
    //
    //        if aa.checkUserLoginStatus() == true {
    //            currentUserId[0] = Auth.auth().currentUser!.uid
    //            goingCountArray[0] = video.goingCount
    //            eventIdentifire[0] = video.eventIdentifire
    //
    //            goingCountLabel.text = String ("Count " + "\(goingCountArray[0])")
    //
    //            goingUsers = video.goingUsers
    //
    //            var flagC:[Bool] = [false]
    //
    //            for i in 0..<goingUsers.count {
    //
    //                if goingUsers[i] ==  currentUserId[0] {
    //                    flagC[0] = true
    //                }else{
    //                    flagC[0] = false
    //                }
    //                print(goingUsers[i])
    //            }
    //
    //            if flagC[0] == true{
    //                goingBtn.setImage(UIImage(named: "NotGoingBtn"), for: .normal)
    //                goingBtn.tag = 1
    //            }
    //        }else{
    //
    //            goingBtn.isHidden = true
    //        }
    //    }
    
    
    @IBAction func goingBtnClicked(_ sender: UIButton) {
        
        
        print(currentUserId[0])
        let aa = CheckUserLoginStatus()
        
        if aa.checkUserLoginStatus() == true {
            if goingBtn.tag == 0 {
                
                goingBtn.setImage(UIImage(named: "NotGoingBtn"), for: .normal)
                goingBtn.tag = 1
                
                goingCountArray[0] = goingCountArray[0] + 1
                
                goingCountLabel.text = String ("Count " + "\(goingCountArray[0])")
                
                
                print("==================================")
                print(currentUserId[0])
                
                print(currentUserId[0])
                
                
                goingUsers.append(currentUserId[0])
                
                self.lick()
                print("going")
                
            }else {
                
                goingBtn.setImage(UIImage(named: "GoingBtn"), for: .normal)
                goingBtn.tag = 0
                
                goingCountArray[0] = goingCountArray[0] - 1
                goingCountLabel.text = String ("Count " + "\(goingCountArray[0])")
                
                goingUsers = goingUsers.filter {$0 != currentUserId[0]}
                
                self.lick()
                print("not going")
            }
            
        }else{
            print("{[[[[[[[[[[[[[]]]]]]]]]]]]]}")
            UIAlertController(title: "Alert", message: "User must login", preferredStyle: .alert)
            
            
        }
        
        
        
        
    }
    
    
    
    @IBAction func closeButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
