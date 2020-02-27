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
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        
        
        
        //        let trans = TransitionController()
        
//        let  aa = CheckUserLoginStatus()
        
        if checkUserLoginStatus.checkUserLoginStatus() != true {
            let alert = AlertMessages()
            alert.ActionAlert(_title: "User not login", _message: "User must login to view profile", _viewCIdentifier: "LoginNavIVC", _viewControllerName: self)
        }else{
            let athentication = TouchFaceIDAuthentication()
            
            athentication.authenticateUser(_viewIdentifire: "HomeVC", _viewFrom: self)
        }
        
        
        
        
        
        setElements()
        setData()
        
        
        
    }
    func setData(){
        let abcd = getData()
        
        abcd.read({ (document) in
            let url = URL(string: document)
            self.profileImage.kf.setImage(with: url)
        }, _fieldname: "imageURL")
        
        
        abcd.read({ (document) in
            //            bnv = document
            print(document)
            //            return document
            self.nameTextlabel.text = document
            
        }, _fieldname: "firstname")
        
        
        abcd.read({ (document) in
            //            bnv = document
            print(document)
            //            return document
            self.contactNumberTextLabel.text = document
            
        }, _fieldname: "phoneNumber")
    }
    
    func setElements(){
        profileImage.roundedImage()
        
        //        contactNumberTextLabel.labelStyle()
        //        nameTextlabel.labelStyle()
        
        //        signOutButton.styleButton()
        //        signOutButton.buttonRadiusAll()
    }
    @IBAction func signoutAction(_ sender: Any) {
        let signOut = SignOutAction()
        signOut.showAlertSignOut(_viewIdentifier: "LoginNavIVC", _viewC: self)
        
        //        showAlertSignOut()
        //        let signOut = SignOutAction()
        //        signOut.signOutAction(_viewIdentifier: "LoginNavIVC", _viewC: self)
    }
    //    func showAlertSignOut() {
    //
    //        let alert = UIAlertController(title: "Sign out?", message: "You can always access your content by signing back in", preferredStyle: UIAlertController.Style.alert)
    //
    //        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
    //            //Cancel Action
    //        }))
    //        alert.addAction(UIAlertAction(title: "Sign out",
    //                                      style: UIAlertAction.Style.destructive,
    //                                      handler: {(_: UIAlertAction!) in
    //
    //                                        let signOut = SignOutAction()
    //                                        signOut.signOutAction(_viewIdentifier: "LoginNavIVC", _viewC: self)
    //        }))
    //        self.present(alert, animated: true, completion: nil)
    //    }
    
}
