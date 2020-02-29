//
//  AddEventViewController_Extention.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/26/20.
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

extension AddEventViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate{
    
    
    func validateFields() -> String? {
        
        if eventTitle.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || eventDescription.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            
            alertMSG.warningAlertMessage(_AlertMessage: EMPTY_FIELDS, _viewCFrom: self)
            return EMPTY_FIELDS
            
        }
        
        return nil
    }
    
    func setElement() {
        eventTitle.styleTextField()
        eventDescription.styleTextField()
        publishButton.styleButton()
        publishButton.buttonRadiusAll()
    }
    func setupProfileImage(){
        
        eventImage.layer.cornerRadius = 20
        eventImage.clipsToBounds = true
        //        testImagePicker.isUserInteractionEnabled = true
        eventImage.isUserInteractionEnabled = true
        let tapGester = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        eventImage.addGestureRecognizer(tapGester)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as?
            UIImage{
            image = imageSelected
            eventImagePicker.image = imageSelected
            eventImagePicker.image = imageSelected
            
        }
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as?
            UIImage{
            image = imageOriginal
            eventImagePicker.image = imageOriginal
            
        }
        picker.dismiss(animated: true, completion: nil)
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
    
    
    func locationSet(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        latitude = location.latitude
        longitude = location.longitude

        LocationDetails.latitude = location.latitude
        LocationDetails.longitude = location.longitude
        
        let geoCoder = CLGeocoder()
        let locationn = CLLocation(latitude: latitude!, longitude:  longitude!)
        
        geoCoder.reverseGeocodeLocation(locationn, completionHandler: { (placemarks, _) -> Void in
            
            placemarks?.forEach { (placemark) in
                
                if let CityName = placemark.locality {
                    
                    self.location.value = CityName as! String
                    
                }
            }
        })
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
