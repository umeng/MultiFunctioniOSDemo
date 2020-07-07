//
//  UMShareViewController.m
//  UMSocialSDK
//
//  Created by wyq.Cloudayc on 11/8/16.
//  Copyright © 2016 UMeng. All rights reserved.
//

#import "UMShareViewController.h"
#import <UShareUI/UShareUI.h>
#import "UMShareTypeViewController.h"

static NSString *UMS_SHARE_UI_CELL = @"UMS_SHARE_UI_CELL";
static NSString *UMS_UI_NAME = @"UMS_UI_NAME";
static NSString *UMS_UI_ICON = @"UMS_UI_ICON";
static NSString *UMS_UI_ICON_SIZE = @"UMS_UI_ICON_SIZE";
static NSString *UMS_UI_SELECTOR = @"UMS_UI_SELECTOR";

static NSString *UMS_UI_TBL_CELL = @"UMS_UI_TBL_CELL";


@interface UMShareViewController ()<UMSocialShareMenuViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIButton *bottomNormalButtonWithoutTitle;
@property (nonatomic, strong) UIButton *bottomNormalButtonWithoutCancel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *opArray;


@end

@implementation UMShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置用户自定义的平台
    
#ifdef UM_Swift
    [UMShareSwiftInterface setPreDefinePlatforms:@[
                                                    @(UMSocialPlatformType_WechatSession),
                                                    @(UMSocialPlatformType_WechatTimeLine),
                                                    @(UMSocialPlatformType_WechatFavorite),
                                                    @(UMSocialPlatformType_QQ),
                                                    @(UMSocialPlatformType_Qzone),
                                                    @(UMSocialPlatformType_Sina),
                                                    @(UMSocialPlatformType_TencentWb),
                                                    @(UMSocialPlatformType_AlipaySession),
                                                    @(UMSocialPlatformType_DingDing),
                                                    @(UMSocialPlatformType_Renren),
                                                    @(UMSocialPlatformType_Douban),
                                                    @(UMSocialPlatformType_Sms),
                                                    @(UMSocialPlatformType_Email),
                                                    @(UMSocialPlatformType_Facebook),
                                                    @(UMSocialPlatformType_FaceBookMessenger),
                                                    @(UMSocialPlatformType_Twitter),
                                                    @(UMSocialPlatformType_LaiWangSession),
                                                    @(UMSocialPlatformType_LaiWangTimeLine),
                                                    @(UMSocialPlatformType_YixinSession),
                                                    @(UMSocialPlatformType_YixinTimeLine),
                                                    @(UMSocialPlatformType_YixinFavorite),
                                                    @(UMSocialPlatformType_Instagram),
                                                    @(UMSocialPlatformType_Line),
                                                    @(UMSocialPlatformType_Whatsapp),
                                                    @(UMSocialPlatformType_Linkedin),
                                                    @(UMSocialPlatformType_Flickr),
                                                    @(UMSocialPlatformType_KakaoTalk),
                                                    @(UMSocialPlatformType_Pinterest),
                                                    @(UMSocialPlatformType_Tumblr),
                                                    @(UMSocialPlatformType_YouDaoNote),
                                                    @(UMSocialPlatformType_EverNote),
                                                    @(UMSocialPlatformType_GooglePlus),
                                                    @(UMSocialPlatformType_Pocket),
                                                    @(UMSocialPlatformType_DropBox),
                                                    @(UMSocialPlatformType_VKontakte),
                                                    @(UMSocialPlatformType_UserDefine_Begin+1),
                                                    ]];
#else
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
                                               @(UMSocialPlatformType_WechatTimeLine),
                                               @(UMSocialPlatformType_WechatFavorite),
                                               @(UMSocialPlatformType_QQ),
                                               @(UMSocialPlatformType_Qzone),
                                               @(UMSocialPlatformType_Tim),
                                               @(UMSocialPlatformType_Sina),
                                               @(UMSocialPlatformType_TencentWb),
                                               @(UMSocialPlatformType_APSession),
                                               @(UMSocialPlatformType_DingDing),
                                               @(UMSocialPlatformType_Renren),
                                               @(UMSocialPlatformType_Douban),
                                               @(UMSocialPlatformType_Sms),
                                               @(UMSocialPlatformType_Email),
                                               @(UMSocialPlatformType_Facebook),
                                               @(UMSocialPlatformType_FaceBookMessenger),
                                               @(UMSocialPlatformType_Twitter),
                                               @(UMSocialPlatformType_LaiWangSession),
                                               @(UMSocialPlatformType_LaiWangTimeLine),
                                               @(UMSocialPlatformType_YixinSession),
                                               @(UMSocialPlatformType_YixinTimeLine),
                                               @(UMSocialPlatformType_YixinFavorite),
                                               @(UMSocialPlatformType_Instagram),
                                               @(UMSocialPlatformType_Line),
                                               @(UMSocialPlatformType_Whatsapp),
                                               @(UMSocialPlatformType_Linkedin),
                                               @(UMSocialPlatformType_Flickr),
                                               @(UMSocialPlatformType_KakaoTalk),
                                               @(UMSocialPlatformType_Pinterest),
                                               @(UMSocialPlatformType_Tumblr),
                                               @(UMSocialPlatformType_YouDaoNote),
                                               @(UMSocialPlatformType_EverNote),
                                               @(UMSocialPlatformType_GooglePlus),
                                               @(UMSocialPlatformType_Pocket),
                                               @(UMSocialPlatformType_DropBox),
                                               @(UMSocialPlatformType_VKontakte),
                                               @(UMSocialPlatformType_UserDefine_Begin+1),
                                               ]];
