//
//  TCMTimeCaculater.m
//  TCMemory
//
//  Created by YangTianCi on 2018/4/12.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import "TCMTimeCaculater.h"

#define kTMargin_1d kOneDay * 1
#define kTMargin_2d kOneDay * 2
#define kTMargin_4d kOneDay * 4
#define kTMargin_7d kOneDay * 7
#define kTMargin_15d kOneDay * 15
#define kTMargin_22d kOneDay * 22
#define kTMargin_30d kOneDay * 30
#define kTMargin_45d kOneDay * 45
#define kTMargin_60d kOneDay * 60
#define kTMargin_100d kOneDay * 100
#define kTMargin_180d kOneDay * 180
//此处计算的是时间间隔

@interface TCMTimeCaculater()

@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation TCMTimeCaculater

#pragma mark >>>>>>>>>> 创建单例对象

static id _instance;
+(instancetype)sharedManager
{
    if(_instance == nil)
    {
        @synchronized(self)
        {
            if(_instance == nil)
            {
                _instance = [[self alloc]init];
            }
        }
    }
    return _instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    if(_instance == nil)
    {
        @synchronized(self)
        {
            if(_instance == nil)
            {
                _instance = [super allocWithZone:zone];
            }
        }
    }
    return _instance;
}

-(instancetype)copyWithZone:(NSZone *)zone
{
    return _instance;
}

#pragma mark >>>>>>>>>> 根据当前时间, 计算当日应复习的之前的时间段

-(NSArray*)CaculateEbbinTimeFromNow{
    NSArray *resultArray = [self CaculateEbbinTimeWithDate:[NSDate date]];
    return resultArray;
}

-(NSArray*)CaculateEbbinTimeWithDate:(NSDate*)date{

    self.formatter.dateFormat = @"yyyy-MM-dd";
    //计算当前时间并且转化为字符串
    NSDate *nowDate = date;
    NSString *nowString = [self.formatter stringFromDate:nowDate];
    
    //计算对应的时间间隔前的时间
    NSInteger oneDayInterval = kOneDay;
    NSArray *intervalNumber_temp = @[@(1),@(2),@(4),@(7),@(15),@(22),@(30),@(45),@(60),@(100),@(180)];
    NSMutableArray *resultIntervalArray = [NSMutableArray array];
    [resultIntervalArray addObject:nowString];
    for (NSNumber *number in intervalNumber_temp) {
        NSInteger intervalDay = [number integerValue];
        NSTimeInterval interval = oneDayInterval * intervalDay;
        NSDate *reviewDate = [NSDate dateWithTimeInterval:-interval sinceDate:date];
        NSString *resultString = [self.formatter stringFromDate:reviewDate];
        [resultIntervalArray addObject:resultString];
    }
    
    return resultIntervalArray;
}

-(NSDateFormatter *)formatter{
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc]init];
    }
    return _formatter;
}



// 自考专用
-(NSArray*)CaculateEbbinForSelfExam{
    
    self.formatter.dateFormat = @"yyyy-MM-dd";
    //计算当前时间并且转化为字符串
    NSDate *nowDate = [NSDate date];
    NSString *nowString = [self.formatter stringFromDate:nowDate];
    
    //计算对应的时间间隔前的时间
    NSInteger oneDayInterval = kOneDay;
    NSArray *intervalNumber_temp = @[@(1),@(2),@(4),@(7),@(15),@(22),@(30),@(45),@(60),@(90),@(120)];
    NSMutableArray *resultIntervalArray = [NSMutableArray array];
    [resultIntervalArray addObject:nowString];
    for (NSNumber *number in intervalNumber_temp) {
        NSInteger intervalDay = [number integerValue];
        NSTimeInterval interval = oneDayInterval * intervalDay;
        NSDate *reviewDate = [NSDate dateWithTimeInterval:-interval sinceDate:[NSDate date]];
        NSString *resultString = [self.formatter stringFromDate:reviewDate];
        
        [resultIntervalArray addObject:resultString];
    }
    
    return resultIntervalArray;
    
}




@end
