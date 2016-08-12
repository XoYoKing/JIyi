//
//  CustomCell.h
//  TableView
//
//  Created by apple on 15/11/14.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *scheduleLabel;
@property (nonatomic,strong)UILabel *dateLabel;
@end
