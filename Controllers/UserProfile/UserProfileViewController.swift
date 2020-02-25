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
    
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let asd = UserModel()
        print(asd.email)
        
        print(user?.userFirstName)
        print(user?.userLastName)
        print(user?.userContactNumber)
        print(user?.userID)
        print(user?.userFBUrl)
        print(user?.userProfileImageUrl)
        
    }
    func setUser(user: User)  {
        
        
        //        var arr = user.goingUsers
        //        
        //        var usernamec = user.userName
        
        
        
        //        print("-----------------------------------")
        
        
        
        
        
    }
    
    
    @IBAction func closeButtonAction(_ sender: Any) {
        let trans = 
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
