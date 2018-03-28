//
//  UMUpdateLogViewController.m
//  UMengComDemo
//
//  Created by 张军华 on 2018/1/22.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import "UMUpdateLogViewController.h"
#import "UMSegmentView.h"
#import "UMFlipCollectionView.h"
#import "UMDetailUpdateLogViewController.h"

@interface UMUpdateLogViewController ()<UMSegmentViewDeletegate,UMFlipCollectionViewDelegate>

@property(nonatomic,strong)UMSegmentView * segmentView;
@property(nonatomic,strong)UMFlipCollectionView * collectView;

-(NSArray*) detailUpdateLogViewControllerArray;

@end

@implementation UMUpdateLogViewController

-(void)handleBackBtn:(id)target
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //防止segmentView的在IOS7以后延伸到 navigationBar下面
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    
    //设置返回按钮
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(handleBackBtn:)];
//    self.navigationItem.leftBarButtonItem = backItem;
    
    //设置UMSegmentView
    self.segmentView = [[UMSegmentView alloc] init];
    self.segmentView.delegate =  self;
    self.segmentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44);
    self.segmentView.items = @[@"UApp",@"UPush", @"UShare"];
    [self.view addSubview:self.segmentView];

//    NSArray *arr = @[[self controller],
//                     [self controller],
//                     [self controller],
//                     ];
    self.collectView = [[UMFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                          CGRectGetMaxY(self.segmentView.frame),
                                                                          CGRectGetWidth(self.segmentView.frame),
                                                                          CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(self.segmentView.frame)) withArray:[self detailUpdateLogViewControllerArray]];
    
    
    self.collectView.delegate = self;
    [self.view addSubview:self.collectView];
}

-(NSArray*) detailUpdateLogViewControllerArray
{
    NSString* uAppJsonPath =  [[NSBundle mainBundle] pathForResource:@"UApp_releaseNote_Public" ofType:@"json"];
    UMDetailUpdateLogViewController* uAppVC =  [[UMDetailUpdateLogViewController alloc] init];
    uAppVC.updateLogType = UMengComUpdateLogType_UApp;
    uAppVC.jsonFilePath = uAppJsonPath;
    
    
    NSString* uPushJsonPath =  [[NSBundle mainBundle] pathForResource:@"UPush_releaseNote_Public" ofType:@"json"];
    UMDetailUpdateLogViewController* uPushVC =  [[UMDetailUpdateLogViewController alloc] init];
    uPushVC.updateLogType = UMengComUpdateLogType_UPush;
    uPushVC.jsonFilePath = uPushJsonPath;
    
    NSString* uShareJsonPath =  [[NSBundle mainBundle] pathForResource:@"UShare_releaseNote_Public" ofType:@"json"];
    UMDetailUpdateLogViewController* uShareVC =  [[UMDetailUpdateLogViewController alloc] init];
    uShareVC.updateLogType = UMengComUpdateLogType_UShare;
    uShareVC.jsonFilePath = uShareJsonPath;
    
    return @[uAppVC,uPushVC,uShareVC];
}

//- (UIViewController *)controller
//{
////    UIViewController *vc = [[UIViewController alloc] init];
////    CGFloat red = arc4random() / (CGFloat)INT_MAX;
////    CGFloat green = arc4random() / (CGFloat)INT_MAX;
////    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
////    vc.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//    
//    UIViewController *vc = [[UMDetailUpdateLogViewController alloc] init];
//    return vc;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UMSegmentViewDeletegate
-(void)changeSegmentAtIndex:(NSInteger)segIndex
{
    NSLog(@"changeSegmentAtIndex:%ld",segIndex);
    [self.collectView selectIndex:segIndex];
}


#pragma mark - UMFlipCollectionViewDelegate

- (void)flipToIndex:(NSInteger)index
{
    NSLog(@"flipToIndex:%ld",index);
    [self.segmentView selectIndex:index];
}

@end
