//
//  WeatherSQL.h
//  team
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherMedol.h"
@interface WeatherSQL : NSObject

+(instancetype)shareWeatherManger;

//打开数据库
-(void)openDB;

//关闭
-(void)closeDB;


//创建表
-(void)createTable;


//增
-(void)insertWeather:(WeatherMedol *)weather;

//删
-(void)deleteWeather;


//输出全部
-(NSArray *)selectAllWeather;


@end
