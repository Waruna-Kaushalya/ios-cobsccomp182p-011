//
//  SignUPExtension.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/28/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage

extension SignUPViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func setElement(){
        
        firstNameTestField.styleTextField()
        lastNameTextField.styleTextField()
        contactNumberTextField.styleTextField()
        emailTextField.styleTextField()
        facebookURLTextField.styleTextField()
        passwordTextField.styleTextField()
        confirmPasswordTextField.styleTextField()
        
        signInButton.styleButton()
        signInButton.buttonRadiusAll()
    }
    
    func validateFields() -> String? {
        
        //check that all fields are field in
        
        if firstNameTestField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || contactNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || facebookURLTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            
            alertMSG.warningAlertMessage(_AlertMessage: EMPTY_FIELDS, _viewCFrom: self)
            return EMPTY_FIELDS
            
        }
        if passwordTextField.text != confirmPasswordTextField.text {
            
            alertMSG.warningAlertMessage(_AlertMessage: PASSWRD_DOSENT_MATCH, _viewCFrom: self)
            return PASSWRD_DOSENT_MATCH
        }
        //check if the password is secure
        
        let cleanePassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        if PasswordUtilities.isPasswordValid(cleanePassword) == false {
            alertMSG.warningAlertMessage(_AlertMessage: WEAK_PASSWORD, _viewCFrom: self)
            return WEAK_PASSWORD
        }
        
        let cleaneEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if EmailUtilities.validateEmail(cleaneEmail) == false {
            alertMSG.warningAlertMessage(_AlertMessage: WEAK_EMAIL, _viewCFrom: self)
            return WEAK_PASSWORD
        }
        return nil
    }
    
    func setupProfileImage(){
        
        profileImageUIImage.layer.cornerRadius = 20
        profileImageUIImage.clipsToBounds = true
        //        testImagePicker.isUserInteractionEnabled = true
        profileImageUIImage.isUserInteractionEnabled = true
        let tapGester = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        profileImageUIImage.addGestureRecognizer(tapGester)
        
    }
    @objc func presentPicker(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func pushDataToFireBase(_UID:String,_firstName:String, _lastName:String, _email:String, _phoneNumber:String, _facebookUrl:String, _imageURL: String )  {
        let db = Firestore.firestore()
        db.collection("users").addDocument(data: ["uid":_UID, "firstname" : _firstName, "lastname" : _lastName, "email": _email, "phoneNumber":_phoneNumber, "facebookurl":_facebookUrl, "imageURL":_imageURL ]) { (error) in
            if error != nil {
                
                self.alertMSG.warningAlertMessage(_AlertMessage: ERROR_SAVING_DATA, _viewCFrom: self)
                
            }else{
                self.trancVc.trancVC(_viewCIdentifire: "LoginVC", _viewCFrom: self)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as?
            UIImage{
            image = imageSelected
            profileImageUIImage.image = imageSelected
            
        }
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as?
            UIImage{
            image = imageOriginal
            profileImageUIImage.image = imageOriginal
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        super.viewDidAppear(animated)
        let height: CGFloat = 30 //whatever height you want to add to the existing height
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
        
        
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
