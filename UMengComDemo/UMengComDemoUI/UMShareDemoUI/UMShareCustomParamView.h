//
//  UMShareCustomParamView.h
//  UMengComDemo
//
//  Created by wyq.Cloudayc on 01/02/2018.
//  Copyright © 2018 张军华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UMShare/UMShare.h>

typedef NS_ENUM(NSUInteger, UMS_SHARE_TYPE)
{
    UMS_SHARE_TYPE_TEXT,
    UMS_SHARE_TYPE_IMAGE,
    UMS_SHARE_TYPE_IMAGE_MULTI,
    UMS_SHARE_TYPE_IMAGE_URL,
    UMS_SHARE_TYPE_TEXT_IMAGE,
    UMS_SHARE_TYPE_WEB_LINK,
    UMS_SHARE_TYPE_MUSIC_LINK,
    UMS_SHARE_TYPE_MUSIC,
    UMS_SHARE_TYPE_VIDEO_LINK,
    UMS_SHARE_TYPE_VIDEO,
    UMS_SHARE_TYPE_EMOTION,
    UMS_SHARE_TYPE_FILE,
    UMS_SHARE_TYPE_MINI_PROGRAM
};

#define UMSCUSTOM_PARAM_TEXT @1 //@"文本"
#define UMSCUSTOM_PARAM_TITLE @2 //@"标题"
#define UMSCUSTOM_PARAM_DESCR @3 //@"描述"
#define UMSCUSTOM_PARAM_LINK @4 //@"链接"
#define UMSCUSTOM_PARAM_IMAGE @5 //@"本地图片"
#define UMSCUSTOM_PARAM_IMAGE_URL @6 //@"网络图片"
#define UMSCUSTOM_PARAM_THUMB @7 //@"缩略图"

typedef void (^UMSocialCustomParamCompletionHandler)(UMS_SHARE_TYPE type, NSDictionary *data);

@interface UMShareCustomParamView : UIView

- (void)showCustomShareWithType:(UMS_SHARE_TYPE)type
                     completion:(UMSocialCustomParamCompletionHandler)completion;

@end
