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
import CoreLocation
import RxSwift

class AddEventViewController: UIViewController {
    
    @IBOutlet weak var eventImagePicker: UIImageView!
    @IBOutlet weak var eventImage: UIStackView!
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var eventDescription: UITextField!
    @IBOutlet weak var publishButton: UIButton!
    
    let locationManager = CLLocationManager()
    let checkUserLoginStatus = CheckUserLoginStatus()
    
    var latitude : Double?
    var longitude : Double?
    
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    let alertMSG = AlertMessages()
    let trancVc = TransitionController()
    
    let firbaseProfileimageUrl = "gs://ios-nibm.appspot.com"
    
    
    var image: UIImage? = nil
    
    
    var disposebag = DisposeBag()
    public let location = Variable("")
    var locationData : Observable<String>{
        return location.asObservable()
    }
    
    
    override func viewDidLoad() {
        
        self.locationSet()

        if checkUserLoginStatus.checkUserLoginStatus() != true {
            let alert = AlertMessages()
            alert.ActionAlert(_title: "User not login", _message: "User must login to add event", _viewCIdentifier: "LoginNavIVC", _viewControllerName: self)
        }
        
        super.viewDidLoad()
        setElement()
        setupProfileImage()
        
    }
    
    @objc func presentPicker(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
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
            
            let userID : String = (Auth.auth().currentUser?.uid)!
            CreateEventStruct.userID = userID
            
            //Image compreess extension
            let myImage = imageSelected.resizeWithWidth(width: 700)!
            
            let compressData = myImage.jpegData(compressionQuality: 0.1)
            
            let storageRef = Storage.storage().reference(forURL: self.firbaseProfileimageUrl)
            let storageProfileRef = storageRef.child("eventImages").child(CreateEventStruct.userID)
            
            let metaData = StorageMetadata()
            
            metaData.contentType = "image/jpg"
            
            storageProfileRef.putData(compressData!, metadata: metaData, completion: { (storageMetaData, error) in
                if error != nil{
                    //                    print("Errrror")
                    return
                }
                
                storageProfileRef.downloadURL(completion: { (url, error) in
                    if let metaImageUrl = url?.absoluteString{
                        CreateEventStruct.metaImageUrl = metaImageUrl

                        let uuid = UUID().uuidString
                        CreateEventStruct.eventID = uuid
  
                        
                        self.locationData.subscribe(onNext:{
                            [weak self] location in
                            
                            
                            print(location)
                            CreateEventStruct.userCurrentLocation = location
                           
                        })
                        
                        //                    self.pushDataToFireBase()
                        let pushData = AddEventDataFireBase()
                        pushData.addEventDataToFirebase()
                        
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
    
}
