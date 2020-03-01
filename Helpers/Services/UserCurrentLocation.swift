//
//  CurrentLocation.swift
//  NIBM Events
//
//  Created by Waruna Kaushalya on 2/29/20.
//  Copyright © 2020 Waruna Kaushalya. All rights reserved.
//

import UIKit

import CoreLocation
import RxSwift



class UserCurrentLocation:NSObject,CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let checkUserLoginStatus = CheckUserLoginStatus()
    
    var latitude : Double?
    var longitude : Double?
    
    public let location = Variable("")
    
    func locationSet(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as! CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        latitude = location.latitude
        longitude = location.longitude
        
        LocationDetailsStruct.latitude = location.latitude
        LocationDetailsStruct.longitude = location.longitude
        
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
}
