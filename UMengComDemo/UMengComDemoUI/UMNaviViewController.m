//
//  UMNaviViewController.m
//  UMengComDemo
//
//  Created by shile on 2018/1/24.
//  Copyright © 2018年 张军华. All rights reserved.
//

#import "UMNaviViewController.h"

@interface UMNaviViewController ()

@end

@implementation UMNaviViewController

+(void)initialize
{
    UINavigationBar *bar=[UINavigationBar appearance];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [bar setBarTintColor:[UIColor blackColor]];
    UIColor * titleTextAttributes = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:titleTextAttributes forKey:UITextAttributeTextColor];
    bar.titleTextAttributes = dict;

}

//重写返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count >1) {
        viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
    }
}
-(UIBarButtonItem *)creatBackButton
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 70, 40)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [backButton.titleLabel setTextColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0]];
    [backButton setImage:[UIImage imageNamed:@"arrow_l"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem  alloc] initWithCustomView:backButton];
    return backItem;
}
-(void)popSelf
{
    [self popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
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

@end
