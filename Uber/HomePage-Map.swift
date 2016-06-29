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

extension HomePage:BMKPoiSearchDelegate, BMKRouteSearchDelegate {
    
    func addBaiDuMap() {
        
        mapView = BMKMapView(frame: self.view.frame)
        self.view .addSubview(mapView!)
        mapView?.zoomLevel = 15
        
        geoCode = BMKGeoCodeSearch()
        poiSearch = BMKPoiSearch()
        routeSearch = BMKRouteSearch()
        
        startLocation()
    }
    
    @IBAction func doSearchPoi() {
        let option = BMKCitySearchOption()
        option.city = "北京"
        option.keyword = "北京南站"
        poiSearch?.poiSearchInCity(option)
    }
    
    func onGetPoiResult(searcher: BMKPoiSearch!, result poiResult: BMKPoiResult!, errorCode: BMKSearchErrorCode) {
        mapView?.removeAnnotations(mapView?.annotations)
        
        if errorCode == BMK_SEARCH_NO_ERROR {
            var annotetions:[BMKPointAnnotation] = []
            for i in 0...poiResult.poiInfoList.count-1 {
                let poi = poiResult.poiInfoList[i]
                let item = BMKPointAnnotation()
                
                item.coordinate = poi.pt
                item.title = poi.name
                
                annotetions.insert(item, atIndex: i)
            }
            
            mapView?.addAnnotations(annotetions)
            mapView?.showAnnotations(annotetions, animated: true)
            
        }else{
            print(errorCode)
        }
    }
    
    @IBAction func doSearchRoute() {
        let start = BMKPlanNode()
        start.name = "龙泽"
        let end = BMKPlanNode()
        end.name = "西单"
        
        let routeOption = BMKTransitRoutePlanOption()
        routeOption.city = "北京市"
        routeOption.from = start
        routeOption.to = end
        
        let flag:Bool! = routeSearch?.transitSearch(routeOption)
        
        if flag! {
            print("OK")
        }else{
            print("error")
        }
    }
    
    func onGetTransitRouteResult(searcher: BMKRouteSearch!, result: BMKTransitRouteResult!, errorCode error: BMKSearchErrorCode) {
        if error == BMK_SEARCH_NO_ERROR {
            print("Routing Draw OK")
        }else{
            print("Routing Draw Error")
        }
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
        startTimer()
        getCarArraiveTime()
    }
    
    func addCars() {
        mapView?.removeOverlays(mapView?.overlays)
        if point != nil {
            mapView?.removeAnnotation(point)
        }
        
        point = BMKPointAnnotation()
        
        point!.coordinate = CLLocationCoordinate2D(latitude: userCoordinate!.latitude+0.003, longitude: userCoordinate!.longitude+0.005)
        point!.title = "Car"
        
        mapView?.addAnnotation(point!)
    }
    
    func getCarArraiveTime() {
        let point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(39.915, 116.404))
        let point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(38.915, 115.404))
        let distance = BMKMetersBetweenMapPoints(point1, point2)
        
        print(distance)
        let time = distance / (50*1000)
        print(time)
        
    }
    
    func startTimer() {
        timer = NSTimer(timeInterval: 1.0, target: self, selector: #selector(HomePage.updateCars), userInfo: nil, repeats: true)
        
        timer?.fire()
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    func updateCars() {
        userCoordinate?.latitude += 0.0002
        userCoordinate?.longitude += 0.0002
        
        addCars()
    }
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        let car = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: "PID")
        
        car.draggable = false
        
        return car
    }
    
    func mapView(mapView: BMKMapView!, regionDidChangeAnimated animated: Bool) {
        let point = mapView.convertPoint(tuDingBtn.center, toCoordinateFromView: self.view)
        let option = BMKReverseGeoCodeOption()
        option.reverseGeoPoint = point
        geoCode!.reverseGeoCode(option)
    }
    
    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        addressLabel.text = result.address
    }
    
}