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
        
        setNavigationItem("Back", selector: Selector("lastPageBtnClick"), isRight: false)
        
        initDatas()
        
        self.tableView.registerClass(UITableViewCell.self, forHeaderFooterViewReuseIdentifier: "CellID")
        self.view.addSubview(self.tableView)
        self.tableView.reloadData()

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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return headers!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = headers![section]
        let datas = dictDatas![key] as! [CountryInfo]
        
        return datas.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers![section]
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        
        var indexs:[String] = []
        var char:[CChar] = [0,0]
        
        for i in 65...65+26-1 {
            char[0] = CChar(i)
            indexs.append(String.fromCString(char)!)
        }
        
        indexs.append("#")
        
        return indexs
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell:UITableViewCell? = self.tableView.cellForRowAtIndexPath(indexPath)
        
        cell?.accessoryView = UIImageView(image: UIImage(named: "selected.png"))
        
        self.lastPageBtnClick()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identify:String = "CellID"
        let cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell
        
        let key = headers![indexPath.section]
        let datas = dictDatas![key] as! [CountryInfo]
        let country = datas[indexPath.row]
        
        cell.accessoryType = .None
        cell.textLabel?.text = country.name!
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
