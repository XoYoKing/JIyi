//
//  EditTableViewController.m
//  TableView
//
//  Created by apple on 15/11/14.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "EditTableViewController.h"
#import "CustomDateView.h"



@interface EditTableViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)CustomDateView *dateView;
@property (nonatomic,strong)CustomDateView *dateView1;
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)NSString *dateStr;
@property (nonatomic,strong)NSString *timeStr;
@property (nonatomic,strong)UILabel *dateLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILocalNotification *local;
@property (nonatomic,strong)NSDate *localDate;
@property (nonatomic,assign)NSCalendarUnit aaa;
@property (nonatomic,strong)UILabel *cycleLabel;
@property (nonatomic,strong)NSString *localDateStr;
@property (nonatomic,strong)NSString *remindState;
@property (nonatomic,strong)NSTimer *timer;
@end
static NSString *const cellID = @"ss";
@implementation EditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加日程";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-300)];
    view.backgroundColor = [UIColor colorWithWhite:0.276 alpha:0.3];
    self.backView = view;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
    self.aaa = 1;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.image = [UIImage imageNamed:@"beijingnb"];
    
    self.tableView.backgroundView = (UIView *)imageView;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //[textField resignFirstResponder];
    
    return YES;
}



- (void)rightAction:(UIBarButtonItem *)sender{
    NSLog(@"%@",self.dateStr);
    if (self.dateLabel.text.length == 0||self.textField.text.length == 0||self.timeLabel.text.length == 0) {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"日程或日期不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:action1];
        [alertVC addAction:action2];
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }else{
        Schedule *schedule = [Schedule new];
        schedule.dateStr = self.dateStr;
        schedule.timeStr = self.timeStr;
        schedule.infoStr = self.textField.text;
        schedule.isRemind = self.remindState;
        [[ScheduleSQL shareManger]insertSchedule:schedule];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 1;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.layer.cornerRadius = 5.f;
    cell.layer.masksToBounds = YES;
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = view;
    if (indexPath.section == 0) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(50, 0, [UIScreen mainScreen].bounds.size.width-50, 40)];
        textField.layer.cornerRadius = 5.f;
        textField.layer.masksToBounds = YES;
        textField.adjustsFontSizeToFitWidth = YES;
        textField.placeholder = @"请输入日程";
        //textField.keyboardType
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 32, 32)];
        image.image = [UIImage imageNamed:@"bianji"];
        
        [cell addSubview:image];
        textField.delegate = self;
        self.textField = textField;
        
        [cell addSubview:self.textField];
        cell.backgroundColor = [UIColor colorWithWhite:0.053 alpha:0.05];
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, [UIScreen mainScreen].bounds.size.width-50, 40)];
            label.layer.cornerRadius = 5.f;
            label.layer.masksToBounds = YES;
            //   label.text = @"请选择日期";
            label.textColor = [UIColor blueColor];
            self.dateLabel = label;
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
            image.image = [UIImage imageNamed:@"riqi"];
            
            [cell addSubview:image];
            [cell addSubview:label];
            cell.backgroundColor = [UIColor colorWithWhite:0.053 alpha:0.05];
        }else{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, [UIScreen mainScreen].bounds.size.width-50, 40)];
            label.layer.cornerRadius = 5.f;
            label.layer.masksToBounds = YES;
            label.textColor =[UIColor blueColor];
            // label.text = @"请选择时间";
            self.timeLabel = label;
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 32, 32)];
            image.image = [UIImage imageNamed:@"naozhong"];
            
            [cell addSubview:image];
            [cell addSubview:label];
            cell.backgroundColor = [UIColor colorWithWhite:0.053 alpha:0.05];
        }
    }else if (indexPath.section == 2){
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 28, 28)];
        image.image = [UIImage imageNamed:@"chongfu"];
        [cell addSubview:image];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, [UIScreen mainScreen].bounds.size.width-50, 40)];
        label.layer.cornerRadius = 5.f;
        label.layer.masksToBounds = YES;
        label.textColor =[UIColor blueColor];
        label.text = @"重复";
        self.cycleLabel = label;
        [cell addSubview:label];
        cell.backgroundColor = [UIColor colorWithWhite:0.053 alpha:0.05];
        return cell;
        
    }else if (indexPath.section == 3){
        UISwitch *remindSwitch = [[UISwitch alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 3, 35, 35)];
        [remindSwitch addTarget:self action:@selector(remindSwitch:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:remindSwitch];
        cell.backgroundColor = [UIColor colorWithWhite:0.053 alpha:0.05];
        cell.textLabel.text = @"         指定日期提醒我";
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 28, 28)];
        image.image = [UIImage imageNamed:@"tixing"];
        [cell addSubview:image];
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = view;
    }
    return cell;
}

#pragma mark -- 回收键盘 --

