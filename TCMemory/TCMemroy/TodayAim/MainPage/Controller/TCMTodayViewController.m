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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //网页版不可登录
//    TCMEverNoteController *evernote = [[TCMEverNoteController alloc]init];
//    evernote.webUrl = @"https://app.yinxiang.com/Home.action";
//    [self.navigationController pushViewController:evernote animated:YES];
    
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
