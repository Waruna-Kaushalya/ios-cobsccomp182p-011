//
//  MyProfileTableExtension.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 3/1/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation

import UIKit
import Kingfisher


extension MyProfileTableViewCell{
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setMyEvent(myEvent:MyEventModel){
        eventTitle.text = myEvent.title
        
        var going:String = "Going:" + " " + "\(myEvent.goingCount)"
        
        goingCountLabel.text = String(going)
        
        let url = URL(string: myEvent.iamage ?? "")
        self.eventImageView.kf.setImage(with: url)
    }
}
