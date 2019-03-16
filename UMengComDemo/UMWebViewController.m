//
//  UMWebViewController.m
//  UMessage
//
//  Created by shile on 2017/5/25.
//  Copyright © 2017年 umeng.com. All rights reserved.
//

#import "UMWebViewController.h"

@interface UMWebViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation UMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我是广告";
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)dealloc
{
    NSLog(@"dealloc");
}

@end
