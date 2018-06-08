//
//  TCMTodayAimCell.m
//  TCMemory
//
//  Created by YangTianCi on 2018/4/12.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import "TCMTodayAimCell.h"

@implementation TCMTodayAimCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tagCount = 0;
}

-(void)setTagCount:(NSInteger)tagCount{
    _tagCount = tagCount;
    self.tagLabel.text = [NSString stringWithFormat:@"已浏览次数: %zd",_tagCount];
    
}


@end