#pragma mark -- 提醒 --
- (void)remindSwitch:(UISwitch *)sender{
    
    if (sender.on == NO) {
        NSLog(@"ss");
        //通知的注销
        self.remindState = @"0";
        [[ScheduleSQL shareManger]changeUseIsJoinWithinfoStr:self.textField.text isRemind:@"0"];
        UIApplication *app = [UIApplication sharedApplication];
        //获取本地推送数组
        NSArray *localArr = [app scheduledLocalNotifications];
        //声明本地通知对象
        // UILocalNotification *localNotification;
        if (localArr) {
            for (UILocalNotification *localti in localArr) {
                NSDictionary *dict = localti.userInfo;
                if (dict) {
                    
                    NSString *dateAndTimeStr = [NSString stringWithFormat:@"%@-%@",self.dateStr,self.timeStr];
                    NSString *inKey = [dict objectForKey:self.textField.text];
                    NSLog(@"asd%@",inKey);
                    if ([inKey isEqualToString:dateAndTimeStr]) {
                        [[UIApplication sharedApplication] cancelLocalNotification:localti];
                        NSLog(@"删除成功");
                    }
                }
            }
        }
        
    }else{
        //添加通知
        //根据字符串获取时间
        self.remindState = @"1";
        [[ScheduleSQL shareManger]changeUseIsJoinWithinfoStr:self.textField.text isRemind:@"1"];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        NSDateFormatter *format=[[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *fromdate=[format dateFromString:self.localDateStr];
        self.localDate = fromdate;
        NSLog(@"%ld",self.aaa);
        NSLog(@"oooo%@",self.localDate);
        CGFloat verson = [[UIDevice currentDevice].systemVersion floatValue];
        if (verson>=8.0) {
            //初始化推送
            NSDateFormatter *formtter1 = [[NSDateFormatter alloc]init];
            [formtter1 setDateFormat:@"yyyy"];
            NSString *yearStr = [formtter1 stringFromDate:self.localDate];
            NSInteger year = [yearStr integerValue];
            NSDateFormatter *formtter2 = [[NSDateFormatter alloc]init];
            [formtter2 setDateFormat:@"MM"];
            NSString *monthStr = [formtter2 stringFromDate:self.localDate];
            NSInteger month = [monthStr integerValue];
            
            NSDateFormatter *formtter3 = [[NSDateFormatter alloc]init];
            [formtter3 setDateFormat:@"dd"];
            NSString *dayStr = [formtter3 stringFromDate:self.localDate];
            NSInteger day = [dayStr integerValue];
            
            NSDateFormatter *formtter4 = [[NSDateFormatter alloc]init];
            [formtter4 setDateFormat:@"HH"];
            NSString *hourStr = [formtter4 stringFromDate:self.localDate];
            NSInteger hour = [hourStr integerValue];
            
            NSDateFormatter *formtter5 = [[NSDateFormatter alloc]init];
            [formtter5 setDateFormat:@"mm"];
            NSString *minuteStr = [formtter5 stringFromDate:self.localDate];
            NSInteger minute = [minuteStr integerValue];
            
            NSDateComponents *components = [[NSDateComponents alloc]init];
            components.year = year;
            components.month = month;
            components.day = day;
            components.hour = hour;
            components.minute = minute;
            components.second = 0;
            components.timeZone = [NSTimeZone defaultTimeZone];
            NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
            NSLog(@"llllllll%@",date);
            
            self.local = [[UILocalNotification alloc]init];
            //设置发送的时间
            self.local.fireDate = date;
            //设置时区
            self.local.timeZone = [NSTimeZone defaultTimeZone];
            //设置重复次数
            self.local.repeatInterval = self.aaa;
            //设置推送的内容
            self.local.alertBody = self.textField.text;
            //设置推送标题
            self.local.alertTitle = @"日程";
            //设置推送的声音
            self.local.soundName = UILocalNotificationDefaultSoundName;
            //点击推送通知时，启动app图片
            self.local.alertLaunchImage = @"";
            //在锁屏时显示的标题
            self.local.alertAction = @"滑动解锁";
            //app图标数字
            self.local.applicationIconBadgeNumber +=1;
            NSLog(@"asdffsga%ld",self.local.applicationIconBadgeNumber);
            //其它信息
            NSString *dateAndTimeStr = [NSString stringWithFormat:@"%@-%@",self.dateStr,self.timeStr];
            self.local.userInfo = [NSDictionary dictionaryWithObject:dateAndTimeStr forKey:self.textField.text];
            self.local.category = @"ccc";
            
        }else{
            
        }
        
        
        [[UIApplication sharedApplication] scheduleLocalNotification:self.local];
        
        
    }
    
}
#pragma -- 定时器 键盘回收--

- (void)timerAction:(NSTimer *)sender{
    CustomDateView *dateView = [CustomDateView new];
    self.dateView = dateView;
    self.dateView.dateView.datePickerMode = UIDatePickerModeDate;
    self.dateView.backgroundColor = [UIColor colorWithWhite:0.990 alpha:0.5];
    
    [self.view addSubview:self.dateView];
    [self.dateView.btn1 addTarget:self action:@selector(btn1Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.dateView.btn2 addTarget:self action:@selector(btn2Action:) forControlEvents:UIControlEventTouchUpInside];
    self.dateView.alpha = 1.0;
    self.dateView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-300, [UIScreen mainScreen].bounds.size.width, 300);
    self.key = YES;
    
    [self.view addSubview:self.backView];
    
    NSLog(@"fafsf");
    [self.timer invalidate];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            if (self.key == NO) {
                
                
                [self.textField resignFirstResponder];
                self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
                
                
            }
        }
        else if(indexPath.row == 1){
            if (self.key == NO) {
                CustomDateView *dateView = [CustomDateView new];
                self.dateView1 = dateView;
                self.dateView1.backgroundColor = [UIColor colorWithWhite:0.990 alpha:0.5];
                self.dateView1.dateView.datePickerMode = UIDatePickerModeTime;
                [self.view addSubview:self.dateView1];
                [self.dateView1.btn1 addTarget:self action:@selector(btn3Action:) forControlEvents:UIControlEventTouchUpInside];
                [self.dateView1.btn2 addTarget:self action:@selector(btn4Action:) forControlEvents:UIControlEventTouchUpInside];
                self.dateView1.alpha = 1.0;
                self.dateView1.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-300, [UIScreen mainScreen].bounds.size.width, 300) ;
                self.key = YES;
                [self.view addSubview:self.backView];
            }
        }
    }
    else if (indexPath.section == 2){
        
        NSLog(@"fsf");
        if (indexPath.row == 0) {
#warning alertView --弹出需要时间，为什么？--
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"重复方式" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"每天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.cycleLabel.text = @"每天";
                self.aaa =(1UL << 4);
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"每周" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.aaa = (1UL << 9);
                self.cycleLabel.text = @"每周";
            }];
            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"每月" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.aaa = (1UL << 3);
                self.cycleLabel.text = @"每月";
            }];
            UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"每年" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.aaa = (1UL << 2);
                self.cycleLabel.text = @"每年";
                
            }];
            UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"一次" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.aaa = 1;
                self.cycleLabel.text = @"一次";
            }];
            UIAlertAction *action6 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertVC addAction:action1];
            [alertVC addAction:action2];
            [alertVC addAction:action3];
            [alertVC addAction:action4];
            [alertVC addAction:action5];
            [alertVC addAction:action6];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }
}
- (void)btn1Action:(UIButton *)sender{
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.btn1.alpha = 0.0;
        self.dateView.btn2.alpha = 0.0;
        self.dateView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 300);
        self.key = NO;
    } completion:^(BOOL finished) {
        [self.dateView removeFromSuperview];
        [self.dateView.btn1 removeFromSuperview];
        [self.dateView.btn2 removeFromSuperview];
        [self.backView removeFromSuperview];
        
    }];
}
- (void)btn2Action:(UIButton *)sender{
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.btn1.alpha = 0.0;
        self.dateView.btn2.alpha = 0.0;
        self.dateView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 300);
        self.key = NO;
        
        UIDatePicker *datePicker = self.dateView.dateView;
        NSDate *date = datePicker.date;
        // self.localDate = [NSDate date];
        //  self.localDate = date;
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        //_label.text = [format stringFromDate:date];
        self.dateStr = [format stringFromDate:date];
        self.dateLabel.text = self.dateStr;
        NSLog(@"vvvv%@",self.dateStr);
        
        
        
        
        
        
    } completion:^(BOOL finished) {
        [self.dateView removeFromSuperview];
        [self.dateView.btn1 removeFromSuperview];
        [self.dateView.btn2 removeFromSuperview];
        [self.backView removeFromSuperview];
    }];
}

