
//
//  WeatherSQL.m
//  team
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "WeatherSQL.h"
#import <sqlite3.h>
@implementation WeatherSQL

+(instancetype)shareWeatherManger{
    static WeatherSQL *dbM = nil;
    if (nil == db) {
        dbM = [WeatherSQL new];
        [dbM createTable];
    }
    return dbM;
}


static sqlite3 *db = nil;

//打开数据库
-(void)openDB{
    if (nil != db) {
        return;
    }
    //创建路径
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    path = [path stringByAppendingPathComponent:@"weather.sqlite"];
    //打开数据库
    
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
    
    
    NSString *createString = @"CREATE TABLE IF NOT EXISTS 'weather' ('city' TEXT, 'city2' TEXT, 'wahtWeather' TEXT, 'nowDate' TEXT, 'nowWeek' TEXT, 'wind' TEXT, 'haze' TEXT, 'minTemperature' TEXT, 'maxTemperature' TEXT, 'nowTemperature' TEXT, 'week1' TEXT, 'date1' TEXT, 'wether1' TEXT, 'minTemperature1' TEXT, 'maxTemperature1' TEXT, 'week2' TEXT, 'date2' TEXT, 'wether2' TEXT, 'minTemperature2' TEXT, 'maxTemperature2' TEXT, 'week3' TEXT, 'date3' TEXT, 'wether3' TEXT, 'minTemperature3' TEXT, 'maxTemperature3' TEXT, 'week4' TEXT, 'date4' TEXT, 'wether4' TEXT, 'minTemperature4' TEXT, 'maxTemperature4' TEXT, 'week5' TEXT, 'date5' TEXT, 'wether5' TEXT, 'minTemperature5' TEXT, 'maxTemperature5' TEXT, 'week6' TEXT, 'date6' TEXT, 'wether6' TEXT, 'minTemperature6' TEXT, 'maxTemperature6', 'week7' TEXT, 'date7' TEXT, 'wether7' TEXT, 'minTemperature7' TEXT, 'maxTemperature7' TEXT,'cold' TEXT, 'coldIndex' TEXT, 'coldContent' TEXT, 'dress' TEXT, 'dressIndex' TEXT, 'dressContent' TEXT, 'sunscreen' TEXT, 'sunscreenIndex' TEXT, 'sunscreenContent' TEXT, 'sport' TEXT, 'sportIndex' TEXT, 'sportContent' TEXT);";
    int result =  sqlite3_exec(db, createString.UTF8String, NULL, NULL, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"创建成功");
    }else{
        NSLog(@"创建失败，错误操作数为%d",result);
    }
    [self closeDB];

}


//增
-(void)insertWeather:(WeatherMedol *)weather{
    [self openDB];
    
    
    NSString *insertString = [NSString stringWithFormat:@"insert into 'weather' (city,city2,wahtWeather,nowDate,nowWeek,wind,haze,minTemperature,maxTemperature,nowTemperature,week1,date1,wether1,minTemperature1,maxTemperature1,week2,date2,wether2,minTemperature2,maxTemperature2,week3,date3,wether3,minTemperature3,maxTemperature3,week4,date4,wether4,minTemperature4,maxTemperature4,week5,date5,wether5,minTemperature5,maxTemperature5,week6,date6,wether6,minTemperature6,maxTemperature6,week7,date7,wether7,minTemperature7,maxTemperature7,cold,coldIndex,coldContent,dress,dressIndex,dressContent,sunscreen,sunscreenIndex,sunscreenContent,sport,sportIndex,sportContent) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@');",weather.city,weather.city2,weather.wahtWeather,weather.nowDate,weather.nowWeek,weather.wind,weather.haze,weather.minTemperature,weather.maxTemperature,weather.nowTemperature,weather.week1,weather.date1,weather.wether1,weather.minTemperature1,weather.maxTemperature1,weather.week2,weather.date2,weather.wether2,weather.minTemperature2,weather.maxTemperature2,weather.week3,weather.date3,weather.wether3,weather.minTemperature3,weather.maxTemperature3,weather.week4,weather.date4,weather.wether4,weather.minTemperature4,weather.maxTemperature4,weather.week5,weather.date5,weather.wether5,weather.minTemperature5,weather.maxTemperature5,weather.week6,weather.date6,weather.wether6,weather.minTemperature6,weather.maxTemperature6,weather.week7,weather.date7,weather.wether7,weather.minTemperature7,weather.maxTemperature7,weather.cold,weather.coldIndex,weather.coldContent,weather.dress,weather.dressIndex,weather.dressContent,weather.sunscreen,weather.sunscreenIndex,weather.sunscreenContent,weather.sport,weather.sporeIndex,weather.sportContent];
    
    int result = sqlite3_exec(db, insertString.UTF8String, NULL, NULL, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入失败，错误操作数为%d",result);
    }
    [self closeDB];
 
}

