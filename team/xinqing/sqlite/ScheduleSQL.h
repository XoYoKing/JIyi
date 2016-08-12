//
//  ScheduleSQL.h
//  team
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Schedule.h"
@interface ScheduleSQL : NSObject


+(instancetype)shareManger;

//打开数据库
-(void)openDB;

//关闭
-(void)closeDB;


//创建表
-(void)createTable;
//清空表
-(void)clearTable;

//增
-(void)insertSchedule:(Schedule *)schedule;

//删
-(void)deleteScheduleWithinfoStr:(NSString *)infoStr;


//输出全部
-(NSMutableArray *)selectAllSchedule;


//修改
-(void)changeUseIsJoinWithinfoStr:(NSString *)infoStr isRemind:(NSString *)isRemind;






@end
