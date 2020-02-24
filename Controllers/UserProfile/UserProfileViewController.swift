//
//  UserProfileViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/21/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    @IBOutlet weak var closeButtonAction: UIButton!
    
    struct Resolution {
        var name = 0
        var height = 0
    }
    
    var video:Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       print("-----------------------------------")
        print( video?.userName)
        print("-----------------------------------")
        
    }
    func setVideo(video: Video)  {
        
        
        var arr = video.goingUsers
        
        var usernamec = video.userName
        

        
//        print("-----------------------------------")
        print(usernamec)
        
        
        
        
    }
    
  
    @IBAction func closeButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

    

}
