//
//  BaseViewController.m
//  TCMemory
//
//  Created by YangTianCi on 2018/4/12.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) MBProgressHUD *normalHud;//普通
@property (nonatomic, strong) MBBarProgressView *barProgressHud;//条形进度
@property (nonatomic, strong) MBRoundProgressView *roundProgressHud;//圆形进度

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}


#pragma mark >>>>>>>>>> 菊花相关函数

-(void)showHud{
    [self.normalHud showAnimated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationShort * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_normalHud hideAnimated:YES];
    });
}

-(void)showHudType:(HudType)type{
    if (type == HudType_Normal) {
        [self showHud];
    }else if (type == HudType_Bar){
        self.barProgressHud.progress = 0.0;
        [UIView animateWithDuration:3.0 animations:^{
            self.barProgressHud.progress = 100;
        } completion:^(BOOL finished) {
            [self.barProgressHud removeFromSuperview];
        }];
    }else if (type == HudType_round){
        self.roundProgressHud.progress = 0.0;
        [UIView animateWithDuration:3.0 animations:^{
            _roundProgressHud.progress = 100;
        } completion:^(BOOL finished) {
            [_roundProgressHud removeFromSuperview];
        }];
    }
}

-(void)hideHud{
    if (_normalHud) {
        [_normalHud removeFromSuperview];
    }else if (_barProgressHud){
        [_barProgressHud removeFromSuperview];
    }else if (_roundProgressHud){
        [_roundProgressHud removeFromSuperview];
    }
}


-(MBProgressHUD *)normalHud{
    if (!_normalHud) {
        if (self.navigationController.view) {
            _normalHud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        }else{
            _normalHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        }
    }
    return _normalHud;
}

-(MBBarProgressView *)barProgressHud{
    if (!_barProgressHud) {
        if (self.navigationController.view) {
            _barProgressHud = [[MBBarProgressView alloc]initWithFrame:self.navigationController.view.bounds];
            [self.navigationController.view addSubview:_barProgressHud];
        }else{
            _barProgressHud = [[MBBarProgressView alloc]initWithFrame:self.view.bounds];
            [self.view addSubview:_barProgressHud];
        }
    }
    return _barProgressHud;
}

-(MBRoundProgressView *)roundProgressHud{
    if (!_roundProgressHud) {
        if (self.navigationController.view) {
            _roundProgressHud = [[MBRoundProgressView alloc]initWithFrame:self.navigationController.view.bounds];
            [self.navigationController.view addSubview:_roundProgressHud];
        }else{
            _roundProgressHud = [[MBRoundProgressView alloc]initWithFrame:self.view.bounds];
            [self.view addSubview:_roundProgressHud];
        }
    }
    return _roundProgressHud;
}



@end
