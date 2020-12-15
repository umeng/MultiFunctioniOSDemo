//
//  UMCrashConfigure.h
//  UMCrash
//
//  Created by wangkai on 2020/9/3.
//  Copyright © 2020 wangkai. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NSString *_Nullable(^CallbackBlock)(void);

@interface UMCrashConfigure : NSObject
//获取sdk版本号
+ (NSString *_Nonnull)getVersion;

//return字符串不能大于256字节，大于部分将被截取
+ (void)setCrashCBBlock:(CallbackBlock _Nullable )cbBlock;

@end

