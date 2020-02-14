//
//  HomeViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/10/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var buttontest: UIButton!
    @IBOutlet weak var testUifield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setElements()
        
        
    }
    
    @IBAction func checkUserIsLogin(_ sender: Any) {
        let trans = TransitionController()
        
        let  aa = CheckUserLoginStatus()
//        print("AAAAAA")
//        print(aa.checkUserLoginStatus())
//        print("AAAAAA")
        
        if aa.checkUserLoginStatus() == true {
            trans.trancVC(_viewCIdentifire: "AddPostVC", _viewCFrom: self)
        }else{
            let alert = AlertMessages()
            alert.ActionAlert(_title: "User not login", _message: "User must login to add event", _viewCIdentifier: "LoginNavIVC", _viewControllerName: self)
        }
        
    }
    
    func setElements(){
        buttontest.styleButton()
        buttontest.buttonRadiusAll()
        testUifield.styleTextField()
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        let signOut = SignOutAction()
        signOut.signOutAction(_viewIdentifier: "LoginNavIVC", _viewC: self)
    }
    
}
