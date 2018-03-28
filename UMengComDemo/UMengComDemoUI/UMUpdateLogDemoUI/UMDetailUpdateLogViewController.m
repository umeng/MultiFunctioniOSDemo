//
//  UMDetailUpdateLogViewController.m
//  UMengComDemo
//
//  Created by 张军华 on 2018/1/23.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import "UMDetailUpdateLogViewController.h"

#import "UMDetailLogCell.h"



NSString* UMengComLogName(UMengComUpdateLogType updateLogType)
{
    switch (updateLogType) {
        case UMengComUpdateLogType_UApp:
            return @"UApp";
            break;
        case UMengComUpdateLogType_UPush:
            return @"UPush";
            break;
        case UMengComUpdateLogType_UShare:
            return @"UShare";
            break;
        default:
            return @"Unknown";
            break;
    }
}

@interface UMDetailUpdateLogViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,readwrite,strong)UITableView* detailLogTableView;

@property(nonatomic,readwrite,strong)NSMutableDictionary* cacheHeightForCell;

@property(nonatomic,readwrite,strong)NSMutableArray* detailLogArray;



@end

@implementation UMDetailUpdateLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.detailLogTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.detailLogTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.detailLogTableView.delegate = self;
    self.detailLogTableView.dataSource = self;
    self.detailLogTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.detailLogTableView];
    
    self.cacheHeightForCell = [[NSMutableDictionary alloc] initWithCapacity:2];
    self.detailLogArray = [[NSMutableArray alloc] init];
    
    
    NSArray* resultArray = nil;
    NSData* data =  [NSData dataWithContentsOfFile:self.jsonFilePath];
    if (data) {
        NSError* error = nil;
        resultArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error) {
            NSLog(@"json error :%@",error);
            return;
        }
    }
    
    resultArray = [resultArray.reverseObjectEnumerator allObjects];
    if ([resultArray isKindOfClass:[NSArray class]]) {
        for (int i = 0;i < resultArray.count; i++) {
            NSDictionary* dic =  resultArray[i];
            if ([dic isKindOfClass:[NSDictionary class]]) {
                NSString* version =  [dic valueForKey:@"title"];
                NSString* updateTime =  [dic valueForKey:@"date"];
                NSString* updateLog =  [dic valueForKey:@"content"];
                
                UMDetailLogCellData* cellData =  [[UMDetailLogCellData alloc] init];
                if ([version isKindOfClass:[NSString class]]) {
                    cellData.version = [[NSString alloc] initWithFormat:@"%@ %@",UMengComLogName(self.updateLogType),version];
                }
                else{
                    cellData.version = @"";
                }
                
                if ([updateTime isKindOfClass:[NSString class]]) {
                    cellData.updateTime = [[NSString alloc] initWithFormat:@"更新时间 %@",updateTime];
                }
                else{
                    cellData.updateTime = @"";
                }
                
                if ([updateLog isKindOfClass:[NSString class]]) {
                    cellData.updateLog = updateLog;
                }
                else{
                    cellData.updateLog = @"";
                }
                
                [self.detailLogArray addObject:cellData];
            }//if ([dic isKindOfClass:[NSDictionary class]])
        }//for (int i = 0; resultArray.count; i++)
    }//if ([resultArray isKindOfClass:[NSArray class]])
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detailLogArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *umDetailUpdateLogideitifier = @"umDetailUpdateLogideitifier";
    
    
    UMDetailLogCellData* cellData = [self.detailLogArray objectAtIndex:indexPath.row];
    
    UMDetailLogCell *cell = [tableView dequeueReusableCellWithIdentifier:umDetailUpdateLogideitifier];
    if (!cell) {
        cell = [[UMDetailLogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:umDetailUpdateLogideitifier cellData:cellData];
    }
    
    CGFloat height =  [cell heightForDetailLogCell];
    //缓存高度
    [self.cacheHeightForCell setObject:@(height) forKey:@(indexPath.row)];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.section = %ld,indexPath.row = %ld",(long)indexPath.section,(long)indexPath.row);
    NSNumber* numHeight =  [self.cacheHeightForCell objectForKey:@(indexPath.row)];
    if ([numHeight isKindOfClass:[NSNumber class]]) {
        return numHeight.floatValue;
    }
    else{
        //兼容iOS7
        //iOS7的tableView:heightForRowAtIndexPath:只会调用一次，所以需要预先创建出cell算出高度
        static NSString *umDetailUpdateLogideitifier = @"umDetailUpdateLogideitifier";
        UMDetailLogCellData* cellData = [self.detailLogArray objectAtIndex:indexPath.row];
        UMDetailLogCell *cell = [tableView dequeueReusableCellWithIdentifier:umDetailUpdateLogideitifier];
        if (!cell) {
            cell = [[UMDetailLogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:umDetailUpdateLogideitifier cellData:cellData];
        }
        CGFloat height =  [cell heightForDetailLogCell];
        //缓存高度
        [self.cacheHeightForCell setObject:@(height) forKey:@(indexPath.row)];
        return height;
    }
}

@end
