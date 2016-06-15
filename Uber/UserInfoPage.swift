//
//  UserInfoPage.swift
//  Uber
//
//  Created by 李银 on 16/6/14.
//  Copyright © 2016年 liyin. All rights reserved.
//

import UIKit

class UserInfoPage: FxBasePage, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var avatarView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "EditInfo"
        
        avatarView.layer.masksToBounds = true
        avatarView.layer.cornerRadius = 5
        
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 5
        
        setNavigationItem("Next", selector: #selector(FxBasePage.nextPageBtnClick), isRight: true)
        setNavigationItem("Back", selector: #selector(FxBasePage.lastPageBtnClick), isRight: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        avatarView.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func editAvatarBtnClick(sender: AnyObject) {
        
        let page = UIImagePickerController()
        
        page.sourceType = .PhotoLibrary
        page.delegate = self
        
        self.presentViewController(page, animated: true, completion: nil)
        
    }
    
    override func nextPageBtnClick() {
        
        let page = AddPayPage()
        
        self.navigationController?.pushViewController(page, animated: true)
    }

}
