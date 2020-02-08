//
//  TouchFaceIDAuthentication.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/8/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth
import FirebaseFirestore
import LocalAuthentication

let alertM = AlertMessage()
let transVC = TransitionVC()

class TouchFaceIDAuthentication {
    func authenticateUser(_viewIdentifire: String,_viewFrom:UIViewController) {
        
        let context = LAContext()
        
        var error: NSError?
        
        if context.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
            error: &error) {
            
            // Device can use biometric authentication
            context.evaluatePolicy(
                LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Access requires authentication",
                reply: {(success, error) in
                    DispatchQueue.main.async {
                        
                        if let err = error {
                            
                            switch err._code {
                                
                            case LAError.Code.systemCancel.rawValue:
                                
                                print("Session cancelled")
                                
                            case LAError.Code.userCancel.rawValue:
                                
                                print("Please try again")
                                
                            case LAError.Code.userFallback.rawValue:
                                
                                // Custom code to obtain password here
                                
                                print("Password option selected")
                            default:
                                
                                print("Authentication failed")
                            }
                            
                        } else {
                            trans.trancVC(_viewCIdentifire: _viewIdentifire, _viewCFrom: _viewFrom)
                            print("Authentication Successful")
                        }
                    }
            })
            
        } else {
            // Device cannot use biometric authentication
            
            alertM.alertMessage(_AlertMessage: "Password and email Should fill", _viewCFrom: _viewFrom)
            
            if let err = error {
                switch err.code {
                    
                case LAError.Code.biometryNotEnrolled.rawValue:
                    
                    print("User is not enrolled")
                    
                case LAError.Code.passcodeNotSet.rawValue:
                    
                    print("A passcode has not been set")
                    
                case LAError.Code.biometryNotAvailable.rawValue:
                    print("Biometric authentication not available")
                default:
                    
                    print("Unknown error")
                }
            }
        }
    }
}
