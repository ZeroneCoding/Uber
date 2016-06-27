//
//  UserCenterPage.swift
//  Uber
//
//  Created by 李银 on 16/6/18.
//  Copyright © 2016年 liyin. All rights reserved.
//

import UIKit

class UserCenterPage: FxBasePage {

    var owner:FxBasePage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func doSetting(sender: AnyObject) {
        let own = self.owner as! HomePage
        
        own.doShowSetting()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
