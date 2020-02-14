//
//  CurrentUserDataRetrivel.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/12/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class getData {
    
    func read(_ completion:@escaping(String)->Void,_fieldname:String){
        
        let docRef = Firestore.firestore().collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "")
        
        print(Auth.auth().currentUser?.uid ?? "")
        docRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            } else if querySnapshot!.documents.count != 1 {
                print("More than one documents or none")
            } else {
                let document = querySnapshot!.documents.first
                let dataDescription = document?.data()
                // guard let fieldValue = dataDescription?[_fieldname]
                // else {
                //   return
                // }
                let fieldValue = dataDescription?[_fieldname] ?? ""
                // var abc = fieldValue ?? ""
                // print(abc)
                completion(fieldValue as! String)
                
            }
            
        }
        
    }
    
}
