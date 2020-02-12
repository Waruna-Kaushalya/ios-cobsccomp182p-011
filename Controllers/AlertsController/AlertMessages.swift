//
//  AlertMessage.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/8/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation

import UIKit


class AlertMessages {
    func warningAlertMessage(_AlertMessage: String, _viewCFrom:UIViewController)  {
        
        
        
        let alert = UIAlertController(title: "Alert", message: _AlertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        _viewCFrom.present(alert, animated: true, completion: nil)
    }
    func ActionAlert(_title:String,_message:String,_viewCIdentifier:String, _viewControllerName:UIViewController)  {
        let alertController = UIAlertController(title: _title, message: _message, preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            
            trans.trancVC(_viewCIdentifire: _viewCIdentifier, _viewCFrom: _viewControllerName)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        _viewControllerName.present(alertController, animated: true, completion: nil)
    }
}
