//
//  GetGoingDataFirebase.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/26/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage


class GetGoingDataFromFirebase{
    
    func getGoingDataFromFirebase(eventIdentifire:String){
        let docRef = Firestore.firestore().collection("event").whereField("eventID", isEqualTo: eventIdentifire)
        
        docRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            } else if querySnapshot!.documents.count != 1 {
                print("More than one documents or none")
            } else {
                let document = querySnapshot!.documents.first
                let dataDescription = document?.data()
                
                GoingCountStruct.goingCountNumber = dataDescription?["goingCount"] as! Int
                GoingCountStruct.goingUserList = dataDescription?["goingUsers"]  as! [String]

                if GoingCountStruct.goingUserList.count != 0  {

                }
                else{
                    print("going count nil")
                    GoingCountStruct.goingCountNumber = 0
                }
            }
        }
    }
}
