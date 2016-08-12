//
//  AddBirthdayView.m
//  team
//
//  Created by apple on 15/11/16.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "AddBirthdayView.h"

@implementation AddBirthdayView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
   // imageView.backgroundColor = [UIColor purpleColor];
    imageView.image = [UIImage imageNamed:@""];
    [self addSubview:imageView];

    
    self.peopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidth*0.1, kWidth*0.3, kWidth-2*kWidth*0.1, 40)];
    self.peopleLabel.text = @"请输入寿星的姓名，并选择日期";
    self.peopleLabel.textAlignment = NSTextAlignmentCenter;
    self.peopleLabel.layer.borderWidth = 1.0f;
    self.peopleLabel.layer.borderColor = [UIColor purpleColor].CGColor;
    self.peopleLabel.layer.cornerRadius = 5.f;
    self.peopleLabel.layer.masksToBounds = YES;
    [self addSubview:self.peopleLabel];
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(kWidth*0.1, self.peopleLabel.frame.origin.y+kWidth*0.13, kWidth*0.8, 35)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = @"请输入";
    [self addSubview:self.textField];
    
    self.finishBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.finishBtn.frame = CGRectMake(kWidth*0.35, kHeight*0.88, self.textField.frame.size.width, 40);
    [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self addSubview:self.finishBtn];
    
    self.view = [[UIView alloc]initWithFrame:CGRectMake(kWidth*0.1, self.peopleLabel.frame.origin.y+kWidth*0.25, kWidth-2*kWidth*0.1,kWidth-2*kWidth*0.1)];
   // self.view.backgroundColor = [UIColor redColor];
    self.view.layer.cornerRadius = 5.f;
    self.view.layer.masksToBounds = YES;
    [self addSubview:self.view];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kWidth*0.12)];
    label.text = @"请选择日期";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, kWidth*0.12+5, self.view.frame.size.width, self.view.frame.size.height-label.frame.size.height-5)];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    [self.view addSubview:self.datePicker];
    
    
}





@end
