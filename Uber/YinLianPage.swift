//
//  YinLianPage.swift
//  Uber
//
//  Created by 李银 on 16/6/15.
//  Copyright © 2016年 liyin. All rights reserved.
//

import UIKit

class YinLianPage: FxBasePage, UPPayPluginDelegate, NSURLConnectionDataDelegate {

    var responseData:NSMutableData?
    
    override func viewDidLoad() {
        self.title = "Pay"
    }

    override func didReceiveMemoryWarning() {
    }
    
    @IBAction func doPay(sender: AnyObject) {
        
        let url = NSURL(string: YLTnURL)
        startPay(url!)
    }
    
    func startPay(url:NSURL) {
        let urlRequest = NSURLRequest(URL: url)
        let connect = NSURLConnection(request: urlRequest, delegate: self)
        
        connect?.start()
    }
    
    func UPPayPluginResult(result: String!) {
        FxLog(result)
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        
        let urlResponse = response as! NSHTTPURLResponse
        
        if urlResponse.statusCode != 200 {
            FxLog("eeror status code")
            print("code:", urlResponse.statusCode)
            
        }else{
            responseData = NSMutableData()
        }
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        responseData?.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        
        let result = String(data: responseData!, encoding: NSUTF8StringEncoding)
        
        if result != nil {
            FxPayPlugin.startPayFx(result, mode: "01", viewController: self, delegate: self)
        }
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        FxLog(error.localizedFailureReason!)
    }

}
