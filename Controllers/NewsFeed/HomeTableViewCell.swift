//
//  HomeTableViewCell.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/19/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    
    
    
    
    func setVideo(video: Video)  {
        
        tapedLabel()
        
        userProfileImage.roundedImage()
        
        let url = URL(string: video.iamage ?? "")
        self.postImageView.kf.setImage(with: url)
        postTitle.text = video.title
        eventDescription.text = video.eventDescription
        
        userName.text = video.userName
        let uurl = URL(string: video.userProfileImage ?? "")
        self.userProfileImage.kf.setImage(with: uurl)

    }
    func tapedLabel(){
        userName.isUserInteractionEnabled = true
        
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.doSomethingOnTap))
        
        userName.addGestureRecognizer(labelTapGesture)
    }
    @objc func doSomethingOnTap() {
        print("tapped")
    }
    
}
