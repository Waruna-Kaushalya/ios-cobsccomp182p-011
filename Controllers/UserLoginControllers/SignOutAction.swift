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
    func showAlertSignOut(_viewIdentifier: String, _viewC: UIViewController) {
        
        let alert = UIAlertController(title: "Sign out?", message: "You can always access your content by signing back in", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: "Sign out",
                                      style: UIAlertAction.Style.destructive,
                                      handler: {(_: UIAlertAction!) in
                                        
                                        let signOut = SignOutAction()
                                        signOut.signOutAction(_viewIdentifier: "LoginNavIVC", _viewC: _viewC)
        }))
        _viewC.present(alert, animated: true, completion: nil)
    }
}
