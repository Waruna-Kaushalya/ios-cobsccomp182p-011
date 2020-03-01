//
//  EventBoardExtension.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/27/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseFirestore
import Kingfisher


extension EventBoardViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let eventsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "eventDetailsVC") as! EventDetailsViewController
        
        let event:EventModel = self.eventList[indexPath.row]
        
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
        let event:EventModel = self.eventList[indexPath.row]
        
        print(event.eventIdentifire)
        
        cell.setEvent(event: event)
        
        cell.currentCell = self.eventList
        
        cell.delegate = self
        
        return cell
        
    }
    
    func callSegueFromCell(data dataobject: EventModel, cellForRowAt indexPath: IndexPath) {
        
        let event:EventModel = self.eventList[indexPath.row]
        
        let viewName = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserProfileVC") as! PublisherViewController
        
        viewName.setUser(event: event)
        
        
        self.present(viewName, animated: true, completion: nil)
    }
    
    func transToProfile()  {
        let Trans = TransitionController()
        Trans.trancVC(_viewCIdentifire: "UserProfileVC", _viewCFrom: self)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: false)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}
