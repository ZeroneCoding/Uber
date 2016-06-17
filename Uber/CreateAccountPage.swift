//
//  CreateAccountPage.swift
//  Uber
//
//  Created by 李银 on 16/6/14.
//  Copyright © 2016年 liyin. All rights reserved.
//

import UIKit

class CreateAccountPage: FxBasePage {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "CreateAccount"
        
        setNavigationItem("Next", selector: #selector(FxBasePage.nextPageBtnClick), isRight: true)
        setNavigationItem("Back.png", selector: #selector(FxBasePage.lastPageBtnClick), isRight: false)
        
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func nextPageBtnClick() {
        
        let page = UserInfoPage()
        
        self.navigationController?.pushViewController(page, animated: true)
    }
    
    @IBAction func selectCountryBtnClick(sender: AnyObject) {
        
        let page = SelectCountryPage()
        let navPage = UINavigationController(rootViewController:page)
        self.presentViewController(navPage, animated: true, completion: nil)
    }
    
    
    
}
