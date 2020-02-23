//
//  EventDetailsViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/21/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    var video:Video?
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
  
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLastNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let theVideo = self.video {
            eventTitle.text = video?.title
            eventDescription.text = video?.eventDescription
            userName.text = video?.userName
            
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
