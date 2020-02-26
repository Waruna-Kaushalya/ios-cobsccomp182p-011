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
        
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd/MMM/yyyy HH:mm:ss"
        // again convert your date to string
        let eventAddedDate = formatter.string(from: yourDate!)
        
        print(eventAddedDate)
        
        
        
        
//
//        let eventAddedDate = Date()
////        let eventAddedDate = Date(timeIntervalSinceReferenceDate: -123456789.0)
//        print(eventAddedDate)
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd HH:mm"
//        let eventAddedDate = formatter.date(from: "2016/10/08 22:31")
        
        let db = Firestore.firestore()
        db.collection("event").addDocument(data: ["userID":CreateEventStruct.userID,"eventtitle":CreateEventStruct.eventTitleTxt,"eventdescription":CreateEventStruct.eventDescriptionTxt,"eventImageUrl":CreateEventStruct.metaImageUrl,"eventID":CreateEventStruct.eventID ,"goingCount":goingCount,"goingUsers":goingUsers,"eventAddedDate":eventAddedDate ]) { (error) in
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
