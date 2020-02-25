//
//  AddEventViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/14/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage

class AddEventViewController: UIViewController {
    
    @IBOutlet weak var eventImagePicker: UIImageView!
    @IBOutlet weak var eventImage: UIStackView!
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var eventDescription: UITextField!
    @IBOutlet weak var publishButton: UIButton!
    
    let alertMSG = AlertMessages()
    let trancVc = TransitionController()
    
    let firbaseProfileimageUrl = "gs://ios-nibm.appspot.com"
    
    
    
    
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        
        let  aa = CheckUserLoginStatus()
        
        if aa.checkUserLoginStatus() != true {
            let alert = AlertMessages()
            alert.ActionAlert(_title: "User not login", _message: "User must login to add event", _viewCIdentifier: "LoginNavIVC", _viewControllerName: self)
        }
        
        super.viewDidLoad()
        setElement()
        setupProfileImage()
        
    }
    
    func setElement() {
        eventTitle.styleTextField()
        eventDescription.styleTextField()
        publishButton.styleButton()
    }
    func setupProfileImage(){
        
        eventImage.layer.cornerRadius = 20
        eventImage.clipsToBounds = true
        //        testImagePicker.isUserInteractionEnabled = true
        eventImage.isUserInteractionEnabled = true
        let tapGester = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        eventImage.addGestureRecognizer(tapGester)
        
    }
    @objc func presentPicker(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    func validateFields() -> String? {
        
        //check that all fields are field in
        //
        
        if eventTitle.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || eventDescription.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            
            alertMSG.warningAlertMessage(_AlertMessage: EMPTY_FIELDS, _viewCFrom: self)
            return EMPTY_FIELDS
            
        }
        
        return nil
    }
    
    
    @IBAction func publishedButtonTapped(_ sender: Any) {
        
        
        
        CreateEventStruct.eventTitleTxt = eventTitle.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        CreateEventStruct.eventDescriptionTxt = eventDescription.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
                let userID : String = (Auth.auth().currentUser?.uid)!
        CreateEventStruct.userID = userID
        
        print("Current user ID is " + CreateEventStruct.userID)
        
        guard let imageSelected  = self.image else{
            alertMSG.warningAlertMessage(_AlertMessage: "Please Select Profile Image", _viewCFrom: self)
            return
        }
        
        
        
        
        //compress image size ****
        guard  let imageData = imageSelected.jpegData(compressionQuality: 0.0) else {
            return
        }
        
        
        let storageRef = Storage.storage().reference(forURL: self.firbaseProfileimageUrl)
        let storageProfileRef = storageRef.child("eventImages").child(CreateEventStruct.userID)
        
        
        
        let metaData = StorageMetadata()
        
        
        metaData.contentType = "image/jpg"
        
        
        storageProfileRef.putData(imageData, metadata: metaData, completion: { (storageMetaData, error) in
            if error != nil{
                print("Errrror")
                return
            }
            
            storageProfileRef.downloadURL(completion: { (url, error) in
                if let metaImageUrl = url?.absoluteString{
                    CreateEventStruct.metaImageUrl = metaImageUrl
                    print(metaImageUrl)
                    
                    let uuid = UUID().uuidString
                    CreateEventStruct.eventID = uuid
                    print(uuid)
                    
//                    self.pushDataToFireBase()
                    let pushData = PushDataToFireBase()
                    pushData.pushDataToFireBase()
                    
                    if CreateEventStruct.flag == true{
                        let trans = TransitionController()
                        trans.trancVC(_viewCIdentifire: "HomeVC", _viewCFrom: self)
                    }
                    else{
                        self.alertMSG.warningAlertMessage(_AlertMessage: ERROR_SAVING_DATA, _viewCFrom: self)
                    }
                    
                }
            })
        })
        
    }
//    func pushDataToFireBase()  {
//        
//
//        var goingCount:Int = 0
//        var goingUsers = [String]()
//        
//        let db = Firestore.firestore()
//        db.collection("event").addDocument(data: ["userID":CreateEventStruct.userID,"eventtitle":CreateEventStruct.eventTitleTxt,"eventdescription":CreateEventStruct.eventDescriptionTxt,"eventImageUrl":CreateEventStruct.metaImageUrl,"eventID":CreateEventStruct.eventID ,"goingCount":goingCount,"goingUsers":goingUsers ]) { (error) in
//            if error != nil {
//                
//                
//                
//                self.alertMSG.warningAlertMessage(_AlertMessage: ERROR_SAVING_DATA, _viewCFrom: self)
//                
//            }else{
//                
//                let trans = TransitionController()
//                trans.trancVC(_viewCIdentifire: "HomeVC", _viewCFrom: self)
//                
//            }
//        }
//    }
}

extension AddEventViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as?
            UIImage{
            image = imageSelected
            eventImagePicker.image = imageSelected
            eventImagePicker.image = imageSelected
            
        }
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as?
            UIImage{
            image = imageOriginal
            eventImagePicker.image = imageOriginal
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}





