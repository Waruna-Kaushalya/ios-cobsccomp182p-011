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
    
    var videoList:[Video] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
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
            
            for document in querySnapshot!.documents {
                
                let data = document.data()
                
                let imageURL = data["eventImageUrl"] as? String
                let title = data["eventtitle"] as? String
                let video:Video = Video(image: imageURL! , title:title! )
                
                DispatchQueue.main.async {
                    self.videoList.append(video)
                    
                    self.tableView.reloadData()
                    
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell")  as! HomeTableViewCell
        
        let video:Video = self.videoList[indexPath.row]
        
        cell.setVideo(video: video)
        
        return cell
        
    }
    
    
}
extension EventBoardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoList.count
        
    }
    
}

