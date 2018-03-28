//
//  UMGameViewController.m
//  UMengComDemo
//
//  Created by wangkai on 2018/1/25.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import "UMGameViewController.h"
#import <UMAnalytics/MobClickGameAnalytics.h>
#import "UMAlertView.h"
//tableview的indexPath需要的枚举变量
typedef NS_ENUM(NSInteger, UMengComType)
{
    //indexPath.section = 0
    UMpuid_title=0,
    UMpuid_SignIn = 1,
    UMpuid_SignOff = 2,
    
    //indexPath.section = 1
    UMlevel_title=0,
    UMlevel = 1,
  
    
    //indexPath.section = 2
    UMlevel_title1 = 0,
    UMlevel_startLevel = 1,
    UMlevel_finishLevel = 2,
    UMlevel_failLevel = 3,
    
    //indexPath.section = 3
    UMpay_title = 0,
    UMpay_exchange = 1,
    UMpay_cash = 2,
    UMpay_item = 3,
    //indexPath.section = 4
    UMbuy_title=0,
    UMbuy = 1,
    //indexPath.section = 5
    UMuse_title=0,
    UMuse = 1,
    //indexPath.section = 6
    UMbonus_title=0,
    UMbonus = 1,
    UMbonus_item = 2,
};


@interface UMGameViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,readwrite,strong)UITableView* aTableView;

