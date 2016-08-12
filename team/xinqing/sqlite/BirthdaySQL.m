//
//  BirthdaySQL.m
//  team
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "BirthdaySQL.h"
#import <sqlite3.h>
@implementation BirthdaySQL


+(instancetype)shareBirthdayManger{
    static BirthdaySQL *dbManager = nil;
    
    if (nil == dbManager) {
        
        dbManager = [BirthdaySQL new];
        [dbManager createTable];
    }
    return dbManager;
}


static sqlite3 *db = nil;

//打开数据库
-(void)openDB{
    
    if (nil != db) {
        return;
    }
    //创建路径
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    path = [path stringByAppendingPathComponent:@"birthday.sqlite"];//打开数据库
    
    int result = sqlite3_open([path UTF8String], &db);
    if (result == SQLITE_OK) {
        NSLog(@"打开成功");
    }else{
        NSLog(@"打开失败，错误操作为%d",result);
    }
}

//关闭
-(void)closeDB{
    
    int result = sqlite3_close(db);
    
    if (result == SQLITE_OK) {
        db = nil;
        NSLog(@"关闭成功");
    }else{
        NSLog(@"关闭失败，错误操作数为%d",result);
    }
    
}


//创建表
-(void)createTable{
    
    [self openDB];
    //准备sql语句
    
    
    NSString *createString = @"CREATE TABLE IF NOT EXISTS 'birthday' ('introLabel' TEXT NOT NULL, 'dateBirth' TEXT NOT NULL, 'remindState' TEXT NOT NULL);";
    int result =  sqlite3_exec(db, createString.UTF8String, NULL, NULL, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"创建成功");
    }else{
        NSLog(@"创建失败，错误操作数为%d",result);
    }
    [self closeDB];

}

//清空表
-(void)clearTable{
    
    [self openDB];
    //准备sql语句
    
    NSString *deleteString = @"DELETE FROM 'birthday' WHERE 1=1";
    int result = sqlite3_exec(db, deleteString.UTF8String, NULL, NULL, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败，错误操作数为%d", result);
    }
    [self closeDB];
}



//增
-(void)insertBirthday:(Birthday *)birthday{
    
    [self openDB];
    
    
    NSString *insertString = [NSString stringWithFormat:@"insert into 'birthday' (introLabel,dateBirth,remindState) values ('%@','%@','%@');",birthday.introLabel,birthday.dateBirth,birthday.remindState];//不区分大小写
    
    int result = sqlite3_exec(db, insertString.UTF8String, NULL, NULL, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入失败，错误操作数为%d",result);
    }
    [self closeDB];

    
}

//删
-(void)deleteScheduleWithintroLabel:(NSString *)introLabel{
    [self openDB];
    NSString *deleteString = [NSString stringWithFormat:@"DELETE FROM 'birthday' where introLabel = '%@'",introLabel];
    
    int result = sqlite3_exec(db, deleteString.UTF8String, NULL, NULL, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败，错误操作数为%d",result);
    }
    [self closeDB];
}


//输出全部
-(NSMutableArray *)selectAllBirthday{
    
    [self openDB];
    //准备数组
    NSMutableArray *array = nil;
    //准备伴随指针
    sqlite3_stmt *stmt = nil;
    //准备SQL语句
    NSString *selectString = @"select *from birthday";
    
    int result = sqlite3_prepare_v2(db, selectString.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        array = [[NSMutableArray alloc] initWithCapacity:20];
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            Birthday *bir = [Birthday new];
            bir.introLabel = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            bir.dateBirth = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            bir.remindState = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            
            
            [array addObject:bir];
            
        }
    }else{
        NSLog(@"查询失败，失败操作数为%d",result);
    }
    //释放伴随指针
    sqlite3_finalize(stmt);
    
    
    for (Birthday *sch in array) {
        NSLog(@"%@",sch);
    }
    [self closeDB];
    return array;

    
    
}


//修改
-(void)changeUseIsJoinWithintroLabel:(NSString *)introLabel remindState:(NSString *)remindState{
    
    [self openDB];
    NSString *updateString = [NSString stringWithFormat:@"UPDATE birthday SET 'remindState' = '%@' where introLabel = '%@'",remindState,introLabel];
    
    int result = sqlite3_exec(db, updateString.UTF8String, NULL, NULL, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"修改成功");
    }else{
        NSLog(@"修改失败，错误操作数为%d",result);
        
    }
    [self closeDB];
    
    
}



-(Birthday *)selectBirthdayWith:(NSString *)introLabel{
    
    [self openDB];
    //准备数组
    NSMutableArray *array = nil;
    //准备伴随指针
    sqlite3_stmt *stmt = nil;
    //准备SQL语句
    NSString *selectString = [NSString stringWithFormat:@"select *from birthday WHERE introLabel = '%@'",introLabel];
    
    int result = sqlite3_prepare_v2(db, selectString.UTF8String, -1, &stmt, NULL);
    
    Birthday *bir = [Birthday new];
    if (result == SQLITE_OK) {
       
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            
            bir.introLabel = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            bir.dateBirth = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            bir.remindState = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
           }
    }else{
        NSLog(@"查询失败，失败操作数为%d",result);
    }
    //释放伴随指针
    sqlite3_finalize(stmt);
    [self closeDB];
    return bir;
}



@end
