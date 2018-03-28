//
//  UMCommonSwiftInterface.swift
//  UMengDemo
//
//  Created by 张军华 on 2017/5/31.
//  Copyright © 2017年 UMeng. All rights reserved.
//

import Foundation

class UMCommonSwiftInterface: NSObject {
    
    static func initWithAppkey(appKey:String,channel:String){
        UMConfigure.initWithAppkey(appKey, channel: channel);
    }
    
    static func setLogEnabled(bFlag:Bool){
        UMConfigure.setLogEnabled(bFlag);
    }
    
    static func setEncryptEnabled(value:Bool){
        UMConfigure.setEncryptEnabled(value);
    }
    
    static func umidString() -> String{
        return UMConfigure.umidString();
    }
}
