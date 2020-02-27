//
//  UserProfileViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/21/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit

class PublisherViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var closeButtonAction: UIButton!
    
    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameLabelText: UILabel!
    
    @IBOutlet weak var contactNumberLabel: UILabel!
    @IBOutlet weak var contactNumberLabelText: UILabel!
    
    @IBOutlet weak var fbUrlLabel: UILabel!
    @IBOutlet weak var fbUrlLabelText: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setElements()
        
    }
    func setElements(){
        
        userProfileImage.roundedImage()
        
        nameLabelText.text =  UserStruct.userFirstName + " " + UserStruct.userLastName
        contactNumberLabelText.text =  UserStruct.userContactNumber
        fbUrlLabelText.text =  UserStruct.userFBUrl
        
        let url = URL(string: UserStruct.userProfileImageUrl)
        self.userProfileImage.kf.setImage(with: url)
        
    }
    
    func setUser(event: EventModel)  {
        
        
        print(event.userFirstName)
        print(event.userLastName)
        
        
        UserStruct.userFirstName = event.userFirstName
        UserStruct.userLastName = event.userLastName
        UserStruct.userContactNumber = event.contactNumber
        UserStruct.userFBUrl = event.userFBUrl
        UserStruct.userProfileImageUrl = event.userProfileImage
        
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        
        
        self.dismiss(animated: true, completion: nil)
    }
}
