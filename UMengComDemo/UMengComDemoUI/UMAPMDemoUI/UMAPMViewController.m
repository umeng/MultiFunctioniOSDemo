//
//  UMAPMViewController.m
//  UMengComDemo
//
//  Created by wangkai on 2020/12/12.
//  Copyright © 2020 张军华. All rights reserved.
//

#import "UMAPMViewController.h"
#import <UMAPM/UMCrashConfigure.h>
#import "UMAlertView.h"
//tableview的indexPath需要的枚举变量
typedef NS_ENUM(NSInteger, UMengComType)
{
    //indexPath.section = 0
    UMAPM_title=0,
    UMAPM_oc = 1,
    UMAPM_native = 2,
    UMAPM_callback = 3,
   
    
};

@interface UMAPMViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,readwrite,strong)UITableView* aTableView;

@end

@implementation UMAPMViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置title
    self.title = @"APM";
    
    //创建UITableView
    self.aTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.aTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.aTableView.delegate = self;
    self.aTableView.dataSource = self;
    [self.view addSubview:self.aTableView];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRowsInSection = 0;
    switch (section) {
        case 0:
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
            case UMAPM_title:
            cell.textLabel.text=@"APM";
            cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            tableView.rowHeight = 50.0f;

            
            break;
            case UMAPM_oc:
            cell.textLabel.text = @"点击产生OC层crash";
            cell.detailTextLabel.text = @"需要断开Xcode调试产生崩溃,数据会在app下次启动时上报";
            break;
            case UMAPM_native:
            cell.textLabel.text = @"点击产生非OC层crash";
            cell.detailTextLabel.text = @"需要断开Xcode调试产生崩溃,数据会在app下次启动时上报";

            break;
            case UMAPM_callback:
            cell.textLabel.text = @"产生回调";
            cell.detailTextLabel.text = @"设置产生crash的回调内容";

            break;
         
            default:
            cell.textLabel.text = @"unknown";
            cell.detailTextLabel.text = @"unknown";

            break;
        }
        
        
        return cell;
        
        
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case UMAPM_oc:
            {
                NSArray *array = [NSArray array];
                [array objectAtIndex:NSUIntegerMax];

            }
            break;
            case UMAPM_native:
            {
                char *p = NULL;
                char a[30] = "string(1)";
                strcpy(p, a);
            }
            break;
            case UMAPM_callback:
            {
                [UMCrashConfigure setCrashCBBlock:^NSString * _Nullable{
                    NSLog(@"UMCB");
                    return @"UMString";
                }];
                UMAlertView * alert = [[UMAlertView alloc] initSuccessAlertViewWithTitle:@"操作成功" content:nil];
                [alert showAlert];
            }
            break;
          
            default:
            break;
           
        }
    }
    
}
@end
