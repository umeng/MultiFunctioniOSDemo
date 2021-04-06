//
//  UMENGAAID.h
//  UMENGAAID
//
//  Created by UMENGAAID on 8/29/20.
//  Copyright © 2020 UMENGAAID. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMZid : NSObject

/// SDK初始化，异步请求zid
/// @param appkey     appkey
/// @param completion 请求zid的回调，zid为返回值，如果失败，zid为空字符串@“”
+ (void)initWithAppKey:(NSString *)appkey completion:(void (^)(NSString *zid))completion;

/// 同步获得zid，失败返回空字符串@“”
+ (NSString *)getZID;

/// 获取SDK版本号
+ (NSString *)getSDKVersion;

/// 获得resetToken
+ (NSString *)getResetToken;
@end