- (void)btn3Action:(UIButton *)sender{
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView1.btn1.alpha = 0.0;
        self.dateView1.btn2.alpha = 0.0;
        self.dateView1.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 300);
        self.key = NO;
    } completion:^(BOOL finished) {
        
        [self.dateView1 removeFromSuperview];
        [self.dateView1.btn1 removeFromSuperview];
        [self.dateView1.btn2 removeFromSuperview];
        [self.backView removeFromSuperview];
    }];
    
}

- (void)btn4Action:(UIButton *)sender{
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView1.btn1.alpha = 0.0;
        self.dateView1.btn2.alpha = 0.0;
        self.dateView1.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 300);
        self.key = NO;
        
        UIDatePicker *datePicker = self.dateView1.dateView;
        NSDate *date = datePicker.date;
        // self.localDate = date;
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"HH:mm"];
        
        //_label.text = [format stringFromDate:date];
        self.timeStr = [format stringFromDate:date];
        self.timeLabel.text = self.timeStr;
        NSLog(@"%@",self.timeStr);
        
        NSDateFormatter *form = [NSDateFormatter new];
        [form setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.localDateStr = [form stringFromDate:date];
        NSLog(@"2222%@",self.localDateStr);
        
        
        
        
        
        
    } completion:^(BOOL finished) {
        [self.dateView1 removeFromSuperview];
        [self.dateView1.btn1 removeFromSuperview];
        [self.dateView1.btn2 removeFromSuperview];
        [self.backView removeFromSuperview];
    }];
    
}


@end
