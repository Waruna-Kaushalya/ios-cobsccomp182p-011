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

    var event:Event?
    
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
    @IBOutlet weak var eventEditBtn: UIButton!
    
    let eventAtendingDB = AddGoingCountDataToFirebase()
    
    var eventIdentifire:[String] = [""]
    
    var currentUserId:[String] = [""]
    
    let checkUserStatus = CheckUserLoginStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventIdentifire[0] = event!.eventIdentifire
        
        getGoingDataFirebase()
        
        buttonAccessControll()
        
    }
    
    func buttonAccessControll(){
        
        if checkUserStatus.checkUserLoginStatus() != true || Auth.auth().currentUser!.uid != event!.userID  {
            eventEditBtn.isHidden = true
        }
    }
    
    func getGoingDataFirebase(){
        
        let docRef = Firestore.firestore().collection("event").whereField("eventID", isEqualTo: self.event!.eventIdentifire)
        
        print(self.event!.eventIdentifire)
        
        docRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            } else if querySnapshot!.documents.count != 1 {
                print("More than one documents or none")
            } else {
                let document = querySnapshot!.documents.first
                let dataDescription = document?.data()
                
                GoingCountStruct.goingCountNumber = dataDescription?["goingCount"] as! Int
                
                GoingCountStruct.goingUserList = dataDescription?["goingUsers"]  as! [String]
                
                print("AAAAAA")
                
                if GoingCountStruct.goingUserList.count == 0  {
                    print("going count nil")
                    GoingCountStruct.goingCountNumber = 0
                }
            }
            
            DispatchQueue.main.async {
                self.setElement()
                self.setPLike()
                
                print("BBB")
            }
        }
    }
    
    func setPLike(){
        
        if checkUserStatus.checkUserLoginStatus() == true {
            currentUserId[0] = Auth.auth().currentUser!.uid
            
            var flagC:[Bool] = [false]
            
            if GoingCountStruct.goingUserList.count != 0 && GoingCountStruct.goingCountNumber  != 0{
                for i in 0..<GoingCountStruct.goingUserList.count {
                    
                    if GoingCountStruct.goingUserList[i] ==  currentUserId[0]  {
                        flagC[0] = true
                    }else{
                        flagC[0] = false
                    }
                }
                
                if flagC[0] == true{
                    goingBtn.setImage(UIImage(named: "GoingToEventBtn"), for: .normal)
                    goingBtn.tag = 1
                    
                    GoingCountStruct.goingOrNot = true
                    
                }else{
                    goingBtn.setImage(UIImage(named: "NotGoingToEventBtn"), for: .normal)
                    goingBtn.tag = 0
                    GoingCountStruct.goingOrNot = false
                }
            }
            else{
                
                goingBtn.setImage(UIImage(named: "NotGoingToEventBtn"), for: .normal)
                goingBtn.tag = 0
                GoingCountStruct.goingOrNot = false
            }
        }else{
            goingBtn.isHidden = false
            
        }
    }
    
    func setElement(){
        
        goingCountLabel.text = String ("\(GoingCountStruct.goingCountNumber )")
        userProfileImage.roundedImage()
        
        eventTitle.text = event?.title
        eventDescriptionLabel.text = event?.eventDescription
        
        let url = URL(string: event?.iamage ?? "")
        self.eventImage.kf.setImage(with: url)
        
        eventLocation.text = event?.userCurrentLocation
        
        eventAdedDate.text = event?.eventAddedDate
        
        let urll = URL(string: event?.userProfileImage ?? "")
        self.userProfileImage.kf.setImage(with: urll)
        
        userName.text = event?.userFirstName
        
        UpdateEventStruct.eventID = event!.eventIdentifire
        UpdateEventStruct.eventDescription = event!.eventDescription
        UpdateEventStruct.eventTitle = event!.title
    }
    
    
    @IBAction func goingBtnClicked(_ sender: UIButton) {
        
        if checkUserStatus.checkUserLoginStatus() == true {
            if goingBtn.tag == 0 {
                
                //                going
                
                goingBtn.setImage(UIImage(named: "GoingToEventBtn"), for: .normal)
                
                goingBtn.tag = 1
                
                GoingCountStruct.goingCountNumber =  GoingCountStruct.goingCountNumber  + 1
                
                goingCountLabel.text = String ("\( GoingCountStruct.goingCountNumber )")
                
                GoingCountStruct.goingUserList.append(currentUserId[0])
                
                GoingCountStruct.goingOrNot = true
                
                eventAtendingDB.addGoingCountDataToFirebase(eventIdentifire: eventIdentifire[0])
                
            }else {
                
                //                not going
                goingBtn.setImage(UIImage(named: "NotGoingToEventBtn"), for: .normal)
                goingBtn.tag = 0
                
                GoingCountStruct.goingCountNumber =  GoingCountStruct.goingCountNumber  - 1
                
                goingCountLabel.text = String ("\(GoingCountStruct.goingCountNumber)")
                
                GoingCountStruct.goingUserList = GoingCountStruct.goingUserList.filter {$0 !=  currentUserId[0] }
                
                GoingCountStruct.goingOrNot = false
                
                eventAtendingDB.addGoingCountDataToFirebase(eventIdentifire: eventIdentifire[0])
            }
        }else{
            
            UIAlertController(title: "Alert", message: "User must login", preferredStyle: .alert)
        }
    }
    
    @IBAction func closeButtonClick(_ sender: Any) {
        let trans = TransitionController()
        trans.trancVC(_viewCIdentifire: "HomeVC", _viewCFrom: self)
    }
    
    @IBAction func eventEditAction(_ sender: Any) {
        let transition = TransitionController()
        transition.trancVC(_viewCIdentifire: "EventEditVC", _viewCFrom: self)
    }
}

