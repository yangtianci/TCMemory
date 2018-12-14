//
//  TCMTodayViewController.m
//  TCMemory
//
//  Created by YangTianCi on 2018/4/12.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import "TCMTodayViewController.h"
#import "TCMTodayAimCell.h"
#import "TCMEverNoteController.h"
#import "TCMTodayAimHeader.h"
#import "TCMTodayAimFooter.h"
#import "TCMtodayRecordController.h"

#import <CoreImage/CoreImage.h>

@interface TCMTodayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *customTableView;

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSArray *descArray;
@property (nonatomic, strong) NSArray *levelArray;
@property (nonatomic, strong) NSMutableArray *clickArray;



@end

@implementation TCMTodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     阶段回顾: 20180416 - 20180608 : 8 周, 40 天 ==> 虽然完成的东西不多
     */
    
    //

    //增加当日记录功能, 合理利用零碎时间
    [self todayRecord];
    
    // 初始化数据 & tableview 基本设置
    [self BaseConfig];

    
    
    
}





#pragma mark >>>>>>>>>> 增加当日记录功能, 合理使用零散时间
-(void)todayRecord{
    
    UIBarButtonItem *itme = [[UIBarButtonItem alloc]initWithTitle:@"TodyRecord" style:UIBarButtonItemStyleDone target:self action:@selector(TodayRecordController)];
    
    
    self.navigationItem.rightBarButtonItem = itme;
    
}

