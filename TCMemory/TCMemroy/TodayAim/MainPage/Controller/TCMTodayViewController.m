//
//  TCMTodayViewController.m
//  TCMemory
//
//  Created by YangTianCi on 2018/4/12.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import "TCMTodayViewController.h"
#import "TCMTodayAimCell.h"

@interface TCMTodayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *customTableView;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *descArray;

@end

@implementation TCMTodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.customTableView];
    self.customTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    
    self.titleArray = @[@"当前时间",@"复习内容",@"复习内容",@"复习内容",@"复习内容",@"复习内容",@"复习内容",@"复习内容",@"复习内容",@"复习内容"];
    
    TCMTimeCaculater *tiemr = [TCMTimeCaculater sharedManager];
    self.descArray = [tiemr CaculateEbbinTimeFromNow];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
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
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionh = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    sectionh.backgroundColor = kRandomColor;
    return sectionh;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return kMarginMiddle;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


@end
