//
//  PasswordForgetViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/8/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import FirebaseAuth


let ERROR_EMPTY_EMAIL_REST = "Please enter an email address for reset password"

class PasswordForgetViewController: UIViewController,UITextFieldDelegate {
    
    let trans  = TransitionController()
    let alert = AlertMessages()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendEmailButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        
    }
    
    
    @IBAction func restPasswordTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, email != "" else{
            alert.warningAlertMessage(_AlertMessage: ERROR_EMPTY_EMAIL_REST, _viewCFrom: self)
            return
        }
        resetPassword(email: email)
        
        trans.trancVC(_viewCIdentifire: "LoginVC", _viewCFrom: self)
    }
    
    
}
