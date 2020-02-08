//
//  LoginViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/7/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth
import FirebaseFirestore
import LocalAuthentication


class LoginViewController: UIViewController {
    
    let utiliti = TextFieldUtilities()
    let alertMessage = AlertMessage()
    let checkPW = CheckPasswordAndEmail()
    let trans = TransitionVC()
    let athentication = TouchFaceIDAuthentication()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    
    var context = LAContext()
    
    enum AuthenticationState {
        case loggedin, loggedout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) 
    }
    func setupElements(){
        TextFieldUtilities.styleTextField(emailTextField)
        TextFieldUtilities.styleTextField(passwordTextField)
        
        ButtonUtilities.styleButton(signInButton)
        ButtonUtilities.ButtonRadius_All(signInButton)
    }
    
    
    @IBAction func loginButtonAction(_ sender: Any) {
        
        
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespaces)
        let pasword = passwordTextField.text!.trimmingCharacters(in: .whitespaces)
        
        if passwordTextField.text != "" || emailTextField.text != ""{
            self.checkPW.checkPasswordAndEmail(_password: pasword, _email: email, _viewFrom: self)
        }else{
            athentication.authenticateUser(_viewIdentifire: "HomeVC", _viewFrom: self)
        }
        
        
      
    }
    
    
    
}
