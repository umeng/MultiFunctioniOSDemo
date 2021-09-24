//
//  UMMainViewController.m
//  UMengComDemo
//
//  Created by 张军华 on 2018/1/22.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import "UMMainViewController.h"

#import "UMengComDemoUIHeaders.h"
#import "UMSRootViewController.h"
#import <UMPush/UMessage.h>
#import <UMCommon/UMConfigure.h>
#import <UMCommonLog/UMCommonLogManager.h>
//tableview的indexPath需要的枚举变量
typedef NS_ENUM(NSInteger, UMengComType)
{
    //indexPath.section = 0
    UMengComType_UApp = 0,
//    UMengComType_UDplus = 1,
    UMengComType_UGame = 1,
    
    UMengComType_APM = 0,
    
    //indexPath.section = 1
    UMengComType_UPush = 0,
    UMengComType_UShare = 1,
    
    //indexPath.section = 2
    UMengComType_UpdateLog = 0,
};

@interface UMMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,readwrite,strong)UITableView* mainTableView;

@end

@implementation UMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置title
    self.title = @"【Umeng+】产品Demo";
    
    //创建UITableView
    self.mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.mainTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([[defaults objectForKey:@"showStatus"] isEqualToString:@"1"]){
        [UMessage addCardMessageWithLabel:@"home"];
    }else{
        //隐私协议判断
        [self privacyAgreement];
    }
    
//    //添加约束
//    self.mainTableView.translatesAutoresizingMaskIntoConstraints = NO;
//    //创建宽度约束
//    NSLayoutConstraint * constraintw =  [NSLayoutConstraint constraintWithItem:self.mainTableView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
//    //创建高度约束
//    NSLayoutConstraint * constrainth = [NSLayoutConstraint constraintWithItem:self.mainTableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
//    
//    [self.view addConstraints:@[constrainth,constraintw]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRowsInSection = 0;
    switch (section) {
        case 0:
            numberOfRowsInSection = 2;
            break;
        case 1:
            numberOfRowsInSection = 1;
            break;
        case 2:
            numberOfRowsInSection = 2;
            break;
        case 3:
            numberOfRowsInSection = 1;
            break;
        default:
            break;
    }
    return numberOfRowsInSection;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *umSection0ideitifier = @"umSection0ideitifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:umSection0ideitifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:umSection0ideitifier];
        }
        
        switch (indexPath.row) {
            case UMengComType_UApp:
            {
                cell.textLabel.text = @"统计UApp";
                cell.imageView.image = [UIImage imageNamed:@"uapp"];
            }
                break;
//            case UMengComType_UDplus:
//                cell.textLabel.text = @"统计Dplus";
//                cell.imageView.image = [UIImage imageNamed:@"dplus"];
//                break;
            case UMengComType_UGame:
                cell.textLabel.text = @"统计UGame";
                cell.imageView.image = [UIImage imageNamed:@"ugame"];
                break;
            default:
                cell.textLabel.text = @"unknown";
                break;
        }
        
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
        
    }
    
    else if (indexPath.section == 1){
        
        static NSString *umSection1ideitifier = @"umSection1ideitifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:umSection1ideitifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:umSection1ideitifier];
        }
        
        switch (indexPath.row) {
            case UMengComType_APM:
                cell.textLabel.text = @"APM";
                cell.imageView.image = [UIImage imageNamed:@"APM"];
                break;
            
            default:
                cell.textLabel.text = @"unknown";
                break;
        }
        
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
    else if (indexPath.section == 2){
        
        static NSString *umSection2ideitifier = @"umSection2ideitifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:umSection2ideitifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:umSection2ideitifier];
        }
        
        switch (indexPath.row) {
            case UMengComType_UPush:
                cell.textLabel.text = @"推送";
                cell.imageView.image = [UIImage imageNamed:@"upush"];
                break;
            case UMengComType_UShare:
                cell.textLabel.text = @"分享";
                cell.imageView.image = [UIImage imageNamed:@"ushare"];
                break;
            default:
                cell.textLabel.text = @"unknown";
                break;
        }
        
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else if (indexPath.section == 3){
        static NSString *umSection3ideitifier = @"umSection3ideitifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:umSection3ideitifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:umSection3ideitifier];
        }
        
        switch (indexPath.row) {
            case UMengComType_UpdateLog:
                cell.textLabel.text = @"更新日志";
                cell.imageView.image = [UIImage imageNamed:@"log"];
                break;
                break;
            default:
                cell.textLabel.text = @"unknown";
                break;
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else{
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case UMengComType_UApp:
            {
                [self.navigationController pushViewController:[[UMAnalyticsViewController alloc] init] animated:YES];
                
            }
            break;

            case UMengComType_UGame:
            {
                [self.navigationController pushViewController:[[UMGameViewController alloc] init] animated:YES];
                
            }
            break;
            default:
            break;
        }
    }
    else if (indexPath.section == 1){
        switch (indexPath.row) {
            case UMengComType_APM:
            {
                [self.navigationController pushViewController:[[UMAPMViewController alloc] init] animated:YES];
            }
                break;
            default:
                break;
        }
    }
    else if (indexPath.section == 2){
        switch (indexPath.row) {
            case UMengComType_UPush:
            {
                [self.navigationController pushViewController:[[UMPushViewController alloc] init] animated:YES];
            }
                break;
            case UMengComType_UShare:
            {
                [self.navigationController pushViewController:[[UMSRootViewController alloc] init] animated:YES];
            }
                break;
            default:
                break;
        }
    }
    else if (indexPath.section == 3){
        switch (indexPath.row) {
            case UMengComType_UpdateLog:
            {
                [self.navigationController pushViewController:[[UMUpdateLogViewController alloc] init] animated:YES];
            }
                break;
            default:
                break;
        }
    }
    else{
    }
}

