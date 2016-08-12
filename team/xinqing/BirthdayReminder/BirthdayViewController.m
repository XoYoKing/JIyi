//
//  BirthdayViewController.m
//  team
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "BirthdayViewController.h"
#import "Birthday.h"
@interface BirthdayViewController ()
@property (nonatomic,strong)NSDate *selectedDate;
@property (nonatomic,strong)NSString *dateString;
@property (nonatomic,strong)UILocalNotification *local;
@property (nonatomic,strong)NSDate *localDate;
@property (nonatomic,strong)UILabel *remindLabel;
@property (nonatomic,assign)BOOL switchState;
@property (nonatomic,strong)NSString *birthStr;
@property (nonatomic,strong)NSString *nameStr;

@end

@implementation BirthdayViewController

static NSString *const cellID = @"hh";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]init];
    
    back.title = @"返回";
    self.navigationItem.backBarButtonItem = back;
    

    
    //注册
    [self.tableView registerClass:[BirthdayViewCell class] forCellReuseIdentifier:cellID];
    //标题
    self.title = @"生日提醒";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPeopleBirth:)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"beijingshuiyin"];
    self.tableView.backgroundView = (UIView *)imageView;
    
    self.tableView.bounces = NO;
    
    if ([[BirthdaySQL shareBirthdayManger]selectAllBirthday].count == 0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"我知道你有好朋友哒" message:@"赶紧记下他的生日吧~" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道啦" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    

    
}


#pragma mark -- 添加生日，跳转 --

- (void)addPeopleBirth:(UIBarButtonItem *)sender{
    
    AddBirthViewController *addVC = [AddBirthViewController new];
    
    
    [self.navigationController pushViewController:addVC animated:YES ];
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}


- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return [[[BirthdaySQL shareBirthdayManger] selectAllBirthday] count];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BirthdayViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    [cell.remindSwitch addTarget:self action:@selector(remindSwitchAction:) forControlEvents:UIControlEventValueChanged];
    Birthday *birth = [[BirthdaySQL shareBirthdayManger] selectAllBirthday][indexPath.section];
    NSArray *str1 = [birth.dateBirth componentsSeparatedByString:@"-"];
    
    NSArray *str2 = [str1[2] componentsSeparatedByString:@" "];
    
    NSString *str = [NSString stringWithFormat:@"%@月-%@日",str1[1],str2[0]];
    NSString *string = [NSString stringWithFormat:@"%@  %@",birth.introLabel,str];
    
    cell.introduceLabel.text = string;
    self.nameStr = birth.introLabel;
       //时间的转换
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *fromdate=[format dateFromString:birth.dateBirth];
    NSLog(@"fromdate=%@",fromdate);
    
    
    
  
    self.localDate = fromdate;
   
    self.birthStr = birth.dateBirth;
    cell.backgroundColor = [UIColor clearColor];
    cell.remindLabel = self.remindLabel;
    NSLog(@"ttt%@",birth.remindState);
    if ([birth.remindState isEqualToString:@"0"]) {
        cell.remindSwitch.on = NO;
    }else if ([birth.remindState isEqualToString:@"1"]){
        cell.remindSwitch.on = YES;
        
    }
    
    if ([birth.remindState isEqualToString:@"1"]) {
        self.switchState = YES;
        [self remindPush];
    }
    
    
   
    return cell;
}


#pragma mark --  根据switch状态来触发通知 --
- (void)remindPush{
    
    
    if (self.switchState == YES) {
        //通知触发
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
            NSLog(@"uuuuu%@",date);
            
            // NSDate *date = [NSDate date];
            self.local = [[UILocalNotification alloc]init];
            //设置发送的时间
            self.local.fireDate = date;
            //设置时区
            self.local.timeZone = [NSTimeZone defaultTimeZone];
            //设置重复次数
            self.local.repeatInterval = kCFCalendarUnitYear;
            //设置推送的内容
            NSString *string = [NSString stringWithFormat:@"%@ 生日到啦~",self.nameStr];
            self.local.alertBody = string;
            //设置推送标题
            self.local.alertTitle = @"嘿嘿";
            //设置推送的声音
            self.local.soundName = UILocalNotificationDefaultSoundName;
            //点击推送通知时，启动app图片
            //self.local.alertLaunchImage = @"";
            //在锁屏时显示的标题
            self.local.alertAction = @"滑动解锁";
            //app图标数字
          
            self.local.applicationIconBadgeNumber +=1;
            //其它信息
            self.local.userInfo = [NSDictionary dictionaryWithObject:string forKey:self.nameStr];
            self.local.category = @"ccc";
            
        }else{
            
        }
        
        [[UIApplication sharedApplication] scheduleLocalNotification:self.local];
        
    }
    
    
    
    
    
}


- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth*0.15;
}

