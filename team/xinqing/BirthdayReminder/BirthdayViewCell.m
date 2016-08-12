//
//  BirthdayViewCell.m
//  team
//
//  Created by apple on 15/11/12.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "BirthdayViewCell.h"

@implementation BirthdayViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    self.introduceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidth*0.03, 0, kWidth*0.55, kWidth*0.15)];
   // self.introduceLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.introduceLabel];
    
    self.remindLabel =[[UILabel alloc]initWithFrame:CGRectMake(self.introduceLabel.frame.origin.x+kWidth*0.55+5, 0, kWidth*0.2, kWidth*0.15)];
    self.remindLabel.text = @"提醒";
    self.remindLabel.textAlignment = NSTextAlignmentCenter;
  //  self.remindLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.remindLabel];
    
    self.remindSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(self.remindLabel.frame.origin.x+kWidth*0.2+kWidth*0.03,11, kWidth*0.2, kWidth*0.15)];
    self.remindSwitch.on = NO;
  //  self.remindSwitch.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.remindSwitch];
    
    
    
    
}

@end
