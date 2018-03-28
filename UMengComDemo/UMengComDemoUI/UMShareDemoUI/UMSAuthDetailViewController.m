//
//  UMSAuthDetailViewController.m
//  UMSocialSDK
//
//  Created by wyq.Cloudayc on 11/10/16.
//  Copyright © 2016 UMeng. All rights reserved.
//

#import "UMSAuthDetailViewController.h"
#import <UShareUI/UMSocialUIUtility.h>

@implementation UMSAuthInfo

+ (instancetype)objectWithType:(UMSocialPlatformType)platform
{
    UMSAuthInfo *obj = [UMSAuthInfo new];
    obj.platform = platform;
    UMSocialUserInfoResponse *resp = nil;
    
    NSDictionary *authDic = [[UMSocialDataManager defaultManager ] getAuthorUserInfoWithPlatform:platform];
    if (authDic) {
        resp = [[UMSocialUserInfoResponse alloc] init];
        resp.uid = [authDic objectForKey:kUMSocialAuthUID];
        resp.unionId = [authDic objectForKey:kUMSocialAuthUID];
        resp.accessToken = [authDic objectForKey:kUMSocialAuthAccessToken];
        resp.expiration = [authDic objectForKey:kUMSocialAuthExpireDate];
        resp.refreshToken = [authDic objectForKey:kUMSocialAuthRefreshToken];
        resp.openid = [authDic objectForKey:kUMSocialAuthOpenID];
        
        if (platform == UMSocialPlatformType_QQ) {
            resp.uid = [authDic objectForKey:kUMSocialAuthOpenID];
        }
        if (platform == UMSocialPlatformType_QQ || platform == UMSocialPlatformType_WechatSession) {
            resp.usid = [authDic objectForKey:kUMSocialAuthOpenID];
        } else {
            resp.usid = [authDic objectForKey:kUMSocialAuthUID];
        }
        
        obj.response = resp;
    }
    return obj;
}

@end


@interface UMSAuthDetailViewController ()

@property (nonatomic, strong) UIButton *cleanButton;
@property (nonatomic, strong) UIButton *duplicateButton;
@property (nonatomic, strong) UIButton *fetchButton;

@property (nonatomic, strong) UITextView *textView;

@end

@implementation UMSAuthDetailViewController

