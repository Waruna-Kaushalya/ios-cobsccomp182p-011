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
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
//    func setUser(userD: UserData)  {
//        
//        print("\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\")
//        print(userD.contactNumber)
//        
////        tapedLabel()
////
////        userProfileImage.roundedImage()
////
////        let url = URL(string: video.iamage ?? "")
////        self.postImageView.kf.setImage(with: url)
////        postTitle.text = video.title
////        eventDescription.text = video.eventDescription
////
////        userName.text = video.userName
////        let uurl = URL(string: video.userProfileImage ?? "")
////        self.userProfileImage.kf.setImage(with: uurl)
//        
//    }
    @IBAction func closeButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

    

}
