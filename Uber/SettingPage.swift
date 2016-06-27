//
//  SettingPage.swift
//  Uber
//
//  Created by 李银 on 16/6/19.
//  Copyright © 2016年 liyin. All rights reserved.
//

import UIKit

class SettingPage: FxBasePage {

    @IBOutlet var userBackView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem("Close.png", selector: #selector(FxBasePage.lastPageBtnClick), isRight: false)
        
        self.title = "Setting"
        
        var frame = userBackView.frame
        frame.origin.y = 64
        userBackView.frame = frame
        
        self.view.addSubview(userBackView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
