//
//  TCMTodayAimCell.h
//  TCMemory
//
//  Created by YangTianCi on 2018/4/12.
//  Copyright © 2018年 www.YangTianCi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCMTodayAimCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (nonatomic, assign) NSInteger tagCount;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@property (weak, nonatomic) IBOutlet UILabel *levelLabel;


@end
