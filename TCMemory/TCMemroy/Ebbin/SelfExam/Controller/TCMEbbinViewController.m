//
//  TCMEbbinViewController.m
//  TCMemory
//
//  Created by YangTianCi on 2018/4/12.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import "TCMEbbinViewController.h"
#import "TCMTodayAimCell.h"
#import "TCMEverNoteController.h"
#import "TCMTodayAimHeader.h"
#import "TCMTodayAimFooter.h"
#import "TCMSelfExamRecordController.h"

#import <CoreImage/CoreImage.h>

@interface TCMEbbinViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *customTableView;

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSArray *descArray;
@property (nonatomic, strong) NSArray *levelArray;
@property (nonatomic, strong) NSMutableArray *clickArray;



@end

@implementation TCMEbbinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //增加当日记录功能, 合理利用零碎时间
    [self todayRecord];
    
    // 初始化数据 & tableview 基本设置
    [self BaseConfig];
    
}


#pragma mark >>>>>>>>>> 增加当日记录功能, 合理使用零散时间
-(void)todayRecord{
    
    UIBarButtonItem *itme = [[UIBarButtonItem alloc]initWithTitle:@"Self-Record" style:UIBarButtonItemStyleDone target:self action:@selector(TodayRecordController)];
    
    self.navigationItem.rightBarButtonItem = itme;
    
}

-(void)TodayRecordController{
    TCMSelfExamRecordController *TRV = [[TCMSelfExamRecordController alloc]init];
    [self.navigationController pushViewController:TRV animated:YES];
}

#pragma mark >>>>>>>>>> 初始化数据 & tableview 基本设置
-(void)BaseConfig{
    
    self.customTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.customTableView];
    self.customTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    self.customTableView.backgroundColor = [UIColor whiteColor];
    
    self.titleArray = [NSMutableArray array];

    for (int i = 0; i < 12; i++) {
        if (i == 0) {
            [self.titleArray addObject:@"1 / 当前"];
        }else{
            [self.titleArray addObject:[NSString stringWithFormat:@"%zd / 复习内容",i+1]];
        }
    }
    
    self.clickArray = [NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0, nil];
    
    // 间隔时间: @[@(1),@(2),@(4),@(7),@(15),@(30),@(60),@(100),@(180)];
    self.levelArray = @[
                        @"间隔:0 天",
                        @"间隔:1 天",
                        @"间隔:2 天",
                        @"间隔:4 天",
                        @"间隔:7 天",
                        @"间隔:15 天",
                        @"间隔:22 天",
                        @"间隔:30 天",
                        @"间隔:45 天",
                        @"间隔:60 天",
                        @"间隔:100 天",
                        @"间隔:180 天"
                        ];
    
    TCMTimeCaculater *tiemr = [TCMTimeCaculater sharedManager];
    self.descArray = [tiemr CaculateEbbinForSelfExam];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *desc = self.descArray[indexPath.section];
    NSString *pastString = [desc stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [UIPasteboard generalPasteboard].string = pastString;
    
    TCMTodayAimCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSInteger currentCoutn = [self.clickArray[indexPath.section] integerValue];
    currentCoutn++;
    [self.clickArray replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithInteger:currentCoutn]];
    cell.tagCount = [self.clickArray[indexPath.section] integerValue];
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"evernote://"] options:@{@"nil":@"nil"} completionHandler:^(BOOL success) {
        [self.customTableView reloadData];
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.descArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TCMTodayAimCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"TCMTodayAimCell" owner:nil options:nil].lastObject;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLabel.text = self.titleArray[indexPath.section];
    cell.descLabel.text = self.descArray[indexPath.section];
    cell.tagCount = [self.clickArray[indexPath.section] integerValue];
    cell.levelLabel.text = self.levelArray[indexPath.section];
    
    //点击一次后颜色置灰
    if (cell.tagCount >= 1) {
        cell.backgroundColor = HexColor(0x90DAFF, 1);
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionh = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    sectionh.backgroundColor = HexColor(0xFFD700, 1);
    return sectionh;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.6;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *sectionh = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    sectionh.backgroundColor = HexColor(0xFFD700, 1);
    return sectionh;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 10) {
        return 0.6;
    }else{
        return 0.01;
    }
}

@end
