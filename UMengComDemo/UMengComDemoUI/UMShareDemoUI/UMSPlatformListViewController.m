//
//  UMSAuthViewController.m
//  UMSocialSDK
//
//  Created by wyq.Cloudayc on 11/8/16.
//  Copyright © 2016 UMeng. All rights reserved.
//

#import "UMSPlatformListViewController.h"
#import <UMShare/UMShare.h>
#import "UMSAuthDetailViewController.h"
#import <UShareUI/UMSocialUIUtility.h>
#import "UMShareTypeViewController.h"


static NSString *UMS_NAV_TBL_CELL = @"UMS_NAV_TBL_CELL";

@interface UMSAuthCell : UITableViewCell


@property (nonatomic, assign) UMSAuthViewType authType;

@property (nonatomic, strong) UMSAuthInfo *info;
@property (nonatomic, strong) UIButton *authButton;
@property (nonatomic, strong) void (^authOpFinish)();
@property (nonatomic, strong) void (^share)(UMSocialPlatformType type);

@end

@implementation UMSAuthCell

- (instancetype)initWithType:(UMSAuthViewType)type
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UMS_NAV_TBL_CELL]) {
        self.authType = type;
        if (_authType == UMSAuthViewTypeAuth) {
            [self addAuthButton];
        }
    }
    return self;
}

- (void)addAuthButton
{
    if (!_authButton) {
        self.authButton = [self getButton];
        [self.contentView addSubview:_authButton];
    }
}

- (void)reloadInfo
{
    if (_info.response) {
        self.authButton.selected = YES;
    } else {
        self.authButton.selected = NO;
    }
}

