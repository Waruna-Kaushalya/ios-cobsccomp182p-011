//
//  SignUPViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/7/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage



var EMPTY_FIELDS = "Please Fill All Field"
let PASSWRD_DOSENT_MATCH = "Password doesn't match"
let WEAK_PASSWORD = "Please make sure your password is at least 8 char, special chr and number"
let WEAK_EMAIL = "Please enter valied email address"
let USER_ERROR = "Error creating user"
var ERROR_SAVING_DATA = "Error saving user data"


class SignUPViewController: UIViewController,UITextFieldDelegate{
    
    
    @IBOutlet weak var testImagePicker: UIImageView!
    @IBOutlet weak var profileImageUIImage: UIImageView!
    @IBOutlet weak var firstNameTestField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var contactNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var facebookURLTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginInButton: UIButton!
    
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    
    let firbaseProfileimageUrl = "gs://ios-nibm.appspot.com"
    
    let alertMSG = AlertMessages()
    let trancVc = TransitionController()
    
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setElement()
        setupProfileImage()
        
        
    }
    
    
    @IBAction func signINButtonTapped(_ sender: Any) {
        
        guard let imageSelected  = self.image else{
            alertMSG.warningAlertMessage(_AlertMessage: "Please Select Profile Image", _viewCFrom: self)
            return
        }
        
        let error = validateFields()
        
        
        if error != nil{
            
            alertMSG.warningAlertMessage(_AlertMessage: error!, _viewCFrom: self)
            
        }else{
            //create cleand version of user
            let firstName = firstNameTestField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let phoneNumber = contactNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let facebookURL = facebookURLTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let confirmPassword = confirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            activityIndicator("SignIN")
            
            
            //Image compreess extension
            let myImage = imageSelected.resizeWithWidth(width: 700)!
            
            let imageData = myImage.jpegData(compressionQuality: 0.1)
            
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                if err != nil {
                    //there was error creating the user
                    self.alertMSG.warningAlertMessage(_AlertMessage: USER_ERROR, _viewCFrom: self)
                    
                }else{
                    
                    let storageRef = Storage.storage().reference(forURL: self.firbaseProfileimageUrl)
                    let storageProfileRef = storageRef.child("profile").child(result!.user.uid)
                    
                    let metaData = StorageMetadata()
                    
                    metaData.contentType = "image/jpg"
                    storageProfileRef.putData(imageData!, metadata: metaData, completion: { (storageMetaData, error) in
                        if error != nil{
                            print("Errrror")
                            return
                        }
                        
                        //Read image url
                        storageProfileRef.downloadURL(completion: { (url, error) in
                            if let metaImageUrl = url?.absoluteString{
                                
                                self.pushDataToFireBase(_UID: result!.user.uid, _firstName: firstName, _lastName: lastName, _email: email, _phoneNumber: phoneNumber, _facebookUrl: facebookURL, _imageURL:metaImageUrl)
                                
                            }
                        })
                    })
                }
            }
        }
    }
    
    
    @IBOutlet weak var profileImageTapped: UIImageView!
    
}
