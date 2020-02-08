//
//  AlertMessage.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/8/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation

import UIKit


class AlertMessage {
    func alertMessage(_AlertMessage: String, _viewCFrom:UIViewController)  {
        
        
        
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
}
