//
//  UMAlertView.h
//  UMengComDemo
//
//  Created by shile on 2018/1/31.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMAlertView : UIView
-(instancetype)initSuccessAlertViewWithTitle:(NSString *)title content:(NSString *)content;
-(instancetype)initErrorAlertViewWithTitle:(NSString *)title content:(NSString *)content;
-(instancetype)initMessageViewWithTitle:(NSString *)title content:(NSString *)content;
-(void)showAlert;
@end
