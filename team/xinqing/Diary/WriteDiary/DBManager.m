//
//  DBManager.m
//  你听啥
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>
@implementation DBManager
+ (instancetype)showDBManager
{
    static DBManager *dbmanager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dbmanager = [DBManager new];
        
    });
    return dbmanager;
    
}

static sqlite3 *db = nil;

-(void)openDBManager
{
    
    //    NSString *path = NSHomeDirectory();
    //    path = [path stringByAppendingPathComponent:@"DBManager.sqlite"];
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"DBManager.sqlite"];
    //    path = [path stringByAppendingPathComponent:@"Music.sqlite"];
    
    
    int result= sqlite3_open([path UTF8String], &db);
    
    if (result == SQLITE_OK) {
        
        NSLog(@"打开成功");
        
    }
    else
    {
        NSLog(@"打开失败");
    }
    
    
    
    
    
    
}

-(void)closeDBmanager
{
    
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        
        NSLog(@"关闭成功");
        
    }
    else
    {
        NSLog(@"关闭失败");
    }
}

//创建表
- (void)createTable
{
    
    //CREATE  TABLE if not exists 'Music' ('title' CHAR PRIMARY KEY  NOT NULL  UNIQUE , 'tags' CHAR, 'duration' INTEGER)
    NSString *createTable = @"CREATE TABLE if not exists 'Diary' ('textName' TEXT PRIMARY KEY NOT NULL UNIQUE, 'textTime' TEXT NOT NULL,'textContact' TEXT ,'index' TEXT ,'textWeather' TEXT );";
    
    int request = sqlite3_exec(db, [createTable UTF8String], NULL, NULL, NULL);
    
    if (request == SQLITE_OK) {
        NSLog(@"创建成功");
    }else{
        NSLog(@"创建失败");
    }
    
}

//增
- (void)insertDiary:(Diary *)diary
{
    NSString *insertInto = [NSString stringWithFormat:@"insert into 'Diary' ('textName','textTime','textContact','index')values('%@','%@','%@','%@')",diary.name,diary.time,diary.textContact,diary.index];
    int result = sqlite3_exec(db, [insertInto UTF8String], NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入失败");
    }
    
}


//删
- (void)deletefromTitle:(NSString *)Title
{
    
    NSString *delete = [NSString stringWithFormat:@"DELETE FROM Diary WHERE textName = '%@'",Title];
    
    int result = sqlite3_exec(db, delete.UTF8String, NULL, NULL, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        
        NSLog(@"删除失败");
    }
    
}


//查
- (NSArray *)selectAll
{
    //准备数组
    NSMutableArray *array = nil;
    //准备伴随指针
    sqlite3_stmt *Stmt = nil;
    //准备SQL语句
    NSString *String = @"select *from Diary";
    //准备执行
    int result = sqlite3_prepare(db, String.UTF8String, -1, &Stmt, NULL);
    if (result == SQLITE_OK) {
        
        array = [[NSMutableArray alloc] initWithCapacity:20];
        while (sqlite3_step(Stmt) == SQLITE_ROW) {
            
            Diary *diary = [Diary new];
            diary.name =  [NSString stringWithUTF8String:(const char *)sqlite3_column_text(Stmt, 0)];
            diary.time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(Stmt, 1)];
            
            diary.textContact = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(Stmt, 2)];
            diary.index = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(Stmt, 3)];

            
            [array addObject:diary];
            
        }
        
    }
    else
    {
        NSLog(@"查询失败");
    }
    for (Diary *diary in array) {
        
        NSLog(@"%@",diary);
        
    }
    sqlite3_finalize(Stmt);
    
    return array;
}

- (NSArray *)selectTitle:(NSString *)Title;
{
    //准备数组
    NSMutableArray *array = nil;
    //准备伴随指针
    sqlite3_stmt *Stmt = nil;
    //准备SQL语句
    NSString *String = [NSString stringWithFormat:@"select *from Diary WHERE textName = '%@'",Title];
    //准备执行
    int result = sqlite3_prepare(db, String.UTF8String, -1, &Stmt, NULL);
    if (result == SQLITE_OK) {
        
        array = [[NSMutableArray alloc] initWithCapacity:20];
        while (sqlite3_step(Stmt) == SQLITE_ROW) {
            
            Diary *diary = [Diary new];
            diary.name =  [NSString stringWithUTF8String:(const char *)sqlite3_column_text(Stmt, 0)];
            diary.time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(Stmt, 1)];
            diary.textContact = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(Stmt, 2)];
            diary.index = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(Stmt, 3)];
            [array addObject:diary];
    
            
        }
        
    }
    else
    {
        NSLog(@"查询失败");
    }
    for (Diary *diary in array) {
        
        NSLog(@"%@",diary);
        
    }
    sqlite3_finalize(Stmt);
    
    return array;
    
}


- (NSArray *)selecttextTime:(NSString *)textTime
{
    //准备数组
    NSMutableArray *array = nil;
    //准备伴随指针
    sqlite3_stmt *Stmt = nil;
    //准备SQL语句
    NSString *String = [NSString stringWithFormat:@"select *from Diary WHERE textTime = '%@'",textTime];
    //准备执行
    int result = sqlite3_prepare(db, String.UTF8String, -1, &Stmt, NULL);
    if (result == SQLITE_OK) {
        
        array = [[NSMutableArray alloc] initWithCapacity:20];
        while (sqlite3_step(Stmt) == SQLITE_ROW) {
            
            Diary *diary = [Diary new];
            diary.name =  [NSString stringWithUTF8String:(const char *)sqlite3_column_text(Stmt, 0)];
            diary.time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(Stmt, 1)];
            diary.textContact = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(Stmt, 2)];
            diary.index = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(Stmt, 3)];
            [array addObject:diary];
            
        }
        
    }
    else
    {
        NSLog(@"查询失败");
    }
    for (Diary *diary in array) {
        
        NSLog(@"%@",diary);
        
    }
    sqlite3_finalize(Stmt);
    
    return array;
    
    
    
    
}


@end
