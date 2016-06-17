//
//  FxURLDefine.swift
//  Uber
//
//  Created by 李银 on 16/6/13.
//  Copyright © 2016年 liyin. All rights reserved.
//

import Foundation



func serverAddress() -> String {
    var address = "http:172.16.19.18"
    #if AppStore
        address = "http://www.uber.com"
    #endif
    return address
    
}

let YLTnURL = "http://http://202.101.25.178:8080/sim/gettn"
