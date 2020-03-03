//
//  MyProfileExtension.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/28/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import Kingfisher
import Firebase
import FirebaseAuth
import FirebaseFirestore

extension MyProfileViewController:UITableViewDataSource,UITableViewDelegate{
   
    
    
    func setData(){
        let abcd = getData()
        
        abcd.read({ (document) in
            let url = URL(string: document)
            self.profileImage.kf.setImage(with: url)
        }, _fieldname: "imageURL")
        
        
        abcd.read({ (document) in
            
            print(document)
            
            self.nameTextlabel.text = document
            
        }, _fieldname: "firstname")
        
        
        abcd.read({ (document) in
            
            print(document)
            
            self.contactNumberTextLabel.text = document
            
        }, _fieldname: "phoneNumber")
    }
    
    func setElements(){
        profileImage.roundedImage()
    }
    
    func retrievemyEventDetails(){
        
        self.eventList.removeAll()
        let checkUserLoginStatus = CheckUserLoginStatus()
        
        if checkUserLoginStatus.checkUserLoginStatus() == true{
            let currentUserID  = Auth.auth().currentUser!.uid as String
            
            let dataRef = Firestore.firestore().collection("event").whereField("userID", isEqualTo: currentUserID)
            dataRef.getDocuments { (querySnapshot, err) in
                
                for document in querySnapshot!.documents {
                    
                    let dataDescription = document.data()
                    
                    let userIDV = dataDescription["userID"] as? String
                    let eventImageUrl = dataDescription["eventImageUrl"] as? String
                    let eventTitle = dataDescription["eventtitle"] as? String
                    
                    let commentDate = dataDescription["eventAddedDate"] as? String
                    let goingCount = dataDescription["goingCount"] as? Int
                    
                    let myEvent:MyEventModel = MyEventModel(image: eventImageUrl!, title: eventTitle!, goingCount: goingCount!, eventDate: commentDate!)
                    
                    DispatchQueue.main.async {
                        self.eventList.append(myEvent)
                        self.eventList.sort(by: {$0.eventDate > $1.eventDate})
                        self.myEventTable.reloadData()
                    }
                }
            }
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myEvent = eventList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileTableViewCellID") as! MyProfileTableViewCell
        
        cell.setMyEvent(myEvent:  myEvent )
        
        return cell
        
    }
}