-(void)TodayRecordController{
    TCMtodayRecordController *TRV = [[TCMtodayRecordController alloc]init];
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
    //@[@"当前时间",@"复习内容",@"复习内容",@"复习内容",@"复习内容",@"复习内容",@"复习内容",@"复习内容",@"复习内容",@"复习内容",@"复习内容",@"复习内容"];
    for (int i = 0; i < 12; i++) {
        if (i == 0) {
            [self.titleArray addObject:@"1 / 当前"];
        }else{
            [self.titleArray addObject:[NSString stringWithFormat:@"%d / 复习内容",i+1]];
        }
    }
    
    self.clickArray = [NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0, nil];
    
    // 间隔时间: @[@(1),@(2),@(4),@(7),@(15),@(30),@(60),@(100),@(180)];
    self.levelArray = @[
                        @"间隔:0 天 \n重要性: 1 级\n策略: 快速回忆 ",
                        @"间隔:1 天\n重要性: 1 级\n策略: 快速回忆 ",
                        @"间隔:2 天\n重要性: 1 级\n策略: 快速回忆 ",
                        @"间隔:4 天\n重要性: 1 级\n策略: 快速回忆 ",
                        @"间隔:7 天\n重要性: 2 级\n策略: 仔细回忆+原始笔记",
                        @"间隔:15 天\n重要性: 2 级\n策略: 仔细回忆+原始笔记",
                        @"间隔:22 天\n重要性: 2 级\n策略: 仔细回忆+原始笔记",
                        @"间隔:30 天\n重要性: 3 级\n策略: 仔细回忆+思考资料 ",
                        @"间隔:45 天\n重要性: 3 级\n策略: 仔细回忆+思考资料 ",
                        @"间隔:60 天\n重要性: 3 级\n策略: 仔细回忆+思考资料 ",
                        @"间隔:100 天\n重要性: 3 级\n策略: 仔细回忆+思考资料 ",
                        @"间隔:180 天\n重要性: 3 级\n策略: 仔细回忆+思考资料 "
                        ];
    
    TCMTimeCaculater *tiemr = [TCMTimeCaculater sharedManager];
    self.descArray = [tiemr CaculateEbbinTimeFromNow];
    
    //设置 header & footer
    TCMTodayAimHeader *header = [[NSBundle mainBundle]loadNibNamed:@"TCMTodayAimHeader" owner:self options:nil].lastObject;
    
    TCMTodayAimFooter *footer = [[NSBundle mainBundle]loadNibNamed:@"TCMTodayAimFooter" owner:self options:nil].lastObject;
    
    self.customTableView.tableHeaderView = header;
    self.customTableView.tableFooterView = footer;
    
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

#pragma mark >>>>>>>>>> 印象笔记废弃代码

-(void)ENDiscardMethod{
    
    TCMNetWorkManager *manager = [[TCMNetWorkManager alloc]init];
    [manager GET_URL:@"http://www.baidu.com" PARA:nil info:nil success:^(id result) {
        
    } failure:^(NSDictionary *errorInfo) {
        
    }];
    
#pragma mark >>>>>>>>>> Demo 开始
    
    //oAuth
    
    //    https://app.yinxiang.com./oauth?
    //    oauth_callback=http://www.foo.com //回调地址, 测试时可以使用 local
    //    &oauth_consumer_key=sample-api-key-4121 //AppKey
    //    &oauth_nonce=3166905818410889691
    //    &oauth_signature=T0+xCYjTiyz7GZiElg1uQaHGQ6I=
    //    &oauth_signature_method=HMAC-SHA1
    //    &oauth_timestamp=1429565574
    //    &oauth_version=1.0
    
    
    
    
    
    NSString *storeUrl = @"https://www.yinxiang.com/shard/s1/notestore";
    NSString *storeUrlProduct = @"https://www.evernote.com//shard/s1/notestore";
    
    
    [ENSession setSharedSessionDeveloperToken:EverNoteToken noteStoreUrl:NoteStoreURL];
    __block ENNotebook *book;
    ENSession *everSession = [ENSession sharedSession];
    [everSession listNotebooksWithCompletion:^(NSArray<ENNotebook *> * _Nullable notebooks, NSError * _Nullable listNotebooksError) {
        book = notebooks.lastObject;
        
        //当前两个结果, 实际应该是三个结果
        //系统反映缓慢
        
    }];
    
    ENNote *note = [[ENNote alloc]init];
    ENNoteContent *content = [ENNoteContent noteContentWithString:@"阿拉基锅里加两个为骄傲了日记里"];
    note.title = @"0416Demo";
    note.content = content;
    [everSession uploadNote:note notebook:nil completion:^(ENNoteRef * _Nullable noteRef, NSError * _Nullable uploadNoteError) {
        
    }];
    
    [everSession findNotesWithSearch:nil inNotebook:nil orScope:ENSessionSearchScopePersonal sortOrder:ENSessionSortOrderNormal maxResults:NSIntegerMax completion:^(NSArray<ENSessionFindNotesResult *> * _Nullable findNotesResults, NSError * _Nullable findNotesError) {
        
        //当前一个结果, 实际应该是三个到四个结果
        //系统反映缓慢
        
    }];
    
    
    //    ENNote *note = [[ENNote alloc]init];
    //    note.title = @"啦啦啦测试";
    //    [everSession uploadNote:note notebook:book completion:^(ENNoteRef * _Nullable noteRef, NSError * _Nullable uploadNoteError) {
    //
    //    }];
    
    //    [everSession authenticateWithViewController:self preferRegistration:YES completion:^(NSError * _Nullable authenticateError) {
    //
    //    }];
    
    //    [everSession findNotesWithSearch:[ENNoteSearch noteSearchWithSearchString:@"2018"]
    //                                        inNotebook:nil
    //                                           orScope:ENSessionSearchScopeAll
    //                                         sortOrder:ENSessionSortOrderRecentlyCreated
    //                                        maxResults:20
    //                                        completion:^(NSArray * findNotesResults, NSError * findNotesError) {
    //                                            if (findNotesResults) {
    //                                                for (ENSessionFindNotesResult * result in findNotesResults) {
    //                                                    // Each ENSessionFindNotesResult has a noteRef along with other important metadata.
    //                                                    NSLog(@"Found note with title: %@", result.title);
    //                                                }
    //                                            }
    //                                        }];
    //
    
    //    ENUserStoreClient *userStore = [[ENUserStoreClient alloc]init];
    //    ENNoteStoreClient *noteStore = [[ENNoteStoreClient alloc]init];
    //
    //
    //    [noteStore listNotebooksWithCompletion:^(NSArray<EDAMNotebook *> * _Nullable notebooks, NSError * _Nullable error) {
    //
    //    }];
    
    
}


@end
