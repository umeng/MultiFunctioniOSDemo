//
//  UMessageSwiftInterface.swift
//  UMengDemo
//
//  Created by 张军华 on 2017/5/31.
//  Copyright © 2017年 UMeng. All rights reserved.
//

import Foundation
import CoreLocation

class UMessageSwiftInterface: NSObject {

    //--required
    static func registerForRemoteNotificationsWithLaunchOptions(launchOptions:Dictionary<String,Any>,entity:UMessageRegisterEntity,completionHandler:@escaping ((_ granted:Bool,_ error:Error?) -> Void)){
        UMessage.registerForRemoteNotifications(launchOptions: launchOptions, entity: entity, completionHandler: completionHandler);
    }
    
    static func unregisterForRemoteNotifications(){
        UMessage.unregisterForRemoteNotifications();
    }
    
    static func registerDeviceToken(deviceToken:Data){
        UMessage.registerDeviceToken(deviceToken);
    }
    
    static func didReceiveRemoteNotification(userInfo:Dictionary<String,Any>){
        UMessage.didReceiveRemoteNotification(userInfo);
    }
    
    //--optional

    static func setBadgeClear(value:Bool){
        UMessage.setBadgeClear(value);
    }
    
    static func setAutoAlert(value:Bool){
        UMessage.setAutoAlert(value);
    }
    
    
    static func sendClickReportForRemoteNotification(userInfo:Dictionary<String,Any>){
        UMessage.sendClickReport(forRemoteNotification: userInfo);
    }
    
    
    ///---------------------------------------------------------------------------------------
    /// @name tag (optional)
    ///---------------------------------------------------------------------------------------
    
    static func getTags(handle:(@escaping ((_ responseTags:Set<AnyHashable>?,_ remain:Int,_ error:Error?) -> Void)))
    {
        UMessage.getTags(handle);
    }
    
    static func addTag(tag:Any?,response:(@escaping (_ responseObject:Any?,_ remain:Int,_ error:Error?) -> Void)){
        UMessage.addTags(tag, response: response);

    }
    
    static func removeTag(tag:Any,response:(@escaping (_ responseObject:Any?,_ remain:Int,_ error:Error?) -> Void)){
       // UMessage.removeTag(tag, response: response);
        UMessage.deleteTags(tag, response: response);
    }
    

//    static func removeAllTags(response:(@escaping (_ responseObject:Any?,_ remain:Int,_ error:Error?) -> Void)){
//       // UMessage.removeAllTags(response);
//    }
    
    
    ///---------------------------------------------------------------------------------------
    /// @name alias (optional)
    ///---------------------------------------------------------------------------------------
    
    static func addAlias(name:String,type:String,response:(@escaping (_ responseObject:Any?,_ error:Error?) -> Void)){
        UMessage.addAlias(name, type: type, response: response);
    }
    
    
    static func setAlias(name:String,type:String,response:(@escaping (_ responseObject:Any?,_ error:Error?) -> Void)){
        UMessage.setAlias(name, type: type, response: response);
    }
    
    static func removeAlias(name:String,type:String,response:(@escaping (_ responseObject:Any?,_ error:Error?) -> Void)){
        UMessage.removeAlias(name, type: type, response: response);
    }
    
}
