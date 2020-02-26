//
//  EventBoardViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/18/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseFirestore
import Kingfisher


protocol CellDelegator {
    func callSegueFromCell(data dataobject: Event,  cellForRowAt indexPath: IndexPath)
}

class EventBoardViewController: UIViewController, CellDelegator {
   
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var eventList:[Event] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveBooks()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
 
    
    func retrieveBooks(){
        
        let docRef = Firestore.firestore().collection("event")
        //        print(Auth.auth().currentUser?.uid ?? "")
        docRef.getDocuments() { (querySnapshot, err) in
            
            
            self.eventList.removeAll()
            //            self.userDataList.removeAll()
            
            for document in querySnapshot!.documents {
                
                let data = document.data()
                
                let imageURL = data["eventImageUrl"] as? String
                let title = data["eventtitle"] as? String
                let eventDescription = data["eventdescription"] as? String
                let userID = data["userID"] as? String
                let goingCount = data["goingCount"] as? Int
                let eventIdentifire = data["eventID"] as? String
                let goingUsers = data["goingUsers"] as! [String]
                
                
                let dataRef = Firestore.firestore().collection("users").whereField("uid", isEqualTo: userID ?? "")
                dataRef.getDocuments { (querySnapshot, err) in
                    
                    let document = querySnapshot!.documents.first
                    let dataDescription = document?.data()
                    
                    let userFName = dataDescription?["firstname"] as? String
                    let userLName = dataDescription?["lastname"] as? String
                    let phoneNumber = dataDescription?["phoneNumber"] as? String
                    let fbURL = dataDescription?["facebookurl"] as? String
                    let userProfileImage = dataDescription?["imageURL"] as? String
                    let currntUserID = dataDescription?["uid"] as? String
                    
                    let event:Event = Event(image: imageURL!, title: title!, eventDescription: eventDescription!, userFirstName: userFName!, userLastName: userLName!, userProfileImage: userProfileImage!, goingCount: goingCount!, eventIdentifire: eventIdentifire!, goingUsers: goingUsers, userID: userID!, currntUserID: currntUserID!, contactNumber: phoneNumber!,userFBUrl:fbURL!)
                    
                    
                    
                    
                    
                    DispatchQueue.main.async {
                        self.eventList.append(event)
                        self.tableView.reloadData()
                    }
                    
                }
            }
        }
    }
    
    
}

extension EventBoardViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let eventsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "eventDetailsVC") as! EventDetailsViewController
        
        let event:Event = self.eventList[indexPath.row]
        
        print(event.eventIdentifire)
        
        eventsController.event = event
        
        
        self.present(eventsController, animated: true, completion: nil)
        
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell")  as! HomeTableViewCell
        
                print(indexPath.row)
        let event:Event = self.eventList[indexPath.row]
        
        
        print("[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]")
        print(event.eventIdentifire)
         print("[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]")
      
        
        cell.setEvent(event: event)
//        cell.setPLike(event: event)
        
        cell.delegate = self
        
        
        return cell
        
    }
    
   
    func callSegueFromCell(data dataobject: Event, cellForRowAt indexPath: IndexPath) {
        
        
        
        let event:Event = self.eventList[indexPath.row]
        
        let viewName = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileViewController
        
//        viewName. = dataobject
        
        viewName.setUser(event: event)
        
        
        self.present(viewName, animated: true, completion: nil)
    }
    
    
    
    
    
//    func callSegueFromCell(data dataobject: User, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let viewName = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileViewController
//
//        viewName.user = dataobject
//
//        viewName.setUser(user: dataobject)
//
//
//        self.present(viewName, animated: true, completion: nil)
//
//    }
    
    func transToProfile()  {
        let Trans = TransitionController()
        Trans.trancVC(_viewCIdentifire: "UserProfileVC", _viewCFrom: self)
        
    }
    
    
    
    
}

