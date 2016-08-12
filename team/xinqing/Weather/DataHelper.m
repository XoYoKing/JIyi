//
//  DataHelper.m
//  Weather
//
//  Created by lanou3g on 15/11/7.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "DataHelper.h"
#define UrlWeather @"http://apis.baidu.com/apistore/weatherservice/recentweathers";
#import "Weather.h"


@interface DataHelper ()
@property (nonatomic,strong)NSMutableArray *allArray;
@property (nonatomic,strong)NSMutableDictionary *allDataDic;
@end
@implementation DataHelper

+ (instancetype)shareWithDataHelper
{
    static DataHelper *Data = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Data = [DataHelper new];
        
    });
    return Data;
    
}

- (instancetype)init
{
    if (self = [super init]) {
        
        
        
    }
    return self;
    
}



- (NSMutableArray *)allArray
{
    if (!_allArray) {
        self.allArray = [NSMutableArray array];
    }
    return _allArray;
    
}

- (NSMutableDictionary *)allDataDic
{
    if (!_allDataDic) {
        
        self.allDataDic = [NSMutableDictionary dictionary];
        
    }
    
    return _allDataDic;
}

- (NSArray *)getObjectWithKey:(NSString *)key
{
   return [self.allDataDic objectForKey:key];
}

- (NSMutableDictionary *)allDictionary
{
    return [self.allDataDic copy];
}

- (void)addobject:(NSMutableArray *)object forKey:(NSString *)key
{
    [self.allDataDic setObject:object forKey:key];
}

- (NSArray*)allKeys
{
    return self.allDataDic.allKeys;
}




//解析 cityname=%E5%8C%97%E4%BA%AC&cityid=101010100
-(void)request:(NSString*)httpUrl withHttpArg: (NSString*)HttpArg block:(Block)block
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
        
        NSLog(@"%@",urlStr);
        
        NSURL *url = [NSURL URLWithString: urlStr];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
        [request setHTTPMethod: @"GET"];
        [request addValue: @"1b456264513ea1a4b4862bd6909c5ab2" forHTTPHeaderField: @"apikey"];
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSLog(@"%@",data);
            
            if (error) {
//                NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
            } else {
//                NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"HttpResponseCode:%ld", responseCode);
//                NSLog(@"HttpResponseBody %@",responseString);
            }
            
            
            NSDictionary *Dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            _allArray = [[NSMutableArray alloc] initWithCapacity:10];
            
            //1获取当前城市以及城市ID
            NSDictionary *dic = [Dict objectForKey:@"retData"];
  
            Weather *weather = [Weather new];
            [weather setValuesForKeysWithDictionary:dic];
            [_allArray addObject:weather];
            
           
            
          
            
            NSArray *array = [NSArray arrayWithArray:_allArray];
            [self.allDataDic setObject:array forKey:@"City"];
            
            
            
            //2获取今天的天气
            _allArray = [[NSMutableArray alloc] initWithCapacity:10];
           
            NSLog(@"%@",dic);
            
            NSDictionary *di = [dic objectForKey:@"today"];
    
            Weather *weather2 = [Weather new];
            [weather2 setValuesForKeysWithDictionary:di];
            [_allArray addObject:weather2];

            
            NSArray *array2 = [NSArray arrayWithArray:_allArray];
            [self.allDataDic setObject:array2 forKey:@"Today"];
            
            
            
            
            //3获取今天的天指数
            _allArray = [[NSMutableArray alloc] initWithCapacity:10];
            for (NSDictionary *dictionary in [di objectForKey:@"index"]) {
                
                Weather *weath = [Weather new];
                [weath setValuesForKeysWithDictionary:dictionary];
                [_allArray addObject:weath];
            }
            
            NSArray *array3 = [NSArray arrayWithArray:_allArray];
            [self.allDataDic setObject:array3 forKey:@"Name"];
            
            
            
            //4获取预测4天得天气
            _allArray = [[NSMutableArray alloc] initWithCapacity:10];
            for (NSDictionary *dictionary in [dic objectForKey:@"forecast"]) {
                
                Weather *weath = [Weather new];
                [weath setValuesForKeysWithDictionary:dictionary];
                [_allArray addObject:weath];
                
            }
            
            NSArray *array4 = [NSArray arrayWithArray:_allArray];
            
            for (Weather *weather in array4) {
                
                NSLog(@"^^^^^^^^^^^%@",weather.date);
                
            }
            
            [self.allDataDic setObject:array4 forKey:@"Forecast"];
            
            
            
            
            //5.获取历史两天的天气
            _allArray = [[NSMutableArray alloc] initWithCapacity:10];
            for (NSDictionary *Dictionary in [dic objectForKey:@"history"]) {
                
                Weather *weath = [Weather new];
                [weath  setValuesForKeysWithDictionary:Dictionary];
                [_allArray addObject:weath];
            }
            
            NSArray *array5 = [NSArray arrayWithArray:_allArray];
            [self.allDataDic setObject:array5 forKey:@"History"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
            
            block();
        }];
        
        [task resume];

    });
}

- (void)allCityID
{
    
    
     //1.获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Weather_Json" ofType:@"txt"];
    //2.创建data对象
    NSData *Data = [NSData dataWithContentsOfFile:path];
    //3解析
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:Data options:NSJSONReadingAllowFragments error:nil];

    for (NSDictionary *dict in [dictionary objectForKey:@"城市代码"]) {
        Weather *weather = [Weather new];
        [weather setValuesForKeysWithDictionary:dict];
        
        NSArray *array = @[@"北京",@"天津市",@"上海",@"河北",
                           @"河南",@"安徽",@"浙江",@"重庆",
                           @"福建",@"甘肃",@"广东",@"广西",
                           @"贵州",@"云南",@"内蒙古",@"江西",
                           @"湖北",@"四川",@"宁夏",@"青海省",
                           @"山东",@"陕西省",@"山西",@"新疆",
                           @"西藏",@"台湾",@"海南省",@"湖南",
                           @"江苏",@"黑龙江",@"吉林",@"辽宁"];
        
        for (NSString *provinces in array) {
            _allArray = [[NSMutableArray alloc] initWithCapacity:20];
            if ([weather.flag isEqualToString:provinces]) {
                for (NSDictionary *dic in [dict objectForKey:@"市"]) {
                    
                    Weather *wea = [Weather new];
                    [wea setValuesForKeysWithDictionary:dic];
                    [_allArray addObject:wea];
       
                }
            
                NSArray *allDataArray = [NSArray arrayWithArray:_allArray];
                [self.allDataDic setObject:allDataArray forKey:weather.flag];
                
            }
 
            
            
        }
   
    }
    
    
    
    
    
    
    
    
}


























@end
