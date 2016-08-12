//
//  DataHelper.h
//  Weather
//
//  Created by lanou3g on 15/11/7.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Block) ();
@interface DataHelper : NSObject

//单例
+ (instancetype)shareWithDataHelper;


//解析 cityname=%E5%8C%97%E4%BA%AC&cityid=101010100
-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg block:(Block)block;
- (void)allCityID;


- (NSArray *)getObjectWithKey:(NSString *)key;
- (NSMutableDictionary *)allDictionary;
- (void)addobject:(NSMutableArray *)object forKey:(NSString *)key;
- (NSArray*)allKeys;




//allKeys// 1.City所处城市以及城市ID
           //2.Today今天的时间,星期,温度,空气污染指数aqi,风级,天气状况
            //3.Name感冒指数,防晒指数,穿衣指数,运动指数,洗车指数,晾晒指数,以及对应的策略和指数等级
             //4.Forecast预测未来4天的时间,星期,温度,空气污染指数aqi,风级,天气状况
              //5.History历史7天的时间,星期,温度,空气污染指数aqi,风级,天气状况

@end
