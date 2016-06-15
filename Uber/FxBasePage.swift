//
//  FxBasePage.swift
//  Uber
//
//  Created by 李银 on 16/6/13.
//  Copyright © 2016年 liyin. All rights reserved.
//

import UIKit

class FxBasePage: FxBaseController {

    @IBOutlet var backView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setNavigationItem(titile:String, selector:Selector, isRight:Bool) {
        
        var item:UIBarButtonItem!
        
        if titile.hasSuffix("png") {
            item = UIBarButtonItem(image: UIImage(named: titile), style: .Plain, target: self, action: selector)
        } else {
            item = UIBarButtonItem(title: titile, style: .Plain, target: self, action: selector)
        }
        
        item.tintColor = UIColor.darkGrayColor()
        
        if isRight {
            self.navigationItem.rightBarButtonItem = item
        } else {
            self.navigationItem.leftBarButtonItem = item
        }
    }

    func nextPageBtnClick() {
        
    }
    
    func lastPageBtnClick() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
