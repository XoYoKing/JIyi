//
//  CustomDateView.m
//  TableView
//
//  Created by apple on 15/11/14.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "CustomDateView.h"

@implementation CustomDateView




- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    self.dateView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 300)];
    //self.dateView.datePickerMode = UIDatePickerModeDateAndTime;
    [self addSubview:self.dateView];
    
    self.btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btn1.frame = CGRectMake(0, 0, kWidth*0.2, kWidth*0.1);
    [self.btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [self addSubview:self.btn1];
    
    self.btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btn2.frame = CGRectMake(kWidth-kWidth*0.2, 0, 80, 35);
    [self.btn2 setTitle:@"确定" forState:UIControlStateNormal];
    [self addSubview:self.btn2];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-kWidth*0.55, 0, kWidth*0.2, kWidth*0.1)];
    label.text = @"日期";
    [self addSubview:label];
    
    
    
}



    





@end
