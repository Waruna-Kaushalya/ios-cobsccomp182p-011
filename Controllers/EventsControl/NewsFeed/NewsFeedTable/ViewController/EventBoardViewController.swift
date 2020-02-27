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
    func callSegueFromCell(data dataobject: EventModel,  cellForRowAt indexPath: IndexPath)
}

class EventBoardViewController: UIViewController, CellDelegator {
    
    @IBOutlet weak var tableView: UITableView!
    
    var eventList:[EventModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveEvents()
        self.tableView.reloadData()
        
    }
    
    
    func retrieveEvents(){
        
        let docRef = Firestore.firestore().collection("event")
        //        print(Auth.auth().currentUser?.uid ?? "")
        docRef.getDocuments() { (querySnapshot, err) in
            
            self.eventList.removeAll()
            
            for document in querySnapshot!.documents {
                
                let data = document.data()
                
                let imageURL = data["eventImageUrl"] as? String
                let title = data["eventtitle"] as? String
                let eventDescription = data["eventdescription"] as? String
                let userID = data["userID"] as? String
                let goingCount = data["goingCount"] as? Int
                let eventIdentifire = data["eventID"] as? String
                let goingUsers = data["goingUsers"] as! [String]
                let eventAddedDate = data["eventAddedDate"] as! String
                let userCurrentLocation = data["userCurrentLocation"] as! String
                
                
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
                    
                    let event:EventModel = EventModel(image: imageURL!, title: title!, eventDescription: eventDescription!, userFirstName: userFName!, userLastName: userLName!, userProfileImage: userProfileImage!, goingCount: goingCount!, eventIdentifire: eventIdentifire!, goingUsers: goingUsers, userID: userID!, currntUserID: currntUserID!, contactNumber: phoneNumber!,userFBUrl:fbURL!, eventAddedDate: eventAddedDate,userCurrentLocation: userCurrentLocation)
                    
                    DispatchQueue.main.async {
                        self.eventList.append(event)
                        
                        //Sort using date
                        
                        self.eventList.sort(by: {$0.eventAddedDate > $1.eventAddedDate})
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}



