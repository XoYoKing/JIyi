//
//  BirthdayViewCell.h
//  team
//
//  Created by apple on 15/11/12.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BirthdayViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *introduceLabel; //生日具体信息显示
@property (nonatomic,strong)UILabel *remindLabel;
@property (nonatomic,strong)UISwitch *remindSwitch;  //提醒
@end
