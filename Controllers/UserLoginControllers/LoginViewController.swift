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
import SkyFloatingLabelTextField


class LoginViewController: UIViewController {
    
    let utiliti = TextFieldUtilities()
    let alertMessage = AlertMessages()
    let checkPW = CheckPasswordAndEmail()
    let trans = TransitionController()
    let athentication = TouchFaceIDAuthentication()
    
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var signInButton: UIButton!
    
    
    
    var context = LAContext()
    
    enum AuthenticationState {
        case loggedin, loggedout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        ElementsStyle.setElement(_textFieldsName: text1, _placeHolder: "email")
        //        ElementsStyle.setElement(_textFieldsName: text2, _placeHolder: "passwrd")
        
        //        LoginViewController.textFieldStyle(passwordTxtField, "email", "email", self)
        
        
        
        
        //        textFieldStyle(emaiilTxtField, "email", "email", self)
        //        textFieldStyle(passwordTxtField, "email", "email", self)
        //        TextFieldUtilities.textFieldStyle(emaiilTxtField, "email", "email", self)
        //        TextFieldUtilities.textFieldStyle(passwordTxtField, "password", "password", self)
        setupElements()
        context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
    }
    static func textFieldStyle(_ textField:SkyFloatingLabelTextField,_ placeholder:String,_ title:String,_ viewController:UIViewController){
        
        let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
        let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
        let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
        
        //        let textField1 = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 120, height: 45))
        //        textField1.placeholder = "First name"
        //        textField1.title = "Given name"
        //        self.view.addSubview(textField1)
        
        //        let textField2 = SkyFloatingLabelTextField(frame: emaiilTxtField)
        textField.placeholder = "Last name"
        textField.title = "Family name"
        
        textField.tintColor = overcastBlueColor // the color of the blinking cursor
        textField.textColor = darkGreyColor
        textField.lineColor = lightGreyColor
        textField.selectedTitleColor = overcastBlueColor
        textField.selectedLineColor = overcastBlueColor
        
        textField.lineHeight = 1.0 // bottom line height in points
        textField.selectedLineHeight = 2.0
        viewController.view.addSubview(textField)
        
    }
    func setupElements(){
        
        TextFieldUtilities.setTextFieldStyle(_textFieldsName: emailTextField, _placeHolder: "email")
        TextFieldUtilities.setTextFieldStyle(_textFieldsName: passwordTextField, _placeHolder: "passwrd")
        //        ElementsStyle.setElement(_textFieldsName: text3, _placeHolder: "dddd")
        
        //        TextFieldUtilities.textFieldStyle(emaiilTxtField, "email", "email", self)
        //         TextFieldUtilities.textFieldStyle(passwordTxtField, "password", "password", self)
        
        
        
        //    abc.textFieldStyle(emaiilTxtField, "email", "email", self)
        
        
        
        //        TextFieldUtilities.textFieldStyle(_textField: emaiilTxtField, _placeholder: "Email", _title: "email", _viewController: self)
        //
        //        TextFieldUtilities.textFieldStyle(_textField: passwordTxtField, _placeholder: "Password", _title: "password", _viewController: self)
        
        //        TextFieldUtilities.styleTextField(emailTextField)
        //        TextFieldUtilities.styleTextField(passwordTextField)
        //
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
}