//删
-(void)deleteWeather{
    
    [self openDB];
    
    NSString *deleteString = [NSString stringWithFormat:@"DELETE FROM 'weather';"];
    
    int result = sqlite3_exec(db, deleteString.UTF8String, NULL, NULL, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败，错误操作数为%d",result);
    }

    [self closeDB];
}


//输出全部
-(NSArray *)selectAllWeather{
    
    [self openDB];
    //准备数组
    NSMutableArray *array = nil;
    //准备伴随指针
    sqlite3_stmt *stmt = nil;
    //准备SQL语句
    NSString *selectString = @"select *from weather";
    
    int result = sqlite3_prepare_v2(db, selectString.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        array = [[NSMutableArray alloc] initWithCapacity:20];
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            WeatherMedol *weather = [WeatherMedol new];
            weather.city= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            weather.city2= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            weather.wahtWeather= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            weather.nowDate= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            weather.nowWeek= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            weather.wind= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            weather.haze= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
            weather.minTemperature= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 7)];
            weather.maxTemperature= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 8)];
            weather.nowTemperature= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 9)];
            weather.week1= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 10)];
            weather.date1= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 11)];
            weather.wether1= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 12)];
            weather.minTemperature1= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 13)];
            weather.maxTemperature1= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 14)];
            weather.week2= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 15)];
            weather.date2= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 16)];
            weather.wether2= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 17)];
            weather.minTemperature2= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 18)];
            weather.maxTemperature2= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 19)];
            weather.week3= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 20)];
            weather.date3= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 21)];
            weather.wether3= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 22)];
            weather.minTemperature3= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 23)];
            weather.maxTemperature3= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 24)];
            weather.week4= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 25)];
            weather.date4= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 26)];
            weather.wether4= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 27)];
            weather.minTemperature4= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 28)];
            weather.maxTemperature4= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 29)];
            weather.week5= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 30)];
            weather.date5= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 31)];
            weather.wether5= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 32)];
            weather.minTemperature5= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 33)];
            weather.maxTemperature5= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 34)];
            weather.week6= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 35)];
            weather.date6= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 36)];
            weather.wether6= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 37)];
            weather.minTemperature6= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 38)];
            weather.maxTemperature6= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 39)];
            weather.week7= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 40)];
            weather.date7= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 41)];
            weather.wether7= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 42)];
            weather.minTemperature7= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 43)];
            weather.maxTemperature7= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 44)];
            weather.cold= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 45)];
            weather.coldIndex= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 46)];
            weather.coldContent= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 47)];
            weather.dress= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 48)];
            weather.dressIndex= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 49)];
            weather.dressContent= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 50)];
            weather.sunscreen= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 51)];
            weather.sunscreenIndex= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 52)];
            weather.sunscreenContent= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 53)];
            
            weather.sport= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 54)];
            weather.sporeIndex= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 55)];
            weather.sportContent= [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 56)];
            
            
            
            [array addObject:weather];
            
        }
    }else{
        NSLog(@"查询失败，失败操作数为%d",result);
    }
    //释放伴随指针
    sqlite3_finalize(stmt);
    
    
    for (Schedule *sch in array) {
        NSLog(@"%@",sch);
    }
    [self closeDB];
    return array;
}













@end
