//
//  MyProfileViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/14/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import Kingfisher

class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var nameTextlabel: UILabel!
    @IBOutlet weak var contactNumberTextLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var signOutButton: UIButton!
    
    
    let checkUserLoginStatus = CheckUserLoginStatus()
    
    @IBAction func signoutAction(_ sender: Any) {
        let signOut = SignOutAction()
        signOut.showAlertSignOut(_viewIdentifier: "LoginNavIVC", _viewC: self)
        
    }
    
}
