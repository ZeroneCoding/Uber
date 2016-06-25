//
//  HomePage.swift
//  Uber
//
//  Created by 李银 on 16/6/18.
//  Copyright © 2016年 liyin. All rights reserved.
//

import UIKit

class HomePage: FxBasePage {

    var leftView:UIView?
    var backControl:UIControl!
    var showingLeft:Bool!
    var userCenterPage:UserCenterPage?

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackControl()
        
        self.title = "Main"
        setNavigationItem("Left", selector: Selector("doShowLeft"), isRight: false)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        showingLeft = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.addLeftView()
        self.addUserCenterView()
    }
    
    func doShowLeft() {
        if showingLeft! {
            showCenterPanel()
        }else{
            showLeftPanel()
        }
    }
    
    func doTapCenter(sender:UIButton) {
        if showingLeft! {
            showCenterPanel()
        }
    }
    
    func addUserCenterView() {
        userCenterPage = UserCenterPage()
        userCenterPage!.view.frame = leftView!.bounds
        
        leftView?.addSubview(userCenterPage!.view)
    }

    func addLeftView() {
        if leftView == nil {
            var frame:CGRect! = self.navigationController!.view.bounds
            
            frame.origin.x = -frame.size.width+PanWidth
            frame.size.width -= PanWidth
            
            leftView = UIView(frame: frame)
            leftView?.backgroundColor = UIColor.blackColor()
            self.navigationController?.view.addSubview(leftView!)
        }
    
    }
    
    func addBackControl() {
        if backControl == nil {
            let frame = self.navigationController!.view.bounds
            backControl = UIControl(frame: frame)
            backControl.backgroundColor = UIColor.blackColor()
            backControl.alpha = 0.5
            backControl.addTarget(self, action: #selector(HomePage.doTapCenter(_:)), forControlEvents: .TouchUpInside)
            
            self.navigationController!.view.addSubview(backControl)
            
            self.navigationController!.view.sendSubviewToBack(backControl)
        }
    }
    
    func showCenterView(view:UIView, offset:CGFloat, shadow:Bool) {
        if shadow {
            view.layer.shadowColor = UIColor.blackColor().CGColor
            view.layer.shadowOpacity = 0.2
            view.layer.shadowOffset = CGSizeMake(offset, offset)
        }else{
            view.layer.cornerRadius = 0.0
            view.layer.shadowOpacity = 0.0
            view.layer.shadowOffset = CGSizeMake(offset, offset)
        }
    }
    
    func showLeftPanel() {
        showingLeft = true
        showCenterView(leftView!, offset: -2, shadow: true)
        
        UIView.animateKeyframesWithDuration(1.0, delay: 0, options: .BeginFromCurrentState, animations: { 
            
            var frame = self.leftView?.frame
            frame?.origin.x = 0
            self.leftView?.frame = frame!
            
            frame = self.navigationController?.navigationBar.frame
            frame?.origin.x = (frame?.size.width)! - PanWidth
            self.navigationController?.navigationBar.frame = frame!
            
        }) { (fished:Bool) in
            if fished {
                self.navigationController!.view.bringSubviewToFront(self.backControl)
                self.navigationController?.view.bringSubviewToFront(self.leftView!)
            }
        }
    }
    
    func showCenterPanel() {
        showingLeft = false
        
        UIView.animateKeyframesWithDuration(1.0, delay: 0, options: .BeginFromCurrentState, animations: {
            
            var frame = self.leftView?.frame
            frame?.origin.x = -frame!.size.width
            self.leftView?.frame = frame!
            
            frame = self.navigationController?.navigationBar.frame
            frame?.origin.x = 0
            self.navigationController?.navigationBar.frame = frame!

        }) { (fished:Bool) in
            if fished {
                self.navigationController!.view.sendSubviewToBack(self.backControl)
                self.showCenterView(self.leftView!, offset: 0, shadow: false)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
