//
//  SelectCountryPage.swift
//  Uber
//
//  Created by 李银 on 16/6/15.
//  Copyright © 2016年 liyin. All rights reserved.
//

import UIKit

class SelectCountryPage: FxBasePage, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var countrys:[CountryInfo]?
    var headers:[String]?
    var dictDatas:[String:AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SelectCountry"
        
        setNavigationItem("Cancel", selector: #selector(FxBasePage.lastPageBtnClick), isRight: false)
        
        initCountry()
        initDatas()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        
        self.tableView.reloadData()

    }
    
    func initCountry() {
        let arrCodes = NSLocale.ISOCountryCodes()
        let locale:NSLocale = NSLocale.currentLocale()
        
        countrys = []
        
        for code in arrCodes {
            
            let info = CountryInfo()
            info.code = code
            info.name = locale.displayNameForKey(NSLocaleCountryCode, value: code)!
            
            countrys?.append(info)
        }
        
        countrys?.sortInPlace({ (arg1:CountryInfo, arg2:CountryInfo) -> Bool in
            return arg1.name.localizedCaseInsensitiveCompare(arg2.name) == .OrderedAscending
        })
    }
    
    func initDatas() {
        
        var firstLetter:String!
        var datas:[CountryInfo]!
        
        headers = []
        datas = []
        dictDatas = [:]
        
        for country in countrys! {
            firstLetter = FxString.firstCharactor(country.name)
            
            if !(headers!.contains(firstLetter)) {
                if datas.count > 0 {
                    dictDatas![headers!.last!] = datas
                }
                
                headers?.append(firstLetter)
                datas = []
            }
            
            datas.append(country)
        }
        
        dictDatas![headers!.last!] = datas
        
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
