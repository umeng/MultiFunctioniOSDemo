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

//tableview的indexPath需要的枚举变量
typedef NS_ENUM(NSInteger, UMengComType)
{
    //indexPath.section = 0
    UMengComType_UApp = 0,
//    UMengComType_UDplus = 1,
    UMengComType_UGame = 1,
    
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
    [UMessage addCardMessageWithLabel:@"home"];
    
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRowsInSection = 0;
    switch (section) {
        case 0:
            numberOfRowsInSection = 2;
            break;
        case 1:
            numberOfRowsInSection = 2;
            break;
        case 2:
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
    else if (indexPath.section == 2){
        static NSString *umSection2ideitifier = @"umSection2ideitifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:umSection2ideitifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:umSection2ideitifier];
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
//            case UMengComType_UDplus:
//            {
//                [self.navigationController pushViewController:[[UMDplusViewController alloc] init] animated:YES];
//                
//            }
//            break;
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
    else if (indexPath.section == 2){
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

@end
