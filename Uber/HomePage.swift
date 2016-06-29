//
//  HomePage.swift
//  Uber
//
//  Created by 李银 on 16/6/18.
//  Copyright © 2016年 liyin. All rights reserved.
//

import UIKit

class HomePage: FxBasePage, BMKMapViewDelegate, BMKGeoCodeSearchDelegate, BMKLocationServiceDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var firstCar: UIButton!
    @IBOutlet weak var tuDingBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    
    var leftView:UIView?
    var backControl:UIControl!
    var showingLeft:Bool!
    var centerPage:UserCenterPage?
    
    var mapView:BMKMapView?
    var locaService:BMKLocationService?
    var userCoordinate:CLLocationCoordinate2D?
    
    var timer:NSTimer?
    var point:BMKPointAnnotation?
    var geoCode:BMKGeoCodeSearch?
    var btnHelper:FxButtonHelper?
    var isMoveUp:Bool!
    var poiSearch:BMKPoiSearch?
    var routeSearch:BMKRouteSearch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBaiDuMap()
        addBackControl()
        setNavigationItem("account_icon_up@2x.png", selector: #selector(HomePage.doShowLeft), isRight: false)
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo_uber_grey_zh_CN@2x.png"))
        
        btnHelper = FxButtonHelper()
        
        self.view.bringSubviewToFront(bottomView!)
        self.doSwapCar(firstCar)
        
        isMoveUp = false
        addTapGesture()
        
        self.view.bringSubviewToFront(topView)
        self.view.bringSubviewToFront(tuDingBtn)
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
        geoCode?.delegate = self
        poiSearch?.delegate = self
        routeSearch?.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.addLeftView()
        self.addUserCenterView()
        self.stopTimer()
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        super.viewDidDisappear(animated)
        mapView?.delegate = nil
        geoCode?.delegate = nil
        poiSearch?.delegate = nil
        routeSearch?.delegate = nil
    }
    
    @IBAction func doSwapCar(sender: AnyObject) {
        btnHelper?.normalImageName = ""
        btnHelper?.selectedImageName = "CarBtn.png"
        
        btnHelper?.setButtonEx(sender as! UIButton)
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomePage.doTapBack))
        bottomView.addGestureRecognizer(tap)
    }
    
    func doTapBack() {
        isMoveUp = !isMoveUp
        animationView()
    }
    
    func animationView() {
        UIView.animateWithDuration(0.5, animations: { 
            var frame = self.bottomView.frame
            if self.isMoveUp! {
                frame.origin.y = self.view.bounds.size.height-frame.size.height
            }else{
                frame.origin.y = self.view.bounds.size.height-80
            }
            self.bottomView.frame = frame
        })
    }
        
}
