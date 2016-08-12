//
//  CustomCell.m
//  TableView
//
//  Created by apple on 15/11/14.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(kWidth*0.1, 0, [UIScreen mainScreen].bounds.size.width-kWidth*0.13, kWidth*0.13)];
    self.backView.layer.cornerRadius = 5.f;
    self.backView.layer.masksToBounds = YES;
    self.backView.backgroundColor = [UIColor clearColor];
   // [self.contentView addSubview:self.backView];
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, -5, 13, kWidth*0.16)];
    self.imgView.image = [UIImage imageNamed:@"zhou"];
    [self.contentView addSubview:self.imgView];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.backView.frame];
    imageView.image = [UIImage imageNamed:@"kuang"];
    [self.contentView addSubview:imageView];
    
    [imageView addSubview:self.backView];
    
    
    self.scheduleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, [UIScreen mainScreen].bounds.size.width-kWidth*0.18,25)];

     [self.backView addSubview:self.scheduleLabel];
    
    self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, kWidth*0.08, [UIScreen mainScreen].bounds.size.width-kWidth*0.18, 15)];
         self.dateLabel.font = kFont;
    [self.backView addSubview:self.dateLabel];
    
    
    
    
    
}



@end
