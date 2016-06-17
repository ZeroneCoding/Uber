//
//  AddPayPage.swift
//  Uber
//
//  Created by 李银 on 16/6/14.
//  Copyright © 2016年 liyin. All rights reserved.
//

import UIKit

class AddPayPage: FxBasePage, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var datas:[PayInfo]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Pay"
        
        setNavigationItem("Back.png", selector: #selector(FxBasePage.lastPageBtnClick), isRight: false)
        setNavigationItem("Verify", selector: #selector(doVerifyPhone), isRight: true)
        
        initDatas()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        self.tableView.reloadData()

    }
    
    func doVerifyPhone() {
        
        let page = VerifyPhonePage()
        let navPage = UINavigationController(rootViewController:page)
        
        self.presentViewController(navPage, animated: true, completion: nil)
        
    }
    
    func initDatas() {
        var data:PayInfo!
        let dict:[String:String] = [
            "百度钱包" : "BaiDuWallet.png",
            "银联" : "YinLian.png",
            "支付宝" : "AliPay.png",
            "国际信用卡" : "CreditCard.png"]
        
        datas = []
        for (key, value) in dict {
            
            data = PayInfo()
            
            data.name = key
            data.icon = value
            
            datas?.append(data)
        }
        
    }
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let page = YinLianPage()
        self.navigationController?.pushViewController(page, animated: true)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identify:String = "CellID"
        let cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell
        
        let data = datas[indexPath.row]
        
        cell.accessoryType = .None
        cell.textLabel?.text = data.name
        cell.imageView?.image = UIImage(named: data.icon)
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
