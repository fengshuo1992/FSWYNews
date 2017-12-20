//
//  FSChildViewController.m
//  FSWYNews
//
//  Created by 杭州米发 on 2017/12/20.
//  Copyright © 2017年 冯硕. All rights reserved.
//

#import "FSChildViewController.h"
#import "HotViewController.h"
#import "TopViewController.h"
#import "VideoViewController.h"
#import "TestViewController.h"
#import "FinancialViewController.h"
#import "ColorViewController.h"
#import "DiscoverViewController.h"
@interface FSChildViewController ()

@end

@implementation FSChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置子控制器
    [self addChildController];
    
}

#pragma  mark - 设置父子视图
- (void)addChildController
{
    TopViewController * topVC = [[TopViewController alloc] init];
    topVC.title = @"首页";
    [self addChildViewController:topVC];
    
    HotViewController * hotVC = [[HotViewController alloc] init];
    hotVC.title = @"热点";
    [self addChildViewController:hotVC];
    
    
    TestViewController * testVC = [[TestViewController alloc] init];
    testVC.title = @"测试";
    [self addChildViewController:testVC];
    
    FinancialViewController * financialVC = [[FinancialViewController alloc] init];
    financialVC.title = @"理财";
    [self addChildViewController:financialVC];
    
    VideoViewController * videoVC = [[VideoViewController alloc] init];
    videoVC.title = @"视频";
    [self addChildViewController:videoVC];
    
    ColorViewController * colorVC = [[ColorViewController alloc] init];
    colorVC.title = @"颜色";
    [self addChildViewController:colorVC];
    
    
//    DiscoverViewController* discoverVC = [[DiscoverViewController alloc] init];
//    discoverVC.title = @"发现";
//    [self addChildViewController:discoverVC];
    
    
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