#endif
    //设置分享面板的显示和隐藏的代理回调
    [UMSocialUIManager setShareMenuViewDelegate:self];
    
    self.titleString = @"分享菜单模板";
    
    if (!_opArray) {
        self.opArray = @[@{UMS_UI_NAME: @"页面底部菜单-1",
                           UMS_UI_ICON: [UIImage imageNamed:@"menu_bottom"],
                           UMS_UI_ICON_SIZE: NSStringFromCGSize(CGSizeMake(25.f, 25.f)),
                           UMS_UI_SELECTOR: NSStringFromSelector(@selector(showBottomNormalView))},
                         @{UMS_UI_NAME: @"页面中部菜单-1",
                           UMS_UI_ICON: [UIImage imageNamed:@"menu_middle"],
                           UMS_UI_ICON_SIZE: NSStringFromCGSize(CGSizeMake(25.f, 24.f)),
                           UMS_UI_SELECTOR: NSStringFromSelector(@selector(showMiddleNormalView))},
                         @{UMS_UI_NAME: @"页面底部菜单-2",
                           UMS_UI_ICON: [UIImage imageNamed:@"menu_bottom"],
                           UMS_UI_ICON_SIZE: NSStringFromCGSize(CGSizeMake(25.f, 24.f)),
                           UMS_UI_SELECTOR: NSStringFromSelector(@selector(showBottomCircleView))},
                         @{UMS_UI_NAME: @"页面中部菜单-2",
                           UMS_UI_ICON: [UIImage imageNamed:@"menu_middle"],
                           UMS_UI_ICON_SIZE: NSStringFromCGSize(CGSizeMake(25.f, 24.f)),
                           UMS_UI_SELECTOR: NSStringFromSelector(@selector(showMiddleCircleView))}];
    }
    
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UMS_UI_TBL_CELL];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.tableHeaderView = nil;
        self.tableView.tableFooterView = nil;
        self.tableView.sectionFooterHeight = 0.f;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 0.f, 15.f)];
        [self.view addSubview:_tableView];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showBottomNormalView
{
    //加入copy的操作
    //@see http://dev.umeng.com/social/ios/进阶文档#6
    [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_UserDefine_Begin+2
                                     withPlatformIcon:[UIImage imageNamed:@"icon_circle"]
                                     withPlatformName:@"演示icon"];
    
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
#ifdef UM_Swift
    [UMShareSwiftInterface showShareMenuViewInWindowWithPlatformSelectionBlockWithSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary* userInfo) {
#else
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
#endif
        //在回调里面获得点击的
        if (platformType == UMSocialPlatformType_UserDefine_Begin+2) {
            NSLog(@"点击演示添加Icon后该做的操作");
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"添加自定义icon"
                                                                message:@"具体操作方法请参考UShareUI内接口文档"
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                      otherButtonTitles:nil];
                [alert show];
                
            });
        }
        else{
            [self runShareWithType:platformType];
        }
    }];
}

- (void)showBottomCircleView
{
    [UMSocialUIManager removeAllCustomPlatformWithoutFilted];
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
#ifdef UM_Swift
    [UMShareSwiftInterface showShareMenuViewInWindowWithPlatformSelectionBlockWithSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary* userInfo) {
#else
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
#endif
        
        [self runShareWithType:platformType];
    }];
}

- (void)showMiddleNormalView
{
    [UMSocialUIManager removeAllCustomPlatformWithoutFilted];
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Middle;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
#ifdef UM_Swift
    [UMShareSwiftInterface showShareMenuViewInWindowWithPlatformSelectionBlockWithSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary* userInfo) {
#else
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
#endif
        
        [self runShareWithType:platformType];
    }];
}

- (void)showMiddleCircleView
{
    [UMSocialUIManager removeAllCustomPlatformWithoutFilted];
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Middle;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
#ifdef UM_Swift
    [UMShareSwiftInterface showShareMenuViewInWindowWithPlatformSelectionBlockWithSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary* userInfo) {
#else
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
#endif
        
        [self runShareWithType:platformType];
    }];
}

- (void)runShareWithType:(UMSocialPlatformType)type
{
    UMShareTypeViewController *VC = [[UMShareTypeViewController alloc] initWithType:type];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _opArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:UMS_UI_TBL_CELL];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor colorWithRed:0.34 green:.35 blue:.3 alpha:1];
    
    UIImage *accessImage = nil;
    
    NSDictionary *dict = nil;
    dict = self.opArray[indexPath.row];
    
    accessImage = [self resizeImage:[UIImage imageNamed:@"access"]
                               size:CGSizeMake(8.f, 14.f)];
    
    if (dict) {
        cell.textLabel.text = dict[UMS_UI_NAME];
        cell.imageView.image = [self resizeImage:dict[UMS_UI_ICON]
                                            size:CGSizeFromString(dict[UMS_UI_ICON_SIZE])] ;
    }
    
    if (accessImage) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:accessImage];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = nil;
    if (indexPath.section == 0) {
        dict = self.opArray[indexPath.row];
    }
    if (dict) {
        [self performSelector:NSSelectorFromString(dict[UMS_UI_SELECTOR])];
    }
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

- (UIImage *)blankImage
{
    CGSize size = CGSizeMake(25.f, 25.f);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [[UIColor whiteColor] setFill];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - UMSocialShareMenuViewDelegate
- (void)UMSocialShareMenuViewDidAppear
{
    NSLog(@"UMSocialShareMenuViewDidAppear");
}
- (void)UMSocialShareMenuViewDidDisappear
{
    NSLog(@"UMSocialShareMenuViewDidDisappear");
}

//不需要改变父窗口则不需要重写此协议
- (UIView*)UMSocialParentView:(UIView*)defaultSuperView
{
    return defaultSuperView;
}

@end
