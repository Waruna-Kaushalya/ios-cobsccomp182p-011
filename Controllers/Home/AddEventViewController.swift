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
        super.viewDidLoad()
        setElement()
        setupProfileImage()
//        setDataToFireBase()
        
        
    }
//    func setDataToFireBase(){
//        let db = Firestore.firestore()
//        let newDocument = db.collection("Event").document()
//        newDocument.setData(["EventTitle" : "NIBM 2017", "EventDescription": "dbbjsdvbhjbdbvjsdb vjhb hj h"])
//    }
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
        
        let eventTitleTxt = eventTitle.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let eventDescriptionTxt = eventDescription.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        let userID : String = (Auth.auth().currentUser?.uid)!
        print("Current user ID is " + userID)
        //Profile image things
        guard let imageSelected  = self.image else{
            alertMSG.warningAlertMessage(_AlertMessage: "Please Select Profile Image", _viewCFrom: self)
            return
        }
        guard  let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
            return
        }
        
        
            
            //                    var imageURL: String?
            
            let storageRef = Storage.storage().reference(forURL: self.firbaseProfileimageUrl)
            let storageProfileRef = storageRef.child("eventImages").child(userID)
//        child("profile").child(result!.user.uid)
        
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
                        
                        
                        
                        self.pushDataToFireBase(_UID: userID, eventTitle: eventTitleTxt, eventDescription: eventDescriptionTxt, _imageURL: metaImageUrl)

                    }
                })
            })
        
//
     
    }
    func pushDataToFireBase(_UID:String,eventTitle:String,eventDescription:String,_imageURL: String )  {
        let db = Firestore.firestore()
        db.collection("event").addDocument(data: ["userID":_UID,"eventtitle":eventTitle,"eventdescription":eventDescription,"eventImageUrl":_imageURL ]) { (error) in
            if error != nil {
            
                self.alertMSG.warningAlertMessage(_AlertMessage: ERROR_SAVING_DATA, _viewCFrom: self)
            
            }else{
                 self.alertMSG.warningAlertMessage(_AlertMessage: "done", _viewCFrom: self)
            }
        }
        
    }
    
    
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
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    //        self.navigationController?.navigationBar.shadowImage = UIImage()
    //
    //
    //        super.viewDidAppear(animated)
    //        let height: CGFloat = 30 //whatever height you want to add to the existing height
    //        let bounds = self.navigationController!.navigationBar.bounds
    //        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
    //
    //
    //    }
    
    
}





