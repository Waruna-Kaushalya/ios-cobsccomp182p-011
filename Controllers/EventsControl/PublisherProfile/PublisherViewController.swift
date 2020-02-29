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

    @IBAction func closeButtonAction(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
    }
}