+ (UMSAuthDetailViewController *)detailVCWithInfo:(UMSAuthInfo *)authInfo
{
    UMSAuthDetailViewController *VC = [[UMSAuthDetailViewController alloc] init];
    VC.authInfo = authInfo;
    return VC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *platformName = nil;
    NSString *iconName = nil;
    [UMSocialUIUtility configWithPlatformType:self.authInfo.platform withImageName:&iconName withPlatformName:&platformName];
    self.titleString = [NSString stringWithFormat:@"获取%@授权信息", platformName];
    
    self.textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    _textView.editable = NO;
    _textView.font = [UIFont systemFontOfSize:13.f];
    _textView.contentInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
    _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textView.layer.borderWidth = 1.f;
    [self.view addSubview:_textView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.cleanButton = [self buttonWithName:@"清空"];
    _cleanButton.userInteractionEnabled = YES;
    [_cleanButton addTarget:self action:@selector(cleanData) forControlEvents:UIControlEventTouchUpInside];
    
    self.duplicateButton = [self buttonWithName:@"复制"];
    _duplicateButton.userInteractionEnabled = YES;
    [_duplicateButton addTarget:self action:@selector(copyData) forControlEvents:UIControlEventTouchUpInside];

    self.fetchButton = [self buttonWithName:@"获取"];
    _fetchButton.backgroundColor = [UIColor colorWithRed:0.f/255.f green:134.f/255.f blue:220.f/255.f alpha:1.f];
    [_fetchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _fetchButton.userInteractionEnabled = YES;
    [_fetchButton addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_cleanButton];
//    [self.view addSubview:_duplicateButton];
    [self.view addSubview:_fetchButton];
    
    [self refreshLayout];
    
    _textView.text = [self authInfoString:self.authInfo.response];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [self refreshLayout];
}

- (void)refreshLayout
{
    CGFloat pad = 10.f;
    CGFloat padY = [self viewOffsetY] + pad;
    CGFloat buttonHeight = 32.f;
    CGFloat buttonWidth = 56.f;

    CGRect frame = self.view.bounds;
    frame.origin.x = pad;
    frame.size.width -= pad * 2;
    frame.origin.y = padY;
    frame.size.height = self.view.bounds.size.height - frame.origin.y - pad - buttonHeight * 5;
    _textView.frame = frame;
    _textView.scrollEnabled = YES;
    
    padY = _textView.frame.origin.y + _textView.frame.size.height + pad;
    
    frame.origin.y = padY;
    frame.size.width = buttonWidth;
    frame.size.height = buttonHeight;
    frame.origin.x = self.view.frame.size.width - frame.size.width - pad;
    _fetchButton.frame = frame;
    
    frame.origin.x = _fetchButton.frame.origin.x - _fetchButton.frame.size.width - pad;
    _cleanButton.frame = frame;
    
//    frame.origin.x = _fetchButton.frame.origin.x - _fetchButton.frame.size.width - pad;
//    _duplicateButton.frame = frame;
}


#pragma mark -
- (void)cleanData
{
#ifdef UM_Swift
    [UMShareSwiftInterface cancelAuthWithPlattype:self.authInfo.platform completion:^(id result, NSError * error) {
#else
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:self.authInfo.platform completion:^(id result, NSError *error) {
#endif
    }];
    self.authInfo.response = nil;
    self.textView.text = nil;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清除信息"
                                                    message:@"已清除"
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}


- (void)copyData
{
    NSString *content = nil;
    if (_textView.text.length == 0) {
        content = @"没有复制内容";
    } else {
        content = @"已复制到剪贴板";
        [UIPasteboard generalPasteboard].string = _textView.text;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"复制"
                                                    message:content
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}


- (void)fetchData
{
    __weak UMSAuthDetailViewController *ws = self;

    //6.1版本已经修正了getUserInfoWithPlatform，每次获得用户都需要跳转授权
    //如果不需要每次跳转，可以查看[UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo,来设置
    //[[UMSocialManager defaultManager] cancelAuthWithPlatform:self.authInfo.platform completion:^(id result, NSError *error) {
#ifdef UM_Swift
    [UMShareSwiftInterface getUserInfoWithPlattype:ws.authInfo.platform viewController:self completion:^(id result, NSError * error) {
#else
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:ws.authInfo.platform currentViewController:self completion:^(id result, NSError *error) {
#endif
            
            NSString *message = nil;
            
            if (error) {
                message = [NSString stringWithFormat:@"Get info fail:\n%@", error];
                UMSocialLogInfo(@"Get info fail with error %@",error);
            }else{
                if ([result isKindOfClass:[UMSocialUserInfoResponse class]]) {
                    
                    UMSocialUserInfoResponse *resp = result;
                    
                    ws.authInfo.response = resp;
                    
                    message = [ws authInfoString:resp];
                }else{
                    message = @"Get info fail";
                }
            }
            ws.textView.text = message;
        }];
    //}];
}

- (NSString *)authInfoString:(UMSocialUserInfoResponse *)resp
{
    NSMutableString *string = [NSMutableString new];
    if (resp.uid) {
        [string appendFormat:@"uid = %@\n", resp.uid];
    }
    if (resp.openid) {
        [string appendFormat:@"openid = %@\n", resp.openid];
    }
    if (resp.unionId) {
        [string appendFormat:@"unionId = %@\n", resp.unionId];
    }
    if (resp.usid) {
        [string appendFormat:@"usid = %@\n", resp.usid];
    }
    if (resp.accessToken) {
        [string appendFormat:@"accessToken = %@\n", resp.accessToken];
    }
    if (resp.refreshToken) {
        [string appendFormat:@"refreshToken = %@\n", resp.refreshToken];
    }
    if (resp.expiration) {
        [string appendFormat:@"expiration = %@\n", resp.expiration];
    }
    if (resp.name) {
        [string appendFormat:@"name = %@\n", resp.name];
    }
    if (resp.iconurl) {
        [string appendFormat:@"iconurl = %@\n", resp.iconurl];
    }
    if (resp.unionGender) {
        [string appendFormat:@"gender = %@\n", resp.unionGender];
    }
    return string;
}

- (UIButton *)buttonWithName:(NSString *)name
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.f, 0.f, 100.f, 28.f);
    button.layer.borderColor = [UIColor colorWithRed:0.f green:0.53f blue:0.8f alpha:1.f].CGColor;
    button.layer.borderWidth = 1.f;
    button.layer.cornerRadius = 3.f;
    
    [button setTitle:name forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.f green:0.53f blue:0.86f alpha:1.f] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.f];
    
    return button;
}

@end
