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
    
    let trans  = TransitionController()
    let alert = AlertMessages()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendEmailButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        
    }
    
    func setupElements(){
        
        
        sendEmailButton.buttonRadiusAll()
        sendEmailButton.styleButton()
        
        emailTextField.styleTextField()

    }
    
    @IBAction func restPasswordTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, email != "" else{
            alert.warningAlertMessage(_AlertMessage: ERROR_EMPTY_EMAIL_REST, _viewCFrom: self)
            return
        }
        resetPassword(email: email)
        
        trans.trancVC(_viewCIdentifire: "LoginVC", _viewCFrom: self)
    }
    
    func resetPassword(email:String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error == nil {
                self.alert.warningAlertMessage(_AlertMessage: "Psswrd rest email sent", _viewCFrom: self)
            }else{
                self.alert.warningAlertMessage(_AlertMessage: "Somthing Error", _viewCFrom: self)
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        super.viewDidAppear(animated)
        let height: CGFloat = 30 //whatever height you want to add to the existing height
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
        
        
    }
}
