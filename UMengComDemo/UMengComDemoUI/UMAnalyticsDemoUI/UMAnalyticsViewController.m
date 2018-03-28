//
//  UMAnalyticsViewController.m
//  UMengComDemo
//
//  Created by wangkai on 2018/1/25.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import "UMAnalyticsViewController.h"
#import <UMAnalytics/MobClick.h>
#import "UMAlertView.h"
//tableview的indexPath需要的枚举变量
typedef NS_ENUM(NSInteger, UMengComType)
{
    //indexPath.section = 0
    UMEvent_title=0,
    UMEvent_event = 1,
    UMEvent_label = 2,
    UMEvent_attributes = 3,
    UMEvent_counter = 4,
    UMEvent_durations = 5,
    UMEvent_beginEvent = 6,
    UMEvent_endEvent = 7,


    
    //indexPath.section = 1
    UMPage_title=0,
    UMPage_logPageView = 1,
    UMPage_beginLogPageView = 2,
    UMPage_endLogPageView = 3,

    
};


@interface UMAnalyticsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,readwrite,strong)UITableView* aTableView;

@end
@implementation UMAnalyticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置title
    self.title = @"统计UApp";
    
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRowsInSection = 0;
    switch (section) {
        case 0:
        numberOfRowsInSection = 8;
        break;
        case 1:
        numberOfRowsInSection = 4;
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
            case UMEvent_title:
            cell.textLabel.text=@"自定义事件";
            cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            tableView.rowHeight = 50.0f;

            
            break;
            case UMEvent_event:
            cell.textLabel.text = @"event";
            cell.detailTextLabel.text = @"eventId:事件ID";
            break;
            case UMEvent_label:
            cell.textLabel.text = @"event_label";
            cell.detailTextLabel.text = @"eventId:事件ID label:分类标签";

            break;
            case UMEvent_attributes:
            cell.textLabel.text = @"event_attributes";
            cell.detailTextLabel.text = @"eventId:事件ID attributes:自定义属性";

            break;
            case UMEvent_counter:
            cell.textLabel.text = @"event_attributes_counter";
            cell.detailTextLabel.text = @"eventId:事件ID attributes:自定义属性 counter:数量";
            
            break;
            case UMEvent_durations:
            cell.textLabel.text = @"event_durations";
            cell.detailTextLabel.text = @"eventId:事件ID durations:时长(毫秒)";
            
            break;
            case UMEvent_beginEvent:
            cell.textLabel.text = @"beginEvent";
            cell.detailTextLabel.text = @"eventId:事件ID(需要与endEvent配对使用)";
            
            break;
            case UMEvent_endEvent:
            cell.textLabel.text = @"endEvent";
            cell.detailTextLabel.text = @"eventId:事件ID";
            
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
            case UMPage_title:
            cell.textLabel.text=@"页面统计";
            cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            tableView.rowHeight = 50.0f;
            
            
            break;
            case UMPage_logPageView:
            cell.textLabel.text = @"logPageView";
            cell.detailTextLabel.text = @"pageName:页面名称 seconds:时长(单位:秒)";
            break;
            case UMPage_beginLogPageView:
            cell.textLabel.text = @"beginLogPageView";
            cell.detailTextLabel.text = @"pageName:页面名称(需要与endLogPageView配对使用)";
            
            break;
            case UMPage_endLogPageView:
            cell.textLabel.text = @"endLogPageView";
            cell.detailTextLabel.text = @"pageName:页面名称";
            
            break;
            default:
            cell.textLabel.text = @"unknown";
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
            case UMEvent_event:
            {
                [MobClick event:@"eventA"];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];

            }
            break;
            case UMEvent_label:
            {
                [MobClick event:@"eventB" label:@"labelA"];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            case UMEvent_attributes:
            {
                [MobClick event:@"eventC" attributes:@{@"key1":@"val1",@"key2":@"val2"}];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            case UMEvent_counter:
            {
                [MobClick event:@"eventD" attributes:@{@"key1":@"val1",@"key2":@"val2"} counter:20];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            case UMEvent_durations:
            {
                [MobClick event:@"eventE" durations:5000];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            case UMEvent_beginEvent:
            {
                [MobClick beginEvent:@"eventF"];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:@"需要与endEvent配对使用"];
                [alert showAlert];
            }
            break;
            case UMEvent_endEvent:
            {
                [MobClick endEvent:@"eventF"];
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
            case UMPage_logPageView:
            {
                [MobClick logPageView:@"pageA" seconds:12];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            case UMPage_beginLogPageView:
            {
                [MobClick beginLogPageView:@"pageB"];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:@"需要与endLogPageView配对使用"];
                [alert showAlert];
            }
            break;
            case UMPage_endLogPageView:
            {
                [MobClick endLogPageView:@"pageB"];
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