#pragma mark -- 删除 --

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        NSLog(@"fs");
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"该生日将会被永久删除" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"删除生日" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //数据删除
            NSArray *array = [[BirthdaySQL shareBirthdayManger] selectAllBirthday];
            Birthday *birth = array[indexPath.section];
            [[BirthdaySQL shareBirthdayManger] deleteScheduleWithintroLabel:birth.introLabel];
            //更新UI
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
            [tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
            
            //通知的注销
            UIApplication *app = [UIApplication sharedApplication];
            //获取本地推送数组
            NSArray *localArr = [app scheduledLocalNotifications];
            //声明本地通知对象
            
            if (localArr) {
                for (UILocalNotification *localti in localArr) {
                    NSDictionary *dict = localti.userInfo;
                    if (dict) {
                        NSString *inKey = [dict objectForKey:birth.introLabel];
                        NSLog(@"%@",inKey);
                        if ([inKey isEqualToString:birth.dateBirth]) {
                            [[UIApplication sharedApplication] cancelLocalNotification:localti];
                        }
                    }
                }
            }

        }];
        [alertController addAction:action2];
        [alertController addAction:action1];
        [self presentViewController:alertController animated:YES completion:^{
        }];
    }];
    deleteRowAction.backgroundColor = [UIColor redColor] ;
    //设置置顶按钮
    UITableViewRowAction *collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        NSMutableArray *array = [[BirthdaySQL shareBirthdayManger]selectAllBirthday];
        
        
        Birthday *birthday = [array objectAtIndex:indexPath.section];
        [array removeObjectAtIndex:indexPath.section];
        [array insertObject:birthday atIndex:0];
        
        [[BirthdaySQL shareBirthdayManger] clearTable];
        for (Birthday *birthday in array) {
            [[BirthdaySQL shareBirthdayManger] insertBirthday:birthday];
        }
        
        [self.tableView moveSection:indexPath.section toSection:0];
        [self setEditing:NO animated:NO];
    }];
    collectRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    return  @[deleteRowAction,collectRowAction];
}



#pragma mark -- 是否开启通知 --
- (void)remindSwitchAction:(UISwitch *)sender{
    if (sender.on == NO) {
        
        UITableViewCell *cell = (UITableViewCell *)sender.superview.superview;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
               Birthday *birth = [[BirthdaySQL shareBirthdayManger] selectAllBirthday][indexPath.section];
        
        [[BirthdaySQL shareBirthdayManger] changeUseIsJoinWithintroLabel:birth.introLabel remindState:@"0"];
       

        //通知的注销
        UIApplication *app = [UIApplication sharedApplication];
        //获取本地推送数组
        NSArray *localArr = [app scheduledLocalNotifications];
        //声明本地通知对象
       
        if (localArr) {
            for (UILocalNotification *localti in localArr) {
                NSDictionary *dict = localti.userInfo;
                if (dict) {
                    NSString *inKey = [dict objectForKey:birth.introLabel];
                    NSLog(@"%@",inKey);
                    if ([inKey isEqualToString:birth.dateBirth]) {
                        [[UIApplication sharedApplication] cancelLocalNotification:localti];
                    }
                }
            }
        }
    }else{
              UITableViewCell *cell = (UITableViewCell *)sender.superview.superview;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSLog(@"-----%ld",indexPath.section);
        
        Birthday *birth = [[BirthdaySQL shareBirthdayManger] selectAllBirthday][indexPath.section];
        [[BirthdaySQL shareBirthdayManger]changeUseIsJoinWithintroLabel:birth.introLabel remindState:@"1"];
        NSDateFormatter *format=[[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *fromdate=[format dateFromString:birth.dateBirth];
        self.localDate = fromdate;
       
        
        //添加通知
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
            
            
            self.local = [[UILocalNotification alloc]init];
            //设置发送的时间
            self.local.fireDate = date;
            //设置时区
            self.local.timeZone = [NSTimeZone defaultTimeZone];
            //设置重复次数
            self.local.repeatInterval = kCFCalendarUnitYear;
            //设置推送的内容
            NSString *string = [NSString stringWithFormat:@"%@的生日到啦~",birth.introLabel];
            self.local.alertBody = string;
            //设置推送标题
            self.local.alertTitle = @"嘿嘿";
            //设置推送的声音
            self.local.soundName = UILocalNotificationDefaultSoundName;
            //点击推送通知时，启动app图片
            self.local.alertLaunchImage = @"";
            //在锁屏时显示的标题
            //self.local.alertAction = @"滑动解锁";
            //app图标数字
           
            self.local.applicationIconBadgeNumber +=1;
            //其它信息
            self.local.userInfo = [NSDictionary dictionaryWithObject:birth.dateBirth forKey:birth.introLabel];
            self.local.category = @"ccc";
            
        }else{
            
        }
        
        [[UIApplication sharedApplication] scheduleLocalNotification:self.local];
        
    }
}

@end
