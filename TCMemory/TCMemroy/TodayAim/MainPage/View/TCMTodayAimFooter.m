//
//  TCMTodayAimFooter.m
//  TCMemory
//
//  Created by YangTianCi on 2018/6/12.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import "TCMTodayAimFooter.h"

@interface TCMTodayAimFooter()

@property (weak, nonatomic) IBOutlet UILabel *BeginTime;

@property (nonatomic, strong) NSDate *beginDate;

@end

@implementation TCMTodayAimFooter


-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.beginDate = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"hh 时 mm 分";
    NSString *dateString = [formatter stringFromDate:self.beginDate];
    
    self.BeginTime.text = [NSString stringWithFormat:@"BeginTime: %@", dateString];
    
}



@end
