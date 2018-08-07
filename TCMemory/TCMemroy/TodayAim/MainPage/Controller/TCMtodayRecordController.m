//
//  TCMtodayRecordController.m
//  TCMemory
//
//  Created by YangTianCi on 2018/8/7.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import "TCMtodayRecordController.h"


@interface TCMtodayRecordController ()

@property (nonatomic, strong) NSMutableArray *viewArray;

@end

@implementation TCMtodayRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CreatBlock];
    
    [self LoadData];
    
    [self UnsetMethod];
    
}


-(void)UnsetMethod{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"Unset" style:1 target:self action:@selector(ClearDataMethod)];
    self.navigationItem.rightBarButtonItem = item;
    
}


#pragma mark >>>>>>>>>> 加载历史数据
-(void)LoadData{
    
    for (int i = 1; i < 13; i++) {
        NSString *key = [NSString stringWithFormat:@"%zd",i];
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
        
        UIView *blockV = [[UIView alloc]init];
        blockV.frame = CGRectMake( marginRL + colN * itemW, marginTB + rowN * itemH, itemW, itemH);
        blockV.backgroundColor = kRandomColor;
        blockV.tag = i + 1;
        
        [self.view addSubview:blockV];
        [self.viewArray addObject:blockV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:blockV.bounds];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [blockV addSubview:label];
        label.text = [NSString stringWithFormat:@"%zd", i + 1];
        
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
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:[NSString stringWithFormat:@"%zd",tag]];
    
}


-(void)ClearDataMethod{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i = 1; i < 13; i++) {
        NSString *key = [NSString stringWithFormat:@"%zd",i];
        [dict setObject:@"0" forKey:key];
    }
    [[NSUserDefaults standardUserDefaults] setValuesForKeysWithDictionary:dict];
    
    for (UIView *blockV in self.viewArray) {
        blockV.backgroundColor = kRandomColor;
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
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
