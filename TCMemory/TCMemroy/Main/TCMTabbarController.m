//
//  TCMTabbarController.m
//  TCMemory
//
//  Created by YangTianCi on 2018/4/12.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import "TCMTabbarController.h"

#import "TCMTodayNavController.h"
#import "TCMTodayViewController.h"

#import "TCMEbbinNavController.h"
#import "TCMEbbinViewController.h"

#import "TCMPalaceNavController.h"
#import "TCMPalaceViewController.h"

#import "TCMChartNavController.h"
#import "TCMChartViewController.h"

#import "TCMMeNavController.h"
#import "TCMMeViewController.h"

@interface TCMTabbarController ()

@end

@implementation TCMTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *navArray = [self CreatNavController];
    NSArray *viewArray = [self CreatRootViewController];
    
    [self setupChildVc:viewArray[0] NacVC:navArray[0] title:@"Today" image:nil selectedImage:nil];
    [self setupChildVc:viewArray[1] NacVC:navArray[1] title:@"自考" image:nil selectedImage:nil];
    [self setupChildVc:viewArray[2] NacVC:navArray[2] title:@"Palace" image:nil selectedImage:nil];
    [self setupChildVc:viewArray[3] NacVC:navArray[3] title:@"Chart" image:nil selectedImage:nil];
    [self setupChildVc:viewArray[4] NacVC:navArray[4] title:@"Me" image:nil selectedImage:nil];
    
    [self hidesBottomBarWhenPushed];
    
}

//设置控制器的属性、标题
- (void)setupChildVc:(UIViewController *)vc NacVC:(NSString*)navvc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
    vc.navigationItem.title = title;
    
    //设置 NavBar
    Class class = NSClassFromString(navvc);
    UINavigationController *navVC = (UINavigationController*)[[class alloc]initWithRootViewController:vc];
    
    UINavigationBar *bar=navVC.navigationBar;
    
    navVC.tabBarItem.title = title;
    navVC.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navVC.hidesBottomBarWhenPushed = NO;
    navVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    bar.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:navVC];
    
}

-(NSArray*)CreatRootViewController{
    TCMTodayViewController *todayView = [[TCMTodayViewController alloc]init];
    todayView.view.backgroundColor = kRandomColor;
    TCMEbbinViewController *ebbinView = [[TCMEbbinViewController alloc]init];
    ebbinView.view.backgroundColor = kRandomColor;
    TCMPalaceViewController *palaceView = [[TCMPalaceViewController alloc]init];
    palaceView.view.backgroundColor = kRandomColor;
    TCMChartViewController *chartView = [[TCMChartViewController alloc]init];
    chartView.view.backgroundColor = kRandomColor;
    TCMMeViewController *meView = [[TCMMeViewController alloc]init];
    meView.view.backgroundColor = kRandomColor;
    NSArray *viewArray = @[todayView, ebbinView, palaceView, chartView, meView];
    return viewArray;
}

-(NSArray*)CreatNavController{
    NSArray *navArray = @[@"TCMTodayNavController", @"TCMEbbinNavController", @"TCMPalaceNavController", @"TCMChartNavController", @"TCMMeNavController"];
    return navArray;
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
