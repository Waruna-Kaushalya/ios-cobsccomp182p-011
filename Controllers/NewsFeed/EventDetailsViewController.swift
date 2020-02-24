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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let theVideo = self.video {
            
            eventTitle.text = video?.title
            
            let uurl = URL(string: video?.userProfileImage ?? "")
            self.userProfileImage.kf.setImage(with: uurl)
            
            
            
        }

    }
//    func setVideoo(video: Video)  {
//
//        eventTitle.text = video.userName
//
//
//    }

    
    @IBAction func closeButtonAction(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
    }
    

}
