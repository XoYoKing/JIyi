//
//  Weather.h
//  Weather
//
//  Created by lanou3g on 15/11/7.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property(nonatomic,strong)NSString *city,*cityid;

@property(nonatomic,strong)NSString *date, *week, *curTemp, *aqi, *fengxiang, *fengli, *hightemp, *lowtemp, *type;

@property(nonatomic,strong)NSString *name, *code, *index, *details;


//城市编码获取
@property(nonatomic,strong)NSString *flag;
@property(nonatomic,strong)NSString *provinces;
@property(nonatomic,strong)NSString *coding;

//Model
//weather
//
//city(城市)NSString
//cityid(城市ID)NSString
//today{
//date: (日期)NSString,
//week: (星期)NSString,
//curTemp: (温度)NSString,
//aqi: (空气污染指数)NSString,
//fengxiang:(风向) NSString,
//fengli: (风力)NSString,
//hightemp: (最高温度)NSString,
//lowtemp: (最低温度)NSString,
//type: (天气状况)NSString,
//name: "指数",
//code: (代码)gm(感冒) , fs(防晒)  , ct (穿衣) , yd(运动) , xc(洗车) , ls (晾晒)
//index: (等级),
//details:(解释)



@end
