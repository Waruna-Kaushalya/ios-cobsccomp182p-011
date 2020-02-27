//
//  PublisherExtrnsion.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/28/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation


extension PublisherViewController {
    
    func setElements(){
        
        userProfileImage.roundedImage()
        
        nameLabelText.text =  UserStruct.userFirstName + " " + UserStruct.userLastName
        contactNumberLabelText.text =  UserStruct.userContactNumber
        fbUrlLabelText.text =  UserStruct.userFBUrl
        
        let url = URL(string: UserStruct.userProfileImageUrl)
        self.userProfileImage.kf.setImage(with: url)
        
    }
    
    func setUser(event: EventModel)  {

        UserStruct.userFirstName = event.userFirstName
        UserStruct.userLastName = event.userLastName
        UserStruct.userContactNumber = event.contactNumber
        UserStruct.userFBUrl = event.userFBUrl
        UserStruct.userProfileImageUrl = event.userProfileImage
        
    }
}
