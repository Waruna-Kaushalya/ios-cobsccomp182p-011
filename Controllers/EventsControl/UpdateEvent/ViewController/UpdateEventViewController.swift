//
//  EventEditViewController.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/27/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseStorage
import CoreLocation
import RxSwift


class UpdateEventViewController: UIViewController {
    
    @IBOutlet weak var currentEventTitle: UILabel!
    @IBOutlet weak var currentEventDescription: UILabel!
    
    @IBOutlet weak var updatedEventTitleTextField: UITextField!
    @IBOutlet weak var updatedEventDescriptionlabel: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    
    @IBOutlet weak var closeBtn: UIButton!
    
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    let alertMSG = AlertMessages()
    let trancVc = TransitionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
        
    }
    
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
    
    @IBAction func closeButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func updateButtonAction(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil{
            alertMSG.warningAlertMessage(_AlertMessage: error!, _viewCFrom: self)
        }else{
            
            activityIndicator("Updating")
            
            UpdateEventStruct.eventTitle = updatedEventTitleTextField.text!
            UpdateEventStruct.eventDescription = updatedEventDescriptionlabel.text!
            
            UpdateEventDataToFirebase.updateEventDataToFirebase(eventIdentifire: UpdateEventStruct.eventID)
            
            if CreateEventStruct.flag == true{

                let trans = TransitionController()
                trans.trancVC(_viewCIdentifire: "HomeVC", _viewCFrom: self)
            }
            else{
                self.alertMSG.warningAlertMessage(_AlertMessage: ERROR_SAVING_DATA, _viewCFrom: self)
            }
        }
    }
}
