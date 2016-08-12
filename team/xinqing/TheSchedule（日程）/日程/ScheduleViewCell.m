//
//  ScheduleViewCell.m
//  team
//
//  Created by apple on 15/11/16.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "ScheduleViewCell.h"

@implementation ScheduleViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(5, 5,kWidth-10, kHeight*0.4)];
  //  self.textView.backgroundColor = [UIColor redColor];
    self.textView.layer.cornerRadius = 5.f;
    self.textView.font = kFont_1;
    self.textView.layer.masksToBounds = YES;
    self.textView.userInteractionEnabled = NO;
    self.textView.editable = NO;
    self.textView.layer.borderWidth = 0.5f;
    self.textView.layer.borderColor = [[UIColor grayColor]CGColor];
    self.textView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.textView];
    
    self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-kWidth*0.45, kHeight*0.43,kWidth*0.4, 35)];
   // self.dateLabel.backgroundColor = [UIColor redColor];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.dateLabel];
    
    
    
}

- (void)setSchedule:(Schedule *)schedule{
    _schedule = schedule;
    self.textView.text = schedule.infoStr;
    self.dateLabel.text = schedule.dateStr;
}




@end
