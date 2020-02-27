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
    
    var EMPTY_FIELDS = "Password and email Should fill"
    let PASSWRD_DOSENT_MATCH = "Password doesn't match"
    let WEAK_PASSWORD = "Please make sure your password is at least 8 char, special chr and number"
    let WEAK_EMAIL = "Please enter valied email address"
    let USER_ERROR = "Error creating user"
    var ERROR_SAVING_DATA = "Error saving user data"
    
    let alertMessage = AlertMessages()
    let checkPW = CheckPasswordAndEmail()
    let trans = TransitionController()
    let athentication = TouchFaceIDAuthentication()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    
    
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
    
    
    
    func validateFields() -> String? {
        
        //check that all fields are field in
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            
            alertM.warningAlertMessage(_AlertMessage: EMPTY_FIELDS, _viewCFrom: self)
            return EMPTY_FIELDS
            
        }

        return nil
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        

        let error = validateFields()
        
        
        if error != nil{
            
            alertM.warningAlertMessage(_AlertMessage: error!, _viewCFrom: self)
            
        }else{
            
           

        let email = emailTextField.text!.trimmingCharacters(in: .whitespaces)
        let pasword = passwordTextField.text!.trimmingCharacters(in: .whitespaces)
        
        if passwordTextField.text != "" || emailTextField.text != ""{
            self.checkPW.checkPasswordAndEmail(_password: pasword, _email: email, _viewFrom: self)
        }else{
            
            
            
//            let alertM = AlertMessages()
            alertM.warningAlertMessage(_AlertMessage: "Password and email Should fill", _viewCFrom: self)
//            //Login faceid and touchId
////            athentication.authenticateUser(_viewIdentifire: "HomeVC", _viewFrom: self)
        }
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
    func activityIndicator(_ title: String) {
        
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.9)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    
    
    
}
