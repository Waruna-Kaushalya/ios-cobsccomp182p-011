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
    
    var eventList:[MyEventModel] = []
    
    
    @IBOutlet weak var nameTextlabel: UILabel!
    @IBOutlet weak var contactNumberTextLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBOutlet weak var myEventTable: UITableView!
    
    let checkUserLoginStatus = CheckUserLoginStatus()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if checkUserLoginStatus.checkUserLoginStatus() != true {
            let alert = AlertMessages()
            alert.ActionAlert(_title: "User not login", _message: "User must login to view profile", _viewCIdentifier: "LoginNavIVC", _viewControllerName: self)
        }else{
            let athentication = TouchFaceIDAuthentication()
            
            athentication.authenticateUser(_viewIdentifire: "HomeVC", _viewFrom: self)
        }
        
        retrievemyEventDetails()
        
        setElements()
        setData()
        
    }
    
    
    @IBAction func signoutAction(_ sender: Any) {
        let signOut = SignOutAction()
        signOut.showAlertSignOut(_viewIdentifier: "LoginNavIVC", _viewC: self)
        
    }
}
