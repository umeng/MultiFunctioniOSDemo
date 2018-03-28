//
//  UMAlertView.m
//  UMengComDemo
//
//  Created by shile on 2018/1/31.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import "UMAlertView.h"

@implementation UMAlertView

-(instancetype)initSuccessAlertViewWithTitle:(NSString *)title content:(NSString *)content
{
    self = [super init];
    if (self) {
        [self initAlertViewWithImage:[UIImage imageNamed:@"ok"] title:title content:content];
    }
    return self;
}
-(instancetype)initErrorAlertViewWithTitle:(NSString *)title content:(NSString *)content
{
    self = [super init];
    if (self) {
        [self initAlertViewWithImage:[UIImage imageNamed:@"tippp"] title:title content:content];
    }
    return self;
}

-(instancetype)initMessageViewWithTitle:(NSString *)title content:(NSString *)content
{
    self = [super init];
    if (self) {
        [self initAlertViewWithImage:nil title:title content:content];
    }
    return self;
}

-(void)initAlertViewWithImage:(UIImage *)image title:(NSString *)title content:(NSString *)content
{
  
    self.frame = CGRectMake(0, 0,  [[UIScreen mainScreen] bounds].size.width,  [[UIScreen mainScreen] bounds].size.height) ;
    UIView * maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,  [[UIScreen mainScreen] bounds].size.width,  [[UIScreen mainScreen] bounds].size.height)];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.6;
    [self addSubview:maskView];
    UIView * messageView = [[UIView alloc]init];
    if (image != nil) {
        messageView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 60, 160);
        messageView.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
        messageView.backgroundColor= [UIColor whiteColor];
        [messageView sizeToFit];
        [self addSubview:messageView];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(24, 24, 16, 16)];
        [imageView setImage: image];
        [messageView addSubview:imageView];
        
        UILabel * titleLabel = [self createLabelWithTitle:title];
        titleLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 10, 24, 300, 16);
        titleLabel.numberOfLines = 0;
        [titleLabel sizeToFit];
        [messageView addSubview:titleLabel];
        UITextView * detailInfo = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 10, CGRectGetMaxY(imageView.frame) + 8, CGRectGetWidth(messageView.frame)  - (CGRectGetMaxX(imageView.frame) + 10)*2, 50)];
        detailInfo.text = content;
        detailInfo.font = [UIFont systemFontOfSize:12];
        detailInfo.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0] ;
        detailInfo.editable = NO;
        
        [messageView addSubview:detailInfo];
    }else
    {
        messageView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width - 60, 210);
        messageView.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
        messageView.backgroundColor= [UIColor whiteColor];
        [messageView sizeToFit];
        [self addSubview:messageView];
        
        
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = title;
        titleLabel.frame = CGRectMake(24, 24, 300, 16);
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
        [messageView addSubview:titleLabel];
        
        
        UITextView * detailInfo = [[UITextView alloc]initWithFrame:CGRectMake(24, CGRectGetMaxY(titleLabel.frame) + 8, CGRectGetWidth(messageView.frame)  - 48 , 110)];
        detailInfo.text = content;
        detailInfo.font = [UIFont systemFontOfSize:12];
        detailInfo.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0] ;
        detailInfo.editable = NO;
        
        [messageView addSubview:detailInfo];
    }
    UIButton * confirmbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmbtn.frame = CGRectMake(CGRectGetWidth(messageView.frame) - 56 -14 , CGRectGetHeight(messageView.frame) - 32 -10, 56, 32);
    [confirmbtn setBackgroundColor: [UIColor colorWithRed:33/255.0 green:150/255.0 blue:243/255.0 alpha:1/1.0]];
    [confirmbtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmbtn.titleLabel setFont: [UIFont systemFontOfSize:12]];
    [confirmbtn addTarget:self action:@selector(dismissAlertView) forControlEvents:UIControlEventTouchUpInside];
    [messageView addSubview:confirmbtn];
   
}

-(void)showAlert
{
    [UIView animateWithDuration:0.5 animations:^{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }];
}

-(void)dismissAlertView
{
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

-(UILabel *)createLabelWithTitle:(NSString *)title
{
    UILabel * label = [[UILabel alloc]init];
    label.text = title;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
    return label;
}
@end
