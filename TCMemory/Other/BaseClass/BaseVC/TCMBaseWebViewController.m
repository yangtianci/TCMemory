//
//  TCMBaseWebViewController.m
//  TCMemory
//
//  Created by YangTianCi on 2018/4/16.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import "TCMBaseWebViewController.h"

@interface TCMBaseWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@end

@implementation TCMBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ConfigUI];
    
}

-(void)ConfigUI
{
    self.wkWebView = [[WKWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.wkWebView];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
}

@end
