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
let USER_ERROR = "Error creating user"
var ERROR_SAVING_DATA = "Error saving user data"

class SignUPViewController: UIViewController {
    
    
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
    
    let firbaseProfileimageUrl = "gs://ios-nibm.appspot.com"
    
    let alertMSG = AlertMessage()
    let trancVc = TransitionVC()
    
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setElement()
        setupProfileImage()
    }
    func setElement(){
        TextFieldUtilities.styleTextField(firstNameTestField)
        TextFieldUtilities.styleTextField(lastNameTextField)
        TextFieldUtilities.styleTextField(contactNumberTextField)
        TextFieldUtilities.styleTextField(emailTextField)
        TextFieldUtilities.styleTextField(facebookURLTextField)
        TextFieldUtilities.styleTextField(passwordTextField)
        TextFieldUtilities.styleTextField(confirmPasswordTextField)
        
        ButtonUtilities.ButtonRadius_All(signInButton)
        ButtonUtilities.styleButton(signInButton)
    }
    
    func validateFields() -> String? {
        
        //check that all fields are field in
        
        if firstNameTestField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || contactNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || facebookURLTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            
            alertMSG.alertMessage(_AlertMessage: EMPTY_FIELDS, _viewCFrom: self)
            return EMPTY_FIELDS
            
        }
        if passwordTextField.text != confirmPasswordTextField.text {
            
            alertMSG.alertMessage(_AlertMessage: PASSWRD_DOSENT_MATCH, _viewCFrom: self)
            return PASSWRD_DOSENT_MATCH
        }
        //heck if the password is secure
        
        let cleanePassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if PasswordUtilities.isPasswordValid(cleanePassword) == false {
            alertMSG.alertMessage(_AlertMessage: WEAK_PASSWORD, _viewCFrom: self)
            return WEAK_PASSWORD
        }
        return nil
    }
    
    func setupProfileImage(){
        
        profileImageUIImage.layer.cornerRadius = 40
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
    
    @IBAction func signINButtonTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil{
            alertMSG.alertMessage(_AlertMessage: error!, _viewCFrom: self)
            
        }else{
            //create cleand version of user
            let firstName = firstNameTestField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let contactNumber = contactNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let facebookURL = facebookURLTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let confirmPassword = confirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            //Profile image things
            guard let imageSelected  = self.image else{
                print("Avter is nil")
                return
            }
            guard  let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
                return
            }
            
            
            
            //Create the user
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                if err != nil {
                    //there was error creating the user
                    self.alertMSG.alertMessage(_AlertMessage: USER_ERROR, _viewCFrom: self)
                    
                }else{
                    //user was created sucessfully. now store the details
                    
//                    self.pushDataToFireBase(_UID: result!.user.uid, _firstName: firstName, _lastName: lastName, _email: email, _contactnumber: contactNumber, _facebookUrl: facebookURL, _imageURL:metaImageUrl)
//                    self.transHome.transHome(_viewCIdentifire: "LoginVC", _viewCFrom: self)

                    
                    //------------------
                    
                    
                    //
                    var imageURL: String?
                    
                    let storageRef = Storage.storage().reference(forURL: self.firbaseProfileimageUrl)
                    let storageProfileRef = storageRef.child("profile").child(result!.user.uid)
                    
                    let metaData = StorageMetadata()
                    metaData.contentType = "image/jpg"
                    storageProfileRef.putData(imageData, metadata: metaData, completion: { (storageMetaData, error) in
                        if error != nil{
                            print("Errrror")
                            return
                        }
                        
                        //Read image url
                        storageProfileRef.downloadURL(completion: { (url, error) in
                            if let metaImageUrl = url?.absoluteString{
                                print(metaImageUrl)
                            
                                
                                self.pushDataToFireBase(_UID: result!.user.uid, _firstName: firstName, _lastName: lastName, _email: email, _contactnumber: contactNumber, _facebookUrl: facebookURL, _imageURL:metaImageUrl)
                                
                            }
                        })
                    })
                }
            }
        }
    }
    
    func pushDataToFireBase(_UID:String,_firstName:String, _lastName:String, _email:String, _contactnumber:String, _facebookUrl:String, _imageURL: String )  {
        let db = Firestore.firestore()
        db.collection("users").addDocument(data: ["uid":_UID, "firstname" : _firstName, "lastname" : _lastName, "email": _email, "contactNumber":_contactnumber, "facebookurl":_facebookUrl, "imageURL":_imageURL ]) { (error) in
            if error != nil {
                
                self.alertMSG.alertMessage(_AlertMessage: ERROR_SAVING_DATA, _viewCFrom: self)
                
            }else{
                self.trancVc.trancVC(_viewCIdentifire: "LoginVC", _viewCFrom: self)
            }
        }
        
    }
    
    @IBOutlet weak var profileImageTapped: UIImageView!
    
}



extension SignUPViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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
    
    
}

