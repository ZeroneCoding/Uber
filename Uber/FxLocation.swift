//
//  FxLocation.swift
//  Uber
//
//  Created by 李银 on 16/6/14.
//  Copyright © 2016年 liyin. All rights reserved.
//

import UIKit
import CoreLocation

class FxLocation: NSObject, CLLocationManagerDelegate {
    
    var manager:CLLocationManager?
    
    func startLocation() {
        
        if CLLocationManager.locationServicesEnabled() {
            manager = CLLocationManager()
            manager?.delegate = self
            manager?.desiredAccuracy = kCLLocationAccuracyBest
            manager?.distanceFilter = 100
            
            manager?.startUpdatingLocation()
            if #available(iOS 8.0, *) {
                manager?.requestAlwaysAuthorization()
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        FxLog(String(status))
    }
    
    func searchAddress(location:CLLocation) {
        
        let corder = CLGeocoder()
        corder.reverseGeocodeLocation(location) { (marks, error) in
            if marks != nil {
                for mark in marks! {
                    FxLog(mark.name!)
                }
            }
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        searchAddress(newLocation)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        searchAddress(locations[0])
        
        manager.stopUpdatingLocation()
    }
    
   
    
}