-(void)privacyAgreement
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         if(![[defaults objectForKey:@"showStatus"] isEqualToString:@"1"]){
             NSString *str=@"个人信息保护指引：为了让您更好地使用友盟产品，请充分阅读并理解《隐私政策》\n 我们会遵循隐私政策收集、使用信息，但不会因同意了隐私政策而进行强制捆绑式的信息收集。\n 如果您同意，请点击下面的按钮以接受我们的服务。";

                UIAlertController *_alertVC = [UIAlertController alertControllerWithTitle:@"隐私协议" message:@"" preferredStyle:UIAlertControllerStyleAlert];
             _alertVC.view.userInteractionEnabled=YES;
             ///设置左对齐
             UILabel *label2 = [_alertVC.view valueForKeyPath:@"_messageLabel"];
             label2.userInteractionEnabled=YES;
             NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
             NSURL *url=[NSURL URLWithString:@"https://www.umeng.com/page/policy"];
                     [attributedString addAttribute:NSLinkAttributeName
                                              value:url
                                              range:[[attributedString string] rangeOfString:@"《隐私政策》"]];
                     [attributedString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} range:[str rangeOfString:@"《隐私政策》"]];


             label2.attributedText=attributedString;
             label2.textAlignment = NSTextAlignmentLeft;
             
             UIAlertAction *_alertAction = [UIAlertAction actionWithTitle:@"查看完整《隐私政策》" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
             {
     

                 [self presentViewController:_alertVC animated:YES completion:nil];
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.umeng.com/page/policy"]];

                 return;
   
             }];



             [_alertVC addAction:_alertAction];
             
             
                            UIAlertAction *_doAction = [UIAlertAction actionWithTitle:@"同意并继续" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                            {
                                //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                [defaults setValue:@"1" forKey:@"showStatus"];
                                [defaults synchronize];
                           //   NSLog(@"点击确定按钮后，想要的操作，可以加此处");
                                //友盟初始化
                                [UMCommonLogManager setUpUMCommonLogManager];
                                [UMConfigure setLogEnabled:YES];
                                [UMConfigure initWithAppkey:@"59892ebcaed179694b000104" channel:@"App Store"];
                                
                                // Push's basic setting
                                UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
                                //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
                                entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert;
                                [UNUserNotificationCenter currentNotificationCenter].delegate=self;
                                [UMessage registerForRemoteNotificationsWithLaunchOptions:nil Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                    if (granted) {
                                    }else
                                    {
                                    }
                                }];

                                [self setupUSharePlatforms];   // required: setting platforms on demand
                        //        [self setupUShareSettings];
                                [UMessage openDebugMode:YES];
                                [UMessage setWebViewClassString:@"UMWebViewController"];
                                [UMessage addLaunchMessage];
                                [UMessage addCardMessageWithLabel:@"home"];

                                [self alertView:@"友盟+初始化成功"];

                            }];
             
             
             
                            [_alertVC addAction:_doAction];
                            UIAlertAction *_cancleAction = [UIAlertAction actionWithTitle:@"不同意" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                            {
                                [self alertView:@"友盟+初始化失败"];

//                                [self.navigationController popViewControllerAnimated:YES];
//                              NSLog(@"点击取消按钮后，想要的操作");
                            }];
                            [_alertVC addAction:_cancleAction];
                            [self presentViewController:_alertVC animated:YES completion:nil];
         }else{
             
             
         }
}

-(void)alertView:(NSString *)message{
    UIAlertController *_alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *_doAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                {
        

                }];
                [_alertVC addAction:_doAction];
                [self presentViewController:_alertVC animated:YES completion:nil];

}

- (void)setupUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];

    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];

    /*
     设置新浪的appKey和appSecret
     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];

    /* 钉钉的appKey */
    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DingDing appKey:@"dingoalmlnohc0wggfedpk" appSecret:nil redirectURL:nil];

    /* 支付宝的appKey */
    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_APSession appKey:@"2015111700822536" appSecret:nil redirectURL:nil];

    /* 设置易信的appKey */
    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_YixinSession appKey:@"yx35664bdff4db42c2b7be1e29390c1a06" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];

    /* 设置领英的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Linkedin appKey:@"81lcv9le14dpqi"  appSecret:@"Po7OB9LxOaxhR9M3" redirectURL:@"https://api.linkedin.com/v1/people"];

    /* 设置Twitter的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Twitter appKey:@"fB5tvRpna1CKK97xZUslbxiet"  appSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K" redirectURL:nil];

    /* 设置Facebook的appKey和UrlString */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook appKey:@"506027402887373"  appSecret:nil redirectURL:nil];

    /* 设置Pinterest的appKey */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Pinterest appKey:@"4864546872699668063"  appSecret:nil redirectURL:nil];

    /* dropbox的appKey */
    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DropBox appKey:@"k4pn9gdwygpy4av" appSecret:@"td28zkbyb9p49xu" redirectURL:@"https://mobile.umeng.com/social"];

    /* vk的appkey */
    [[UMSocialManager defaultManager]  setPlaform:UMSocialPlatformType_VKontakte appKey:@"5786123" appSecret:nil redirectURL:nil];

}


@end
