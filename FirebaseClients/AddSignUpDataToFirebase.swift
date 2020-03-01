//
//  AddSignUpDataToFirebase.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/29/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import FirebaseStorage
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AddSignUpDataToFirebase{
    
    let alertMSG = AlertMessages()
    let trancVc = TransitionController()
    
    func AddSignUpDataToFirebase(_viewController:UIViewController){
        Auth.auth().createUser(withEmail: SignUPDataStruct.email, password: SignUPDataStruct.password) { (result, err) in
            
            if err != nil {
                //there was error creating the user
                self.alertMSG.warningAlertMessage(_AlertMessage: USER_ERROR, _viewCFrom: _viewController)
                
            }else{
                
                let storageRef = Storage.storage().reference(forURL: SignUPDataStruct.firbaseProfileimageUrl)
                let storageProfileRef = storageRef.child("profile").child(result!.user.uid)
                
                let metaData = StorageMetadata()
                
                metaData.contentType = "image/jpg"
                storageProfileRef.putData(SignUPDataStruct.imagedata!, metadata: metaData, completion: { (storageMetaData, error) in
                    if error != nil{
                        print("Errrror")
                        return
                    }
                    
                    //Read image url
                    storageProfileRef.downloadURL(completion: { (url, error) in
                        if let metaImageUrl = url?.absoluteString{
                            
                            self.pushDataToFireBase(_UID: result!.user.uid, _firstName: SignUPDataStruct.firstName, _lastName: SignUPDataStruct.lastName, _email: SignUPDataStruct.email, _phoneNumber: SignUPDataStruct.phoneNumber, _facebookUrl: SignUPDataStruct.facebookURL, _imageURL:metaImageUrl)
                            
                        }
                    })
                })
            }
        }
    }
    func pushDataToFireBase(_UID:String,_firstName:String, _lastName:String, _email:String, _phoneNumber:String, _facebookUrl:String, _imageURL: String )  {
        let db = Firestore.firestore()
        db.collection("users").addDocument(data: ["uid":_UID, "firstname" : _firstName, "lastname" : _lastName, "email": _email, "phoneNumber":_phoneNumber, "facebookurl":_facebookUrl, "imageURL":_imageURL ]) { (error) in
            if error != nil {
                
                self.alertMSG.warningAlertMessage(_AlertMessage: ERROR_SAVING_DATA, _viewCFrom: SignUPDataStruct.viewController!)
                
            }else{
                self.trancVc.trancVC(_viewCIdentifire: "LoginVC", _viewCFrom: SignUPDataStruct.viewController!)
            }
        }
    }
}
