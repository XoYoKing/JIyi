//
//  ScheduleViewCell.h
//  team
//
//  Created by apple on 15/11/16.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleViewCell : UITableViewCell
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)Schedule *schedule;
@property (nonatomic,strong)UILabel *dateLabel;
@property (nonatomic,strong)UIButton *button;
@end