- (UIButton *)getButton
{
    UIButton *tipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tipButton.userInteractionEnabled = YES;
    tipButton.frame = CGRectMake(110.f, 10.f, 100.f, 28.f);
    tipButton.layer.borderColor = [UIColor colorWithRed:0.f green:0.53f blue:0.8f alpha:1.f].CGColor;
    tipButton.layer.borderWidth = 1.f;
    tipButton.layer.cornerRadius = 3.f;
    
    [tipButton setTitle:@"授权" forState:UIControlStateNormal];
    [tipButton setTitle:@"清除授权" forState:UIControlStateSelected];
    
    [tipButton setTitleColor:[UIColor colorWithRed:0.f green:0.53f blue:0.86f alpha:1.f] forState:UIControlStateNormal];
    tipButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    
    [tipButton addTarget:self action:@selector(onAuthEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    return tipButton;
}

- (void)onAuthEvent:(id)sender
{
    __weak UMSAuthCell *ws = self;
    if (self.info.response) {
        [[UMSocialManager defaultManager] cancelAuthWithPlatform:ws.info.platform completion:^(id result, NSError *error) {
            ws.info.response = nil;
            ws.authOpFinish();
            [ws reloadInfo];
        }];
    } else {
        [[UMSocialManager defaultManager] cancelAuthWithPlatform:self.info.platform completion:^(id result, NSError *error) {
            [ws authForPlatform:self.info];
        }];
    }
}

- (void)authForPlatform:(UMSAuthInfo *)authInfo
{
    __weak UMSAuthCell *ws = self;
#ifdef UM_Swift
    [UMShareSwiftInterface authWithPlattype:authInfo.platform viewController:nil completion:^(id result, NSError * error) {
#else
    [[UMSocialManager defaultManager] authWithPlatform:authInfo.platform currentViewController:nil completion:^(id result, NSError *error) {
#endif
        NSString *message = nil;
        
        if (error) {
            message = @"获取用户信息失败";
            UMSocialLogInfo(@"获取用户信息失败 %@",error);
        } else {
            
            if ([result isKindOfClass:[UMSocialAuthResponse class]]) {
                UMSocialAuthResponse * resp = result;
                
                UMSocialUserInfoResponse *userInfoResp = [[UMSocialUserInfoResponse alloc] init];
                userInfoResp.uid = resp.uid;
                userInfoResp.unionId = resp.unionId;
                userInfoResp.usid = resp.usid;
                userInfoResp.openid = resp.openid;
                userInfoResp.accessToken = resp.accessToken;
                userInfoResp.refreshToken = resp.refreshToken;
                userInfoResp.expiration = resp.expiration;
                
                authInfo.response = userInfoResp;
                
                ws.authOpFinish();
                [ws reloadInfo];
            }else{
                message = @"获取用户信息失败";
                UMSocialLogInfo(@"获取用户信息失败");
            }
        }
        if (message) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Auth info"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
}

@end



@interface UMSPlatformListViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *opArray;

@property (nonatomic, assign) UMSAuthViewType authType;

@property (nonatomic, assign) NSInteger authButtonX;

@end

@implementation UMSPlatformListViewController

- (instancetype)initWithViewType:(UMSAuthViewType)type
{
    if (self = [super init]) {
        self.authType = type;
        _authButtonX = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_authType == UMSAuthViewTypeAuth) {
        self.titleString = @"授权";
    } else if (_authType == UMSAuthViewTypeUserInfo) {
        self.titleString = @"获取用户信息";
    } else {
        self.titleString = @"分享";
    }

    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 0.f, 15.f)];

        [self.view addSubview:_tableView];
    }
    _tableView.allowsSelection = (_authType == UMSAuthViewTypeAuth) ? NO:YES;
    
    if (_authType == UMSAuthViewTypeAuth) {
        self.opArray = @[[UMSAuthInfo objectWithType:UMSocialPlatformType_WechatSession],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Sina],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_QQ],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Tim],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_TencentWb],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Renren],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Douban],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Facebook],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Twitter],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Linkedin],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_KakaoTalk],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_DropBox],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_VKontakte],
                         ];
    } else if (_authType == UMSAuthViewTypeUserInfo) {
        self.opArray = @[[UMSAuthInfo objectWithType:UMSocialPlatformType_WechatSession],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Sina],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_QQ],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Tim],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Facebook],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Twitter],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Linkedin],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_KakaoTalk],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_DropBox],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_VKontakte],
                         ];
    } else {
        
        self.opArray = @[[UMSAuthInfo objectWithType:UMSocialPlatformType_WechatSession],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_WechatTimeLine],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_WechatFavorite],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_QQ],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Qzone],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Tim],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Sina],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_TencentWb],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_AlipaySession],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_DingDing],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Renren],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Douban],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Sms],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Email],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_YouDaoNote],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_EverNote],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Facebook],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_FaceBookMessenger],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Twitter],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_LaiWangSession],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_LaiWangTimeLine],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_YixinSession],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_YixinTimeLine],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_YixinFavorite],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Instagram],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Line],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Whatsapp],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Linkedin],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Flickr],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_KakaoTalk],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Pinterest],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Pocket],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_Tumblr],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_GooglePlus],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_DropBox],
                         [UMSAuthInfo objectWithType:UMSocialPlatformType_VKontakte],
                         ];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.authButtonX = 0;
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillLayoutSubviews {
    self.tableView.frame = self.view.bounds;
    __weak UMSPlatformListViewController *ws = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ws.authButtonX = 0;
        [ws.tableView reloadData];
    });
}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.opArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UMSAuthCell *cell = [self.tableView dequeueReusableCellWithIdentifier:UMS_NAV_TBL_CELL];
    cell.textLabel.textColor = [UIColor colorWithRed:0.34 green:.35 blue:.3 alpha:1];

    if (!cell) {
        cell = [[UMSAuthCell alloc] initWithType:_authType];
    }
    
    cell.authOpFinish = ^{
        [tableView reloadData];
    };

    CGRect frame = cell.authButton.frame;
    NSInteger x = cell.textLabel.frame.origin.x + cell.textLabel.frame.size.width - frame.size.width - 20.f;
    if (x > _authButtonX) { _authButtonX = x; }
    if (_authButtonX > 0) { frame.origin.x = _authButtonX; }
    cell.authButton.frame = frame;


    UMSAuthInfo *obj = [_opArray objectAtIndex:indexPath.row];
    cell.info = obj;
    [cell reloadInfo];
    
    NSString *platformName = nil;
    NSString *iconName = nil;
    [UMSocialUIUtility configWithPlatformType:obj.platform withImageName:&iconName withPlatformName:&platformName];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", platformName];
    cell.imageView.image = [UMSocialUIUtility imageNamed:iconName];
    
    if (_authType != UMSAuthViewTypeAuth) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[self resizeImage:[UIImage imageNamed:@"access"]
                                                                             size:CGSizeMake(8.f, 14.f)]];
        
    }
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UMSAuthInfo *obj = self.opArray[indexPath.row];
    if (_authType == UMSAuthViewTypeShare) {
        UMShareTypeViewController *VC = [[UMShareTypeViewController alloc] initWithType:obj.platform];
        [self.navigationController pushViewController:VC animated:YES];
        return;
    }
    
    [self.navigationController pushViewController:[UMSAuthDetailViewController detailVCWithInfo:obj] animated:YES];
}

#pragma mark -

- (UIImage *)resizeImage:(UIImage *)image size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, size.width, size.height);
    [image drawInRect:imageRect];
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return retImage;
}

@end
