//
//  TCMTimeCaculater.h
//  TCMemory
//
//  Created by YangTianCi on 2018/4/12.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCMTimeCaculater : NSObject

+(instancetype)sharedManager;

-(NSArray*)CaculateEbbinTimeFromNow;

-(NSArray*)CaculateEbbinTimeWithDate:(NSDate*)date;

@end
