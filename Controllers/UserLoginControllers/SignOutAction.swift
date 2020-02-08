//
//  SignOutAction.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/8/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class SignOutAction {
    func signOutAction(_viewIdentifier: String, _viewC: UIViewController)  {
        let firebaseAuth = Auth.auth()
        do {
            try! Auth.auth().signOut()
            if let storyboard = _viewC.storyboard {
                let vc = storyboard.instantiateViewController(withIdentifier: _viewIdentifier) as! UIViewController
                _viewC.present(vc, animated: false, completion: nil)
            }
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
        //2nd
        //        try! Auth.auth().signOut()
        //        if let storyboard = _viewC.storyboard {
        //            let vc = storyboard.instantiateViewController(withIdentifier: _viewIdentifier) as! UIViewController
        //            _viewC.present(vc, animated: false, completion: nil)
        //        }
    }
}
