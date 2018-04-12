//
//  CommonMacro.h
//  TCMemory
//
//  Created by YangTianCi on 2018/4/12.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

//屏幕宽高
#define kScreenBounds [UIScreen mainScreen].bounds.size
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//状态栏高度
#define kStatuebar [[UIApplication sharedApplication] statusBarFrame].size.height

//状态栏 ＋ 导航栏 高度
#define kStatueAndNavbar (kStatuebar + kNavbar)

//控制器视图宽高
#define kViewWidth self.view.frame.size.width
#define kViewHeight self.view.frame.size.height - 44 - kStatuebar

// 底部危险区域
#define kDangerBottom    (ISIPHONEX ?34.f: 0.f)

//沙盒目录

#define kPathTemp                   NSTemporaryDirectory()

#define kPathDocument               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define kPathCache                  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//时间换算
#define kOneDay 24 * 60 * 60

//常用 identifier
#define kCellIdentifier @"kCellIdentifier"



#endif /* CommonMacro_h */
