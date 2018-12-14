//
//  TCMSelfExamRecordController.m
//  TCMemory
//
//  Created by 杨天赐 on 2018/11/20.
//  Copyright © 2018 www.YangTianCi.com. All rights reserved.
//

#import "TCMSelfExamRecordController.h"

#import <CoreMotion/CoreMotion.h>

#import <Masonry/Masonry.h>

@interface TCMSelfExamRecordController ()

@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation TCMSelfExamRecordController






- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self CreatBlock];
    
    [self LoadData];
    
    [self UnsetMethod];
    
    [self CMDemo];
}


-(void)UnsetMethod{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"Unset" style:1 target:self action:@selector(ClearDataMethod)];
    self.navigationItem.rightBarButtonItem = item;
    
}


-(void)CMDemo{
    
    self.motionManager = [[CMMotionManager alloc]init];
    self.motionManager.accelerometerUpdateInterval = 0.01;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        if (accelerometerData.acceleration.x > 2 || accelerometerData.acceleration.x < -2) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}

#pragma mark >>>>>>>>>> 加载历史数据
-(void)LoadData{
    
    for (int i = 1; i < 13; i++) {
        NSString *key = [NSString stringWithFormat:@"%d-自考",i];
        NSString *value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        BOOL isOK = [value boolValue];
        if (isOK) {
            UIView *blockV = self.viewArray[i - 1];
            [self OKMethod:(UITapGestureRecognizer*)blockV.gestureRecognizers];
        }
    }
    
}


#pragma mark >>>>>>>>>> 创建 view

-(void)CreatBlock{
    
    self.viewArray = [NSMutableArray array];
    
    CGFloat marginRL = 20;
    CGFloat marginTB = 120;
    
    CGFloat totalWidth = kScreenWidth - 2 * marginRL;
    CGFloat totalHeight = kScreenHeight - 2 * marginTB;
    
    CGFloat itemW = totalWidth / 4;
    CGFloat itemH = totalHeight / 3;
    
    for (int i = 0; i < 12; i++) {
        
        NSInteger colN = i % 4;
        NSInteger rowN = i / 4;
        
//        CGPoint centerP = CGPointMake((marginRL + colN * itemW + itemW/2), marginTB + rowN * itemH + itemH/2);
    
        UIView *blockV = [[UIView alloc]init];
        blockV.frame = CGRectMake( marginRL + colN * itemW, marginTB + rowN * itemH, itemW, itemH);
        blockV.backgroundColor = kRandomColor;
        blockV.tag = i + 1;
        
        [self.view addSubview:blockV];
        [self.viewArray addObject:blockV];
        
//        self.view.layer.cornerRadius = itemW/2;
//        self.view.layer.masksToBounds = YES;
        
        // ====================================================================
        
        UILabel *label = [[UILabel alloc]initWithFrame:blockV.bounds];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [blockV addSubview:label];
        label.text = [NSString stringWithFormat:@"%d", i + 1];
        
//        label.layer.cornerRadius = itemW/2;
//        label.layer.masksToBounds = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OKMethod:)];
        [blockV addGestureRecognizer:tap];
    }
}


-(void)OKMethod:(UITapGestureRecognizer*)tap{
    
    if ([tap isKindOfClass:[NSArray class]]) {
        NSArray *arr = (NSArray*)tap;
        tap = arr.firstObject;
    }
    
    UIView *blockV = tap.view;
    blockV.backgroundColor = [UIColor whiteColor];
    
    NSInteger tag = blockV.tag;
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:[NSString stringWithFormat:@"%zd-自考",tag]];
    
}


-(void)ClearDataMethod{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i = 1; i < 13; i++) {
        NSString *key = [NSString stringWithFormat:@"%d-自考",i];
        [dict setObject:@"0" forKey:key];
    }
    [[NSUserDefaults standardUserDefaults] setValuesForKeysWithDictionary:dict];
    
    for (UIView *blockV in self.viewArray) {
        blockV.backgroundColor = kRandomColor;
    }
    
}






@end
