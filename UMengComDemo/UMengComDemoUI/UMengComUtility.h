//
//  UMengComUtility.h
//  UMengComDemo
//
//  Created by 张军华 on 2018/1/24.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import <Foundation/Foundation.h>


//#pragma mark - 16进制色值转RGB
#define UIColorFromRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//@interface UMengComUtility : NSObject
//
//@end
