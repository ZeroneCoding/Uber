//
//  HomePage-Map.swift
//  Uber
//
//  Created by 李银 on 16/6/25.
//  Copyright © 2016年 liyin. All rights reserved.
//

import Foundation

class CarAnimationView: BMKAnnotationView {
    var imageView:UIImageView!
    
    override init!(annotation: BMKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        self.backgroundColor = UIColor.clearColor()
        
        imageView = UIImageView(image: UIImage(named: "map-taxi.png"))
        imageView.frame = self.bounds
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(Coder:) has not been implemented")
    }
}

extension HomePage {
    
    func addBaiDuMap() {
        
        mapView = BMKMapView(frame: self.view.frame)
        self.view .addSubview(mapView!)
        mapView?.zoomLevel = 15
        startLocation()
    }
    
    func startLocation() {
        locaService = BMKLocationService()
        locaService?.delegate = self

        locaService?.startUserLocationService()
        
        mapView?.showsUserLocation = true
        userCoordinate = CLLocationCoordinate2D(latitude: 40.115, longitude: 116.404)
    }
    
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        userCoordinate = userLocation.location.coordinate
        print(userCoordinate?.latitude)
        mapView?.centerCoordinate = userCoordinate!
        mapView?.updateLocationData(userLocation)
        addCars()
    }
    
    func addCars() {
        let point = BMKPointAnnotation()
        
        point.coordinate = CLLocationCoordinate2D(latitude: userCoordinate!.latitude+0.003, longitude: userCoordinate!.longitude+0.005)
        point.title = "Car"
        
        mapView?.addAnnotation(point)
    }
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        let car = CarAnimationView(annotation: annotation, reuseIdentifier: "PID")
        
        car.draggable = false
        
        return car
    }
    
}