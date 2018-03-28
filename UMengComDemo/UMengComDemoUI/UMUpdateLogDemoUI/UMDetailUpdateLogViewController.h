//
//  UMDetailUpdateLogViewController.h
//  UMengComDemo
//
//  Created by 张军华 on 2018/1/23.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, UMengComUpdateLogType)
{
    UMengComUpdateLogType_UApp,
    UMengComUpdateLogType_UPush,
    UMengComUpdateLogType_UShare,
};


extern NSString* UMengComLogName(UMengComUpdateLogType updateLogType);

@interface UMDetailUpdateLogViewController : UIViewController


@property(nonatomic,readwrite,assign)UMengComUpdateLogType  updateLogType;

@property(nonatomic,readwrite,strong)NSString* jsonFilePath;


@end
