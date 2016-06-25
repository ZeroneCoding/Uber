//
//  UserCenterPage.swift
//  Uber
//
//  Created by 李银 on 16/6/18.
//  Copyright © 2016年 liyin. All rights reserved.
//

import UIKit

class UserCenterPage: FxBasePage {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func doSetting(sender: AnyObject) {
        let page = SettingPage()
        
        let navPage = UINavigationController(rootViewController:page)
        self.presentViewController(navPage, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
