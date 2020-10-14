//
//  UMCrashConfigure.h
//  UMCrash
//
//  Created by wangkai on 2020/9/3.
//  Copyright © 2020 wangkai. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CallbackBlock)(void);

@interface UMCrashConfigure : NSObject

+ (void)setCrashCBBlock:(CallbackBlock)cbBlock;

@end

