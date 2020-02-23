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

class EventBoardViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //    var itemName:[]
    
    
    var videoList:[Video] = []
    //    var userDataList:[UserData] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
//        tableView.delegate = self
//        tableView.dataSource = self
        retrieveBooks()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    func retrieveBooks(){
        
        let docRef = Firestore.firestore().collection("event")
        //        print(Auth.auth().currentUser?.uid ?? "")
        docRef.getDocuments() { (querySnapshot, err) in
            
            
            self.videoList.removeAll()
            //            self.userDataList.removeAll()
            
            for document in querySnapshot!.documents {
                
                let data = document.data()
                
                let imageURL = data["eventImageUrl"] as? String
                let title = data["eventtitle"] as? String
                let eventDescription = data["eventdescription"] as? String
                let userID = data["userID"] as? String
                
                
                let dataRef = Firestore.firestore().collection("users").whereField("uid", isEqualTo: userID ?? "")
                dataRef.getDocuments { (querySnapshot, err) in
                    
                    let document = querySnapshot!.documents.first
                    let dataDescription = document?.data()
                    
                    let userFName = dataDescription?["firstname"] as? String
                    let userLName = dataDescription?["lastname"] as? String
                    let phoneNumber = dataDescription?["phoneNumber"] as? String
                    let fbURL = dataDescription?["facebookurl"] as? String
                    let userProfileImage = dataDescription?["imageURL"] as? String
                    
                    
                    
                    let video:Video = Video(image: imageURL!, title: title!, eventDescription: eventDescription!, userName: userFName! , userProfileImage: userProfileImage!)
                    
                    
                    let asd = UserModel()
                    asd.email = "vsdvdv b sdbv b sd"
                    
                    
                    DispatchQueue.main.async {
                        self.videoList.append(video)
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
        
        eventsController.video = videoList[indexPath.row]
        
        self.present(eventsController, animated: true, completion: nil)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell")  as! HomeTableViewCell
        
        print(indexPath.row)
        let video:Video = self.videoList[indexPath.row]
        
        cell.setVideo(video: video)
        
        return cell
        
    }
    
    func transToProfile()  {
        let Trans = TransitionController()
        Trans.trancVC(_viewCIdentifire: "UserProfileVC", _viewCFrom: self)
        
    }
    
    
}

