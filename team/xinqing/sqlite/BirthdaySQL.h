//
//  BirthdaySQL.h
//  team
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Birthday.h"
@interface BirthdaySQL : NSObject

+(instancetype)shareBirthdayManger;

//打开数据库
-(void)openDB;

//关闭
-(void)closeDB;


//创建表
-(void)createTable;


//增
-(void)insertBirthday:(Birthday *)birthday;


//清空表
-(void)clearTable;

//删
-(void)deleteScheduleWithintroLabel:(NSString *)introLabel;


//输出全部
-(NSMutableArray *)selectAllBirthday;


//修改
-(void)changeUseIsJoinWithintroLabel:(NSString *)introLabel remindState:(NSString *)remindState;






@end
