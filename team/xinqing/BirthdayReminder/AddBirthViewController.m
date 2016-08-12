//
//  AddBirthViewController.m
//  team
//
//  Created by apple on 15/11/12.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "AddBirthViewController.h"

@interface AddBirthViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)AddBirthdayView *addBirthView;
@end

@implementation AddBirthViewController

- (void)loadView{
    self.addBirthView = [AddBirthdayView new];
    self.view = self.addBirthView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithRed:241/255.0 green:168/255.0 blue:114/255.0 alpha:1];
    [self.addBirthView.finishBtn addTarget:self action:@selector(finishBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.title = @"添加生日";
    self.addBirthView.textField.delegate = self;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark -- finishBtn --

- (void)finishBtnAction:(UIButton *)sender{
    Birthday *birth = [Birthday new];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提醒" message:@"是否开启提醒" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)         {
        if (self.addBirthView.textField.text.length == 0) {
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请填写寿星名字~" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertVC addAction:action1];
            [self presentViewController:alertVC animated:YES completion:nil];
            
        }else{
        
        birth.remindState = @"0";
        
        birth.introLabel = self.addBirthView.textField.text;
        UIDatePicker *datePicker = self.addBirthView.datePicker;
        NSDate *date = datePicker.date;
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSLog(@"%@",date);
        NSLog(@"uuuuuuuuuuuuuu%@",birth.remindState);
        birth.dateBirth = [format stringFromDate:date];
        [[BirthdaySQL shareBirthdayManger] insertBirthday:birth];
       // [[BirthdayHelper sharedManager].mBirthdayArr addObject:birth];
        [self.navigationController popViewControllerAnimated:YES];
        }

    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIDatePicker *datePicker = self.addBirthView.datePicker;
        NSDate *date = datePicker.date;
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *string = [format stringFromDate:date];
        
        if (self.addBirthView.textField.text.length == 0) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入寿星名字" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertVC addAction:action1];
            [self presentViewController:alertVC animated:YES completion:nil];
        }else{
        
        birth.remindState = @"1";
        birth.introLabel = self.addBirthView.textField.text;
        NSLog(@"^^^^^^^^^^^^^^^^^%@",birth.remindState);
        
        birth.dateBirth = string;
        [[BirthdaySQL shareBirthdayManger] insertBirthday:birth];
        

        [self.navigationController popViewControllerAnimated:YES];
        }

    }];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
    

}





@end
