//
//  PushEventDataFireBase.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/25/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage


class PushDataToFireBase {
    
    
    func pushDataToFireBase()  {
        
        
        var goingCount:Int = 0
        var goingUsers = [String]()
        
        let db = Firestore.firestore()
        db.collection("event").addDocument(data: ["userID":CreateEventStruct.userID,"eventtitle":CreateEventStruct.eventTitleTxt,"eventdescription":CreateEventStruct.eventDescriptionTxt,"eventImageUrl":CreateEventStruct.metaImageUrl,"eventID":CreateEventStruct.eventID ,"goingCount":goingCount,"goingUsers":goingUsers ]) { (error) in
            if error != nil {
                
                
                print("err saving data")
                CreateEventStruct.flag = false
                //            return false
                
                //            _ViewController.alertMSG.warningAlertMessage(_AlertMessage: ERROR_SAVING_DATA, _viewCFrom: _ViewController)
                
                
            }else{
                
                 print("done")
                CreateEventStruct.flag = true
                //            return true
                //            let trans = TransitionController()
                //            trans.trancVC(_viewCIdentifire: "HomeVC", _viewCFrom: _ViewController)
                
            }
        }
    }
}
