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
    
    let eventAtendingDB = PushGoingDataFirbase()
    
    var eventIdentifire:[String] = [""]
    //    var goingUserList:[String] = [""]
    //    var goingCount:[Int] = [0]
    var currentUserId:[String] = [""]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventIdentifire[0] = event!.eventIdentifire
        
        getGoingDataFirebase()
        
        
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
        
        
        let aa = CheckUserLoginStatus()
        
        if aa.checkUserLoginStatus() == true {
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
                    goingBtn.setImage(UIImage(named: "NotGoingBtn"), for: .normal)
                    goingBtn.tag = 1
                    
                    GoingCountStruct.goingOrNot = true
                    
                }else{
                    goingBtn.setImage(UIImage(named: "GoingBtn"), for: .normal)
                    goingBtn.tag = 0
                    GoingCountStruct.goingOrNot = false
                }
            }
            else{
                
                goingBtn.setImage(UIImage(named: "GoingBtn"), for: .normal)
                goingBtn.tag = 0
                GoingCountStruct.goingOrNot = false
                
            }
        }else{
            goingBtn.isHidden = false
        }
    }
    
    
    
    func setElement(){
        
        goingCountLabel.text = String ("Count " + "\(GoingCountStruct.goingCountNumber )")
        userProfileImage.roundedImage()
        eventTitle.text = event?.title
        eventDescriptionLabel.text = event?.eventDescription
        
        
        let url = URL(string: event?.iamage ?? "")
        self.eventImage.kf.setImage(with: url)
        //        eventLocation
        //        eventAdedDate
        
        //        userProfileImage
        userName.text = event?.userFirstName
    }
    
    
    @IBAction func goingBtnClicked(_ sender: UIButton) {
        //        print(currentUserId[0])
        let aa = CheckUserLoginStatus()
        
        if aa.checkUserLoginStatus() == true {
            if goingBtn.tag == 0 {
                
                goingBtn.setImage(UIImage(named: "NotGoingBtn"), for: .normal)
                goingBtn.tag = 1
                
                GoingCountStruct.goingCountNumber =  GoingCountStruct.goingCountNumber  + 1
                
                goingCountLabel.text = String ("Count " + "\( GoingCountStruct.goingCountNumber )")
                
                GoingCountStruct.goingUserList.append(currentUserId[0])
                
                GoingCountStruct.goingOrNot = true
                
                
                
                
                
                //                eventAtendingDB.eventAtendingDB(eventIdentifire: eventIdentifire[0])
                eventAtendingDB.eventAtendingDB(eventIdentifire: eventIdentifire[0])
                print("going")
                
            }else {
                
                goingBtn.setImage(UIImage(named: "GoingBtn"), for: .normal)
                goingBtn.tag = 0
                
                GoingCountStruct.goingCountNumber =  GoingCountStruct.goingCountNumber  - 1
                
                goingCountLabel.text = String ("Count " + "\( GoingCountStruct.goingCountNumber )")
                
                GoingCountStruct.goingUserList = GoingCountStruct.goingUserList.filter {$0 !=  currentUserId[0] }
                
                GoingCountStruct.goingOrNot = false
                
                
//                eventAtendingDB(eventIdentifire: eventIdentifire[0])
                 eventAtendingDB.eventAtendingDB(eventIdentifire: eventIdentifire[0])
                
                print("not going")
            }
            
        }else{
            
            UIAlertController(title: "Alert", message: "User must login", preferredStyle: .alert)
            
        }
    }
    
   
    
    
    
    
    @IBAction func closeButtonClick(_ sender: Any) {
        let trans = TransitionController()
        trans.trancVC(_viewCIdentifire: "HomeVC", _viewCFrom: self)
        //                navigationController?.popViewController(animated: true)
        //
        //                dismiss(animated: true, completion: nil)
        //
        //        let eventsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeTableViewCell
        //
        ////        eventsController.dfgt()
        ////        self.present(eventsController, animated: true, completion: nil)
        //
        //            eventsController.dfgt()
        //        self.present(viewName, animated: true, completion: nil)
    }
    
    
    
}
