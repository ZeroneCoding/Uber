//
//  HomePage.swift
//  Uber
//
//  Created by 李银 on 16/6/18.
//  Copyright © 2016年 liyin. All rights reserved.
//

import UIKit

class HomePage: FxBasePage, BMKMapViewDelegate, BMKLocationServiceDelegate {

    var leftView:UIView?
    var backControl:UIControl!
    var showingLeft:Bool!
    var centerPage:UserCenterPage?
    
    var mapView:BMKMapView?
    var locaService:BMKLocationService?
    var userCoordinate:CLLocationCoordinate2D?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBaiDuMap()
        addBackControl()
        self.title = "Main"
        setNavigationItem("Left", selector: #selector(HomePage.doShowLeft), isRight: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        showingLeft = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mapView?.delegate = self

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.addLeftView()
        self.addUserCenterView()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        mapView?.delegate = nil
    }
    
        
}
