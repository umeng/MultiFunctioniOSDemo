//
//  UMMobClickGameAnalyticsSwiftInterface.swift
//  UMengDemo
//
//  Created by 张军华 on 2017/5/31.
//  Copyright © 2017年 UMeng. All rights reserved.
//

import Foundation

class UMGameAnalyticsSwiftInterface: NSObject {
    
//  account function
    static func profileSignInWithPUID(puid:String){
        MobClickGameAnalytics.profileSignIn(withPUID: puid);
    }
    
    static func profileSignInWithPUID(puid:String,provider:String){
        MobClickGameAnalytics.profileSignIn(withPUID: puid, provider: provider);
    }
    

    static func profileSignOff(){
        MobClickGameAnalytics.profileSignOff();
    }
    
// GameLevel methods
    static func setUserLevelId(level:String){
        MobClickGameAnalytics.setUserLevel(level)
    }

//关卡统计
    static func startLevel(level:String){
        MobClickGameAnalytics.startLevel(level);
    }
    
    static func finishLevel(level:String){
        MobClickGameAnalytics.finishLevel(level);
    }
    
    static func failLevel(level:String){
        MobClickGameAnalytics.failLevel(level);
    }
    
    
//  Pay methods
    static func exchange(orderId:String,currencyAmount:Double,currencyType:String,virtualCurrencyAmount:Double,paychannel:Int){
        MobClickGameAnalytics .exchange(orderId, currencyAmount: currencyAmount, currencyType: currencyType, virtualCurrencyAmount: virtualCurrencyAmount, paychannel:Int32(paychannel));
    }
    
    static func pay(cash:Double,source:Int,coin:Double){
        MobClickGameAnalytics.pay(cash, source:Int32(source), coin: coin);
    }
    
    static func pay(cash:Double,source:Int,item:String,amount:Int,price:Double){
        MobClickGameAnalytics.pay(cash, source: Int32(cash), item: item, amount: Int32(amount), price: price);
    }
    
    
//  Buy methods
    static func buy(item:String,amount:Int,price:Double){
        MobClickGameAnalytics.buy(item, amount: Int32(amount), price: price);
    }
    
//Use methods
    static func use(item:String,amount:Int,price:Double){
        MobClickGameAnalytics.use(item, amount: Int32(amount), price: price);
    }
    
//  Bonus methods
    static func bonus(coin:Double,source:Int){
        MobClickGameAnalytics.bonus(coin, source: Int32(source));
    }
    
    static func bonus(item:String,amount:Int,price:Double,source:Int){
        MobClickGameAnalytics.bonus(item, amount: Int32(amount), price: price, source: Int32(source));
    }
}
