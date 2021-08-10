//
//  UMAnalyticsSwiftInterface.swift
//  UMengDemo
//
//  Created by 张军华 on 2017/5/31.
//  Copyright © 2017年 UMeng. All rights reserved.
//

import Foundation
import CoreLocation

class UMAnalyticsSwiftInterface: NSObject {
    
//基础设置
    
    
 
    
//页面计时
    static func logPageView(pageName:String,seconds:Int){
        MobClick.logPageView(pageName, seconds:Int32(seconds));
    }
    
    static func beginLogPageView(pageName:String){
        MobClick.beginLogPageView(pageName);
    }
    
    static func endLogPageView(pageName:String){
        MobClick.endLogPageView(pageName);
    }
    
//事件统计
    static func event(eventId:String){
        MobClick.event(eventId);
    }
    
    static func event(eventId:String,label:String){
        MobClick.event(eventId, label: label);
    }
    
    static func event(eventId:String,attributes:Dictionary<String, Any>){
        MobClick.event(eventId, attributes:attributes);
    }
    
    static func event(eventId:String,attributes:Dictionary<String, Any>,counter:Int){
        MobClick.event(eventId, attributes: attributes, counter: Int32(counter));
    }
    
    static func beginEvent(eventId:String){
        MobClick.beginEvent(eventId);
    }
    
    static func endEvent(eventId:String){
        MobClick.endEvent(eventId);
    }
    
    static func beginEvent(eventId:String,label:String){
        MobClick.beginEvent(eventId, label: label);
    }

    static func endEvent(eventId:String,label:String){
        MobClick.endEvent(eventId, label: label);
    }
    
    static func beginEvent(eventId:String,primarykey:String,attributes:Dictionary<String, Any>){
        MobClick.beginEvent(eventId, primarykey: primarykey, attributes: attributes);
    }
    
    static func endEvent(eventId:String,primarykey:String){
        MobClick.endEvent(eventId, primarykey: primarykey);
    }
    
    //+ (void)event:(NSString *)eventId durations:(int)millisecond;
    static func event(eventId:String,durations:Int){
        //此处调用oc的方法有问题????
        //let someString = "Some string literal value"
        //MobClick.event(someString, durations: Int32(millisecond));
        //MobClick.event(someString, durations: 32);
        //MobClick.event(eventId, durations: Int32(durations));
        
        MobClick.event(eventId, label: "", durations: Int32(durations));
    }
    
    
    static func event(eventId:String,label:String,millisecond:Int){
        MobClick.event(eventId, label: label, durations: Int32(millisecond));
    }
    
    
    static func event(eventId:String,attributes:Dictionary<String, Any>,millisecond:Int){
        MobClick.event(eventId, attributes: attributes, durations: Int32(millisecond));
    }
    

// user methods
    static func profileSignInWithPUID(puid:String){
        MobClick.profileSignIn(withPUID: puid);
    }
    static func profileSignInWithPUID(puid:String,provider:String){
        MobClick.profileSignIn(withPUID:puid, provider: provider);
    }
    
    static func profileSignOff(){
        MobClick.profileSignOff();
    }
    
    static func setLatitude(latitude:Double,longitude:Double){
        MobClick.setLatitude(latitude, longitude: longitude);
    }
    

    
    static func isJailbroken() -> Bool{
        return MobClick.isJailbroken();
    }
    
    static func isPirated() -> Bool{
        return MobClick.isPirated();
    }
    
    static func setSecret(secret:String){
        MobClick.setSecret(secret);
    }
    

}
