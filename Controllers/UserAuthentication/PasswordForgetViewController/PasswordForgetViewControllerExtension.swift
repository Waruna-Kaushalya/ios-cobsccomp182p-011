//
//  PasswordForgetViewControllerExtension.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/29/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//
import UIKit
import FirebaseAuth

extension PasswordForgetViewController{
    func setupElements(){
        
        
        sendEmailButton.buttonRadiusAll()
        sendEmailButton.styleButton()
        
        emailTextField.styleTextField()
        
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -100, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -100, up: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}
