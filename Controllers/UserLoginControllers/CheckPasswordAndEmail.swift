//
//  CheckPasswordAndEmail.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/8/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

let trans = TransitionVC()
let alert  = AlertMessage()


class CheckPasswordAndEmail: UIViewController {
    func checkPasswordAndEmail(_password: String ,_email: String, _viewFrom: UIViewController) {
        print("2222222")
        print(_password)
        print(_email)
       
        Auth.auth().signIn(withEmail: _email, password: _password)  { (result, error)  in
            if error != nil {
                alert.alertMessage(_AlertMessage: "Password And Email Dosent MAtched", _viewCFrom: _viewFrom)
            }else{
                
                trans.trancVC(_viewCIdentifire: "HomeVC", _viewCFrom: _viewFrom)
                
            }
        }
    }
}