@end
@implementation UMGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置title
    self.title = @"统计UGame";
    
    //创建UITableView
    self.aTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.aTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.aTableView.delegate = self;
    self.aTableView.dataSource = self;
    [self.view addSubview:self.aTableView];
    
    
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
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRowsInSection = 0;
    switch (section) {
        case 0:
        numberOfRowsInSection = 3;
        break;
        case 1:
        numberOfRowsInSection = 2;
        break;
        case 2:
        numberOfRowsInSection = 4;
        break;
        case 3:
        numberOfRowsInSection = 4;
        break;
        case 4:
        numberOfRowsInSection = 2;
        break;
        case 5:
        numberOfRowsInSection = 2;
        break;
        case 6:
        numberOfRowsInSection = 3;
        break;
        default:
        break;
    }
    return numberOfRowsInSection;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *NOTIFY = @"cell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:NOTIFY];
        NSString *CellIdentifier = [NSString stringWithFormat:@"umSection0ideitifier"];//以indexPath来唯一确定cell
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            
        }
        tableView.rowHeight = 60.0f;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        switch (indexPath.row) {
            case UMpuid_title:
            cell.textLabel.text=@"账号统计";
            cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            tableView.rowHeight = 50.0f;
            
            
            break;
            case UMpuid_SignIn:
            cell.textLabel.text = @"profileSignInWithPUID";
            cell.detailTextLabel.text = @"puid:登陆账号";
            break;
            case UMpuid_SignOff:
            cell.textLabel.text = @"profileSignOff";
            cell.detailTextLabel.text = @"退出登陆";
            
            break;
            
            default:
            cell.textLabel.text = @"unknown";
            cell.detailTextLabel.text = @"unknown";
            
            break;
        }
        
        
        return cell;
        
        
    }
    else if (indexPath.section == 1){
        
        static NSString *NOTIFY = @"cell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:NOTIFY];
        NSString *CellIdentifier = [NSString stringWithFormat:@"umSection1ideitifier"];//以indexPath来唯一确定cell
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            
        }
        tableView.rowHeight = 60.0f;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        switch (indexPath.row) {
            case UMlevel_title:
            cell.textLabel.text=@"玩家等级";
            cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            tableView.rowHeight = 50.0f;
            
            
            break;
            case UMlevel:
            cell.textLabel.text = @"setUserLevelId";
            cell.detailTextLabel.text = @"level:玩家等级";
            break;
  
            
            default:
            cell.textLabel.text = @"unknown";
            cell.detailTextLabel.text = @"unknown";
            
            break;
        }
        
        
        return cell;
    }
    else if (indexPath.section == 2){
            static NSString *NOTIFY = @"cell";
            UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:NOTIFY];
            NSString *CellIdentifier = [NSString stringWithFormat:@"umSection2ideitifier"];//以indexPath来唯一确定cell
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                
            }
            tableView.rowHeight = 60.0f;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            switch (indexPath.row) {
                case UMlevel_title1:
                cell.textLabel.text=@"关卡统计";
                cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell setSeparatorInset:UIEdgeInsetsZero];
                tableView.rowHeight = 50.0f;
                
                
                break;
                case UMlevel_startLevel:
                cell.textLabel.text = @"startLevel";
                cell.detailTextLabel.text = @"level:关卡";
                break;
                case UMlevel_finishLevel:
                cell.textLabel.text = @"finishLevel";
                cell.detailTextLabel.text = @"level:关卡";
                
                break;
                case UMlevel_failLevel:
                cell.textLabel.text = @"failLevel";
                cell.detailTextLabel.text = @"level:关卡";
                
                break;
                
                default:
                cell.textLabel.text = @"unknown";
                cell.detailTextLabel.text = @"unknown";
                
                break;
            }
            
            
            return cell;
    }
    else if (indexPath.section == 3){
        static NSString *NOTIFY = @"cell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:NOTIFY];
        NSString *CellIdentifier = [NSString stringWithFormat:@"umSection2ideitifier"];//以indexPath来唯一确定cell
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            
        }
        tableView.rowHeight = 60.0f;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        switch (indexPath.row) {
            case UMpay_title:
            cell.textLabel.text=@"支付统计";
            cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            tableView.rowHeight = 50.0f;
            
            
            break;
            case UMpay_exchange:
            cell.textLabel.text = @"exchange";
            cell.detailTextLabel.text = @"orderId:交易订单ID currencyAmount:现金或等价物总额 currencyType:为ISO4217定义的3位字母代码，如CNY,USD等 virtualAmount:虚拟币数量 channel:支付渠道";
            break;
            case UMpay_cash:
            cell.textLabel.text = @"pay";
            cell.detailTextLabel.text = @"cash:真实货币数量 source:支付渠道 coin:虚拟币数量";
            
            break;
            case UMpay_item:
            cell.textLabel.text = @"pay_item";
            cell.detailTextLabel.text = @"cash:真实货币数量 source:支付渠道 item:道具名称 amount:道具数量 price:道具单价";
            
            break;
            
            default:
            cell.textLabel.text = @"unknown";
            cell.detailTextLabel.text = @"unknown";
            
            break;
        }
        
        
        return cell;
    }
    else if (indexPath.section == 4){
        
        static NSString *NOTIFY = @"cell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:NOTIFY];
        NSString *CellIdentifier = [NSString stringWithFormat:@"umSection4ideitifier"];//以indexPath来唯一确定cell
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            
        }
        tableView.rowHeight = 60.0f;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        switch (indexPath.row) {
            case UMbuy_title:
            cell.textLabel.text=@"购买统计";
            cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            tableView.rowHeight = 50.0f;
            
            
            break;
            case UMbuy:
            cell.textLabel.text = @"buy";
            cell.detailTextLabel.text = @"item:道具名称 amount:道具数量 price:道具单价";
            break;
            
            
            default:
            cell.textLabel.text = @"unknown";
            cell.detailTextLabel.text = @"unknown";
            
            break;
        }
        
        
        return cell;
    }
    else if (indexPath.section == 5){
        
        static NSString *NOTIFY = @"cell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:NOTIFY];
        NSString *CellIdentifier = [NSString stringWithFormat:@"umSection4ideitifier"];//以indexPath来唯一确定cell
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            
        }
        tableView.rowHeight = 60.0f;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        switch (indexPath.row) {
            case UMuse_title:
            cell.textLabel.text=@"道具消耗统计";
            cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            tableView.rowHeight = 50.0f;
            
            
            break;
            case UMuse:
            cell.textLabel.text = @"use";
            cell.detailTextLabel.text = @"item:道具名称 amount:道具数量 price:道具单价";
            break;
            
            
            default:
            cell.textLabel.text = @"unknown";
            cell.detailTextLabel.text = @"unknown";
            
            break;
        }
        
        
        return cell;
    }
    else if (indexPath.section == 6){
        
        static NSString *NOTIFY = @"cell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:NOTIFY];
        NSString *CellIdentifier = [NSString stringWithFormat:@"umSection4ideitifier"];//以indexPath来唯一确定cell
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            
        }
        tableView.rowHeight = 60.0f;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        switch (indexPath.row) {
            case UMbonus_title:
            cell.textLabel.text=@"虚拟币及道具奖励统计";
            cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            tableView.rowHeight = 50.0f;
            
            
            break;
            case UMbonus:
            cell.textLabel.text = @"bonus";
            cell.detailTextLabel.text = @"coin:虚拟币数量 source:奖励方式";
            break;
            
            case UMbonus_item:
            cell.textLabel.text = @"bonus_item";
            cell.detailTextLabel.text = @"item:道具名称 amount:道具数量 price:道具单价 source:奖励方式";
            break;
            
            default:
            cell.textLabel.text = @"unknown";
            cell.detailTextLabel.text = @"unknown";
            
            break;
        }
        
        
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
            case UMpuid_SignIn:
            {
                [MobClickGameAnalytics profileSignInWithPUID:@"userID"];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];

            }
            break;
            case UMpuid_SignOff:
            {
                [MobClickGameAnalytics profileSignOff];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
          
            default:
            break;
        }
    }
    else if (indexPath.section == 1){
        switch (indexPath.row) {
            case UMlevel:
            {
                [MobClickGameAnalytics setUserLevelId:20];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            
            default:
            break;
        }
    }
    else if (indexPath.section == 2){
        switch (indexPath.row) {
            case UMlevel_startLevel:
            {
                [MobClickGameAnalytics startLevel:@"levelA"];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            case UMlevel_finishLevel:
            {
                [MobClickGameAnalytics finishLevel:@"levelA"];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            case UMlevel_failLevel:
            {
                [MobClickGameAnalytics failLevel:@"levelA"];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            
            default:
            break;
        }
      
    }
    else if (indexPath.section == 3){
        switch (indexPath.row) {
            case UMpay_exchange:
            {
                [MobClickGameAnalytics exchange:@"orderID" currencyAmount:20.2 currencyType:@"CNY" virtualCurrencyAmount:10 paychannel:5];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            case UMpay_cash:
            {
                [MobClickGameAnalytics pay:10.2 source:6 coin:3];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            case UMpay_item:
            {
                [MobClickGameAnalytics pay:20.1 source:3 item:@"itemA" amount:5 price:10.3];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            
            default:
            break;

        }
    }
    else if (indexPath.section == 4){
        switch (indexPath.row) {
            case UMbuy:
            {
                [MobClickGameAnalytics buy:@"itemB" amount:3 price:20.5];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            
            default:
            break;
            
        }
    }
    else if (indexPath.section == 5){
        switch (indexPath.row) {
            case UMuse:
            {
                [MobClickGameAnalytics use:@"itemC" amount:7 price:2.3];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            
            default:
            break;
            
        }
    }
    else if (indexPath.section == 6){
        switch (indexPath.row) {
            case UMbonus:
            {
                [MobClickGameAnalytics bonus:20 source:5];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            case UMbonus_item:
            {
                [MobClickGameAnalytics bonus:@"itemE" amount:3 price:21.1 source:6];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
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


