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
    
    let alertMessage = AlertMessages()
    let checkPW = CheckPasswordAndEmail()
    let trans = TransitionController()
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
        
        emailTextField.styleTextField()
        passwordTextField.styleTextField()
        
        signInButton.styleButton()
        signInButton.buttonRadiusAll()
    }
    
    
    @IBAction func loginButtonAction(_ sender: Any) {
        
        
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespaces)
        let pasword = passwordTextField.text!.trimmingCharacters(in: .whitespaces)
        
        if passwordTextField.text != "" || emailTextField.text != ""{
            self.checkPW.checkPasswordAndEmail(_password: pasword, _email: email, _viewFrom: self)
        }else{
            let alertM = AlertMessages()
            alertM.warningAlertMessage(_AlertMessage: "Password and email Should fill", _viewCFrom: self)
            //Login faceid and touchId
//            athentication.authenticateUser(_viewIdentifire: "HomeVC", _viewFrom: self)
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
}
