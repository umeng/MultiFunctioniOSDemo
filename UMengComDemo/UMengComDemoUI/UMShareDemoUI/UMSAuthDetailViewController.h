//
//  UMSAuthDetailViewController.h
//  UMSocialSDK
//
//  Created by wyq.Cloudayc on 11/10/16.
//  Copyright © 2016 UMeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UMShare/UMShare.h>

#import "UMSBaseViewController.h"


@interface UMSAuthInfo : NSObject

@property (nonatomic, assign) UMSocialPlatformType platform;
@property (nonatomic, strong) UMSocialUserInfoResponse *response;

+ (instancetype)objectWithType:(UMSocialPlatformType)platform;

@end


@interface UMSAuthDetailViewController : UMSBaseViewController

@property (nonatomic, strong) UMSAuthInfo *authInfo;

+ (UMSAuthDetailViewController *)detailVCWithInfo:(UMSAuthInfo *)authInfo;

@end
