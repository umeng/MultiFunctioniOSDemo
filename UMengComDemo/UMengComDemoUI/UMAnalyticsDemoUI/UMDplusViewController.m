//
//  UMDplusViewController.m
//  UMengComDemo
//
//  Created by wangkai on 2018/1/25.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import "UMDplusViewController.h"
#import <UMAnalytics/DplusMobClick.h>
#import "UMAlertView.h"

//tableview的indexPath需要的枚举变量
typedef NS_ENUM(NSInteger, UMengComType)
{
    //indexPath.section = 0
    UMTrack_title=0,
    UMTrack = 1,
    UMTrack_property = 2,
    
    //indexPath.section = 1
    UMSuperProperty_title=0,
    UMSuperProperty_register = 1,
    UMSuperProperty_unregister = 2,
    UMSuperProperty_get = 3,
    UMSuperProperty_getAll = 4,
    UMSuperProperty_clear = 5,
    
    //indexPath.section = 2
    UMPreProperty_title=0,
    UMPreProperty_register = 1,
    UMPreProperty_unregister = 2,
    UMPreProperty_getAll = 3,
    UMPreProperty_clear = 4
};


@interface UMDplusViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,readwrite,strong)UITableView* aTableView;

@end
@implementation UMDplusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置title
    self.title = @"统计Dplus";
    
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
        numberOfRowsInSection = 3;
        break;
        case 1:
        numberOfRowsInSection = 6;
        break;
        case 2:
        numberOfRowsInSection = 5;
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
            case UMTrack_title:
            cell.textLabel.text=@"自定义事件";
            cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            tableView.rowHeight = 50.0f;
            
            
            break;
            case UMTrack:
            cell.textLabel.text = @"track";
            cell.detailTextLabel.text = @"eventName:事件名";
            break;
            case UMTrack_property:
            cell.textLabel.text = @"track_property";
            cell.detailTextLabel.text = @"eventName:事件名 property:自定义属性";
            
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
            case UMSuperProperty_title:
            cell.textLabel.text=@"超级属性";
            cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            tableView.rowHeight = 50.0f;
            
            
            break;
            case UMSuperProperty_register:
            cell.textLabel.text = @"registerSuperProperty";
            cell.detailTextLabel.text = @"property:自定义属性";
            break;
            case UMSuperProperty_unregister:
            cell.textLabel.text = @"unregisterSuperProperty";
            cell.detailTextLabel.text = @"propertyName:自定义属性名称";
            break;
            case UMSuperProperty_get:
            cell.textLabel.text = @"getSuperProperty";
            cell.detailTextLabel.text = @"propertyName:自定义属性名称";
            break;
            case UMSuperProperty_getAll:
            cell.textLabel.text = @"getSuperProperties";
            cell.detailTextLabel.text = @"获取全部超级属性";
            break;
            case UMSuperProperty_clear:
            cell.textLabel.text = @"clearSuperProperties";
            cell.detailTextLabel.text = @"清除所有超级属性";
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
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        tableView.rowHeight = 60.0f;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        switch (indexPath.row) {
            case UMPreProperty_title:
            cell.textLabel.text=@"预置事件属性";
            cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            tableView.rowHeight = 50.0f;
            
            
            break;
            case UMPreProperty_register:
            cell.textLabel.text = @"registerPreProperties";
            cell.detailTextLabel.text = @"property:自定义属性";
            break;
            
            case UMPreProperty_unregister:
            cell.textLabel.text = @"unregisterPreProperty";
            cell.detailTextLabel.text = @"propertyName:自定义属性名称";
            break;
            case UMPreProperty_getAll:
            cell.textLabel.text = @"getPreProperties";
            cell.detailTextLabel.text = @"获取全部预置事件属性";
            break;
            case UMPreProperty_clear:
            cell.textLabel.text = @"clearPreProperties";
            cell.detailTextLabel.text = @"清除所有预置事件属性";
            break;
            
            default:
            cell.textLabel.text = @"unknown";
            cell.detailTextLabel.text = @"unknown";
            
            break;
        }
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
            case UMTrack:
            {
                [DplusMobClick track:@"trackA"];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            case UMTrack_property:
            {
                [DplusMobClick track:@"trackB" property:@{@"key1":@"val1",@"key2":@"val2"}];
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
            case UMSuperProperty_register:
            {
                [DplusMobClick registerSuperProperty:@{@"age":@"23",@"name":@"Jack"}];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"注册成功" content:nil];
                [alert showAlert];
            }
            break;
            case UMSuperProperty_unregister:
            {
                [DplusMobClick unregisterSuperProperty:@"name"];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            case UMSuperProperty_get:
            {
                NSString *str=[DplusMobClick getSuperProperty:@"age"];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
                NSLog(@"getSuperProperty:%@",str);
            }
            break;
            case UMSuperProperty_getAll:
            {
                NSDictionary *dic=[DplusMobClick getSuperProperties];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
                NSLog(@"getSuperProperties:%@",dic);
            }
            break;
            case UMSuperProperty_clear:
            {
                [DplusMobClick clearSuperProperties];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"清除成功" content:nil];
                [alert showAlert];
            }
            break;
            default:
            break;
        }
    }
    else if (indexPath.section == 2){
        switch (indexPath.row) {
            case UMPreProperty_register:
            {
                [DplusMobClick registerPreProperties:@{@"name":@"Mark",@"level":@"10"}];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"注册成功" content:nil];
                [alert showAlert];
            }
            break;
            case UMPreProperty_unregister:
            {
                [DplusMobClick unregisterPreProperty:@"level"];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
            case UMPreProperty_getAll:
            {
                NSDictionary *preDic=[DplusMobClick getPreProperties];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
                NSLog(@"getPreProperties:%@",preDic);

            }
            break;
            case UMPreProperty_clear:
            {
                [DplusMobClick clearPreProperties];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"清除成功" content:nil];
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

