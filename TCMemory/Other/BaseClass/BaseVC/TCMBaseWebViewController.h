//
//  TCMBaseWebViewController.h
//  TCMemory
//
//  Created by YangTianCi on 2018/4/16.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@interface TCMBaseWebViewController : BaseViewController

@property (nonatomic, copy) NSString *webUrl;

@property (nonatomic, copy) NSString *webTitle;

@property (nonatomic, strong) WKWebView *wkWebView;

@end
