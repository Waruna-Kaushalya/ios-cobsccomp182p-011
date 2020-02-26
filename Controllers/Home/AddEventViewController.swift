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
    
    //    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var eventImagePicker: UIImageView!
    @IBOutlet weak var eventImage: UIStackView!
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var eventDescription: UITextField!
    @IBOutlet weak var publishButton: UIButton!
    
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    
    
    
    
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
        
        guard let imageSelected  = self.image else{
            alertMSG.warningAlertMessage(_AlertMessage: "Please Select Profile Image", _viewCFrom: self)
            return
        }
        
        let error = validateFields()
        
        if error != nil{
            alertMSG.warningAlertMessage(_AlertMessage: error!, _viewCFrom: self)
        }else{
            
            activityIndicator("Saving data")
            
            CreateEventStruct.eventTitleTxt = eventTitle.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            CreateEventStruct.eventDescriptionTxt = eventDescription.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //        var activityView = UIActivityIndicatorView(style: .gray)
            //        activityView.center = self.view.center
            //        self.view.addSubview(activityView)
            //        activityView.startAnimating()
            
            
            //        activityIndicator("Saving Data")
            //waiting code add
            //        activityIndicator.center = self.view.center
            //        activityIndicator.hidesWhenStopped = true
            ////
            //        view.subviews(activityIndicator)
            
            
            
            
            
            let userID : String = (Auth.auth().currentUser?.uid)!
            CreateEventStruct.userID = userID
            
            print("Current user ID is " + CreateEventStruct.userID)
            
            
            
           
            
            
            
            
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





