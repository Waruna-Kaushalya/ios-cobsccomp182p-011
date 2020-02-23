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
    
    @IBOutlet weak var userProfileButton: UIButton!
    
    
    @IBOutlet weak var goingButton: UIButton!
    
    
    
    func setVideo(video: Video)  {
        
//        print("sdvsdvsdvsdvsdvsdvsdvsdsdvsdvsd")
        
        
        userProfileImage.roundedImage()
        
        let url = URL(string: video.iamage ?? "")
        self.postImageView.kf.setImage(with: url)
        postTitle.text = video.title
        
//        self.test.accessibilityLabel = "ffff"
        
      
        
        
        eventDescription.text = video.eventDescription
        
        userName.text = video.userName
        let uurl = URL(string: video.userProfileImage ?? "")
        self.userProfileImage.kf.setImage(with: uurl)
        
        tapedLabel()

    }
    func tapedLabel(){
        userName.isUserInteractionEnabled = true
        
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.doSomethingOnTap))
        
        userName.addGestureRecognizer(labelTapGesture)
    }
    
    

    @objc func doSomethingOnTap() {
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileViewController
        
        

    
        
//        let a = EventBoardViewController()
//        a.transitionToProfile()m
        
        
//        println("tapped!")
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let secondViewController = storyBoard.instantiateViewControllerWithIdentifier("secondView") as UserProfileViewController
//        self.presentViewController(secondViewController, animated:true, completion:nil)
        
        print("tapped")
    }
    
    
    @IBAction func btnGoing_Clicked(_ sender: UIButton) {
        
        if goingButton.tag == 0 {
            goingButton.setImage(UIImage(named: "Going"), for: .normal)
            goingButton.tag = 1
            print("going")
        }else{
             goingButton.setImage(UIImage(named: "NotGoing"), for: .normal)
            goingButton.tag = 0
              print("not going")
        }
        
    }
    
    
    
    
}



