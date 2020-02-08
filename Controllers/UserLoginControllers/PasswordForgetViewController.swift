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

class PasswordForgetViewController: UIViewController {
    
    let trans  = TransitionVC()
    let alert = AlertMessage()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendEmailButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        // Do any additional setup after loading the view.
    }
    
    func setupElements(){
        ButtonUtilities.ButtonRadius_All(sendEmailButton)
        ButtonUtilities.styleButton(sendEmailButton)
        
        TextFieldUtilities.styleTextField(emailTextField)
    }
    
    @IBAction func restPasswordTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, email != "" else{
            alert.alertMessage(_AlertMessage: ERROR_EMPTY_EMAIL_REST, _viewCFrom: self)
            return
        }
        resetPassword(email: email)
        
        trans.trancVC(_viewCIdentifire: "LoginVC", _viewCFrom: self)
    }
    
    func resetPassword(email:String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error == nil {
                self.alert.alertMessage(_AlertMessage: "Psswrd rest email sent", _viewCFrom: self)
            }else{
                self.alert.alertMessage(_AlertMessage: "Somthing Error", _viewCFrom: self)
            }
        }
        
    }
}
