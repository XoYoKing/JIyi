//
//  CustomTableViewController.m
//  TableView
//
//  Created by apple on 15/11/13.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "CustomTableViewController.h"
#import "CustomCell.h"
#import "EditTableViewController.h"
@interface CustomTableViewController ()
@property (nonatomic,strong)UITextView *textField;

@end
static NSString *const cellID = @"dd";
@implementation CustomTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"日程";
    
    
    self.tableView.bounces = NO;
    
    
    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:cellID];
 
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
       imageView.image = [UIImage imageNamed:@"beijingshuiyin"];
 
    self.tableView.backgroundView = (UIView *)imageView;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
    UIBarButtonItem *back = [[UIBarButtonItem alloc]init];
    
    back.title = @"返回";
    self.navigationItem.backBarButtonItem = back;
    
    if ([[ScheduleSQL shareManger]selectAllSchedule].count == 0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有提醒" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"知道啦" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"去添加"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
            [self.navigationController pushViewController:[EditTableViewController new] animated:YES];
            
        }];
        
        
        [alertVC addAction:action1];
        [alertVC addAction:action2];
        [self presentViewController:alertVC animated:YES completion:nil];
    }

    
 
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark -- 添加日程 --
- (void)rightAction:(UIBarButtonItem *)sender{
    
    [self.navigationController pushViewController:[EditTableViewController new] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth*0.13;
}
#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

     return [[ScheduleSQL shareManger] selectAllSchedule].count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = view;
    Schedule *schedule = [[ScheduleSQL shareManger] selectAllSchedule][indexPath.section];
    cell.scheduleLabel.text = schedule.infoStr;
    NSString *intoDateStr = [NSString stringWithFormat:@"%@--%@",schedule.dateStr,schedule.timeStr];
    cell.dateLabel.text = intoDateStr;
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
    
}

#pragma mark -- 头部视图 --


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
 
    return view;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return UITableViewCellEditingStyleDelete;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ScheduleInfoTableViewController *editVC = [ScheduleInfoTableViewController new];
    editVC.schedule = [[ScheduleSQL shareManger] selectAllSchedule][indexPath.row];
    editVC.index = indexPath.row;
    [self.navigationController pushViewController:editVC animated:YES];
    
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
       

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"该日程将会被永久删除" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"删除日程" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //数据删除
            NSArray *array = [[ScheduleSQL shareManger] selectAllSchedule];
            Schedule *schedule = array[indexPath.section];
            NSLog(@"rrrr%@",schedule.infoStr);
            [[ScheduleSQL shareManger] deleteScheduleWithinfoStr:schedule.infoStr];
            //        //更新UI
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
            [tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
            
            UIApplication *app = [UIApplication sharedApplication];
            //获取本地推送数组
            NSArray *localArr = [app scheduledLocalNotifications];
            //声明本地通知对象
            // UILocalNotification *localNotification;
            if (localArr) {
                for (UILocalNotification *localti in localArr) {
                    NSDictionary *dict = localti.userInfo;
                    if (dict) {
                        
                        NSString *dateAndTimeStr = [NSString stringWithFormat:@"%@-%@",schedule.dateStr,schedule.timeStr];
                        NSString *inKey = [dict objectForKey:self.textField.text];
                       
                        if ([inKey isEqualToString:dateAndTimeStr]) {
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
        
        NSMutableArray *array = [[ScheduleSQL shareManger]selectAllSchedule];
        
        Schedule *schedule = [array objectAtIndex:indexPath.section];
        [array removeObjectAtIndex:indexPath.section];
        [array insertObject:schedule atIndex:0];
        
        [[ScheduleSQL shareManger] clearTable];
        for (Schedule *schedule in array) {
            [[ScheduleSQL shareManger] insertSchedule:schedule];
        }
        
        [self.tableView moveSection:indexPath.section toSection:0];
        [self setEditing:NO animated:NO];
    }];
    collectRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    return  @[deleteRowAction,collectRowAction];
}






@end
