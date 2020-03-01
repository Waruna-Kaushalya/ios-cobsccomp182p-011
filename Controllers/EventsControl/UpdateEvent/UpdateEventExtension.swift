//
//  UpdateEventExtension.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/27/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage
import RxSwift
import CoreLocation
import RxSwift

extension UpdateEventViewController:CLLocationManagerDelegate{
    
    func setupElements() {
        
        updatedEventTitleTextField.styleTextField()
        updatedEventDescriptionlabel.styleTextField()
        
        updateBtn.styleButton()
        updateBtn.buttonRadiusAll()
        
        currentEventTitle.text = UpdateEventStruct.eventTitle
        currentEventDescription.text = UpdateEventStruct.eventDescription
        
        
    }
    func validateFields() -> String? {
        
        //check that all fields are field in
        
        if updatedEventTitleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || updatedEventDescriptionlabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            alertMSG.warningAlertMessage(_AlertMessage: EMPTY_FIELDS, _viewCFrom: self)
            return EMPTY_FIELDS
            
        }
        
        return nil
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -50, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -50, up: false)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
}

