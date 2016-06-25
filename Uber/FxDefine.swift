//
//  FxDefine.swift
//  Uber
//
//  Created by 李银 on 16/6/13.
//  Copyright © 2016年 liyin. All rights reserved.
//

import Foundation

let LoadingTip = "加载中..."

func FxLog(msg:String, function:String = #function) {
    #if DEBUG
        print("Log:\(msg), \(function)")
    #else

    #endif
}

let PanWidth:CGFloat = 100