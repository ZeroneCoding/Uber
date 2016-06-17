//
//  VerifyPhonePage.swift
//  Uber
//
//  Created by 李银 on 16/6/17.
//  Copyright © 2016年 liyin. All rights reserved.
//

import UIKit

class VerifyPhonePage: FxBasePage {

    @IBOutlet weak var number1: UITextField!
    @IBOutlet weak var number2: UITextField!
    @IBOutlet weak var number3: UITextField!
    @IBOutlet weak var number4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Verify"
        
        setNavigationItem("Close.png", selector: #selector(FxBasePage.lastPageBtnClick), isRight: false)
        
    }
    
    
    @IBAction func doValueChanged(textField: UITextField) {
        let tag = textField.tag
        
        if textField.text!.isEmpty {
            if tag-1 > 0 {
                let prexField = self.view.viewWithTag(tag - 1) as! UITextField
                
                prexField.becomeFirstResponder()
            }
        }else {
            if tag+1 <= 4 {
                let nextField = self.view.viewWithTag(tag+1) as! UITextField
                
                nextField.becomeFirstResponder()
                
            }
        }
        if tag == 4 {
            textField.resignFirstResponder()
            doVerify()
        }
        
    }
    
    func doVerify() {
        self.showIndicator("Verify", autoHide: true, afterDelay: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
