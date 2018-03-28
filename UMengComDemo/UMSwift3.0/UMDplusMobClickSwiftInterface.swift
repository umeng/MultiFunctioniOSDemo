//
//  UMDplusMobClickSwiftInterFace.swift
//  UMengDemo
//
//  Created by 张军华 on 2017/5/31.
//  Copyright © 2017年 UMeng. All rights reserved.
//

import Foundation

class UMDplusMobClickSwiftInterface: NSObject {
    
    static func track(eventName:String){
        DplusMobClick.track(eventName);
    }
    
    static func track(eventName:String,property:Dictionary<String, Any>){
        DplusMobClick.track(eventName, property: property);
    }
    

    static func registerSuperProperty(property:Dictionary<String, Any>){
        DplusMobClick.registerSuperProperty(property);
    }
    
    static func unregisterSuperProperty(propertyName:String){
        DplusMobClick.unregisterSuperProperty(propertyName);
    }
    

    static func getSuperProperty(propertyName:String) -> String{
        return DplusMobClick.getSuperProperty(propertyName);
    }
    
    static func getSuperProperties() -> Dictionary<String, Any>{
        return DplusMobClick.getSuperProperties() as! Dictionary<String, Any>;
    }
    
    static func clearSuperProperties(){
        DplusMobClick.clearSuperProperties();
    }
    
    static func setFirstLaunchEvent(eventList:Array<Any>){
        DplusMobClick.setFirstLaunchEvent(eventList);
    }
}
