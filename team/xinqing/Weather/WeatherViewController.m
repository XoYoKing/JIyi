//
//  WeatherViewController.m
//  team
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "WeatherViewController.h"
#import "Weather.h"
#import "DataHelper.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <MapKit/MapKit.h>
#import "WeatherSQL.h"
#import "WeatherMedol.h"
@interface WeatherViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@property (weak, nonatomic) IBOutlet UILabel *city2Label;

@property (weak, nonatomic) IBOutlet UILabel *wahtWeather;

@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;


@property (weak, nonatomic) IBOutlet UILabel *nowDate;

@property (weak, nonatomic) IBOutlet UILabel *nowWeek;


@property (weak, nonatomic) IBOutlet UILabel *wind;

@property (weak, nonatomic) IBOutlet UILabel *haze;

@property (weak, nonatomic) IBOutlet UILabel *minTemperature;

@property (weak, nonatomic) IBOutlet UILabel *maxTemperature;

@property (weak, nonatomic) IBOutlet UILabel *nowTemperature;


@property (weak, nonatomic) IBOutlet UILabel *week1;

@property (weak, nonatomic) IBOutlet UILabel *date1;

@property (weak, nonatomic) IBOutlet UILabel *wether1;

@property (weak, nonatomic) IBOutlet UILabel *minTemperature1;

@property (weak, nonatomic) IBOutlet UILabel *maxTemperature1;



@property (weak, nonatomic) IBOutlet UILabel *week2;

@property (weak, nonatomic) IBOutlet UILabel *date2;

@property (weak, nonatomic) IBOutlet UILabel *reather2;

@property (weak, nonatomic) IBOutlet UILabel *minTemperature2;

@property (weak, nonatomic) IBOutlet UILabel *maxTemperature2;

@property (weak, nonatomic) IBOutlet UILabel *week3;

@property (weak, nonatomic) IBOutlet UILabel *date3;

@property (weak, nonatomic) IBOutlet UILabel *weather3;

@property (weak, nonatomic) IBOutlet UILabel *minTemperature3;

@property (weak, nonatomic) IBOutlet UILabel *maxTemperature3;

@property (weak, nonatomic) IBOutlet UILabel *week4;

@property (weak, nonatomic) IBOutlet UILabel *date4;

@property (weak, nonatomic) IBOutlet UILabel *weather4;

@property (weak, nonatomic) IBOutlet UILabel *minTemperature4;

@property (weak, nonatomic) IBOutlet UILabel *maxTemperature4;


@property (weak, nonatomic) IBOutlet UILabel *week5;

@property (weak, nonatomic) IBOutlet UILabel *date5;

@property (weak, nonatomic) IBOutlet UILabel *weather5;

@property (weak, nonatomic) IBOutlet UILabel *minTemperature5;

@property (weak, nonatomic) IBOutlet UILabel *maxTemperature5;

@property (weak, nonatomic) IBOutlet UILabel *week6;

@property (weak, nonatomic) IBOutlet UILabel *date6;

@property (weak, nonatomic) IBOutlet UILabel *weather6;

@property (weak, nonatomic) IBOutlet UILabel *minTemperature6;

@property (weak, nonatomic) IBOutlet UILabel *maxTemperature6;

@property (weak, nonatomic) IBOutlet UILabel *week7;

@property (weak, nonatomic) IBOutlet UILabel *date7;

@property (weak, nonatomic) IBOutlet UILabel *weather7;

@property (weak, nonatomic) IBOutlet UILabel *minTemperature7;

@property (weak, nonatomic) IBOutlet UILabel *maxTemperature7;


@property (weak, nonatomic) IBOutlet UILabel *cold;

@property (weak, nonatomic) IBOutlet UILabel *coldIndex;


@property (weak, nonatomic) IBOutlet UILabel *coldContent;



@property (weak, nonatomic) IBOutlet UILabel *dress;

@property (weak, nonatomic) IBOutlet UILabel *dressIndex;

@property (weak, nonatomic) IBOutlet UILabel *dressContent;


@property (weak, nonatomic) IBOutlet UILabel *sunscreen;

@property (weak, nonatomic) IBOutlet UILabel *sunscreenIndex;

@property (weak, nonatomic) IBOutlet UILabel *sunscreenContent;

@property (weak, nonatomic) IBOutlet UILabel *sport;

@property (weak, nonatomic) IBOutlet UILabel *sportIndex;

@property (weak, nonatomic) IBOutlet UILabel *sporeContent;


//map
@property (nonatomic,strong)MKMapView *mapView;
//Location
@property (nonatomic,strong)CLLocation *userLocation;
//manager
@property (nonatomic,strong)CLLocationManager *manger;

//key
@property (nonatomic,strong)NSString *StrCity;
@property (nonatomic,strong)NSString *StrProvinces;



@property (nonatomic,strong)NSMutableArray *allArray;
@property (nonatomic,strong)NSMutableDictionary *allDataDic;

//存进本地的model
@property(nonatomic,strong)WeatherMedol *weatherModel;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"天气";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.view.backgroundColor = [UIColor redColor];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backbutton:)];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    NSArray *array = [[WeatherSQL shareWeatherManger] selectAllWeather];
    
    if (array.count != 0) {
        WeatherMedol *weather = array[0];
        
        self.cityLabel.text = weather.city;
        self.city2Label.text = weather.city2;
        self.wahtWeather.text = weather.wahtWeather;
        self.nowDate.text = weather.nowDate;
        self.nowWeek.text = weather.nowWeek;
        self.wind.text = weather.wind;
        self.haze.text = @"";
        self.minTemperature.text = weather.minTemperature;
        self.maxTemperature.text = weather.maxTemperature;
        self.nowTemperature.text = weather.nowTemperature;
        self.week1.text = weather.week1;
        self.date1.text = weather.date1;
        self.wether1.text = weather.wether1;
        self.minTemperature1.text = weather.minTemperature1;
        self.maxTemperature1.text = weather.maxTemperature1;
        self.week2.text = weather.week2;
        self.date2.text = weather.date2;
        self.reather2.text = weather.wether2;
        self.minTemperature2.text = weather.minTemperature2;
        self.maxTemperature2.text = weather.maxTemperature2;
        self.week3.text = weather.week3;
        self.date3.text = weather.date3;
        self.weather3.text = weather.wether3;
        self.minTemperature3.text = weather.minTemperature3;
        self.maxTemperature3.text = weather.maxTemperature3;
        self.week4.text = weather.week4;
        self.date4.text = weather.date4;
        self.weather4.text = weather.wether4;
        self.minTemperature4.text = weather.minTemperature4;
        self.maxTemperature4.text = weather.maxTemperature4;
        self.week5.text = weather.week5;
        self.date5.text = weather.date5;
        self.weather5.text = weather.wether5;
        self.minTemperature5.text = weather.minTemperature5;
        self.maxTemperature5.text = weather.maxTemperature5;
        self.week6.text = weather.week6;
        self.date6.text = weather.date6;
        self.weather6.text = weather.wether6;
        self.minTemperature6.text = weather.minTemperature6;
        self.maxTemperature6.text = weather.maxTemperature6;
        self.week7.text = weather.week7;
        self.date7.text = weather.date7;
        self.weather7.text = weather.wether7;
        self.minTemperature7.text = weather.minTemperature7;
        self.maxTemperature7.text = weather.maxTemperature7;
        self.cold.text = weather.cold;
        self.coldIndex.text = weather.coldIndex;
        self.coldContent.text = weather.coldContent;
        self.dress.text = weather.dress;
        self.dressIndex.text = weather.dressIndex;
        self.dressContent.text = weather.dressContent;
        self.sunscreen.text = weather.sunscreen;
        self.sunscreenIndex.text = weather.sunscreenIndex;
        self.sunscreenContent.text = weather.sunscreenContent;
        self.sport.text = weather.sport;
        self.sportIndex.text = weather.sporeIndex;
        self.sporeContent.text = weather.sportContent;
        
    }
    
    
     self.weatherModel = [WeatherMedol new];
    
    

}

- (void)backbutton:(UIBarButtonItem *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    //判断系统
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        //获取当前设备
        self.manger = [CLLocationManager new];
        
        //允许定位
        [self.manger requestWhenInUseAuthorization];
        //        [self.manger requestAlwaysAuthorization];
        //设置用户跟随模式(一直跟踪)
        
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    }
    
    //设置代理
    self.mapView.delegate = self;
    self.manger.delegate = self;
    
    //距离筛选,设置最小位置更新
    self.manger.desiredAccuracy = 5000;
    //开始定位
    [self.manger startUpdatingLocation];
   
    
    

}

- (void)loadData
{
    NSString *httpUrl = @"http://apis.baidu.com/apistore/weatherservice/recentweathers";
    
    NSString *str1 = @"区";
    NSString *str2 = @"县";
    NSString *str3 = @"市";
    NSString *str4 = @"省";
    
    NSString *strCit1 = [self.StrCity stringByReplacingOccurrencesOfString:str3 withString:@""];
    NSString *strPro1 = [self.StrProvinces stringByReplacingOccurrencesOfString:str1 withString:@""];
    
    
    //大城市最终名称
    NSString *strCit2 = [strCit1 stringByReplacingOccurrencesOfString:str4 withString:@""];
    //小城市最终名称
    NSString *strPro2 = [strPro1 stringByReplacingOccurrencesOfString:str2 withString:@""];
    
    
    NSArray *arrayPro = [[DataHelper shareWithDataHelper] getObjectWithKey:strCit2];
    
    //城市编码
    NSString *StringCityID = @"";
    
    for (Weather *weather in arrayPro) {
        
        NSLog(@"11%@",weather.provinces);
        
        if ([weather.provinces rangeOfString:strPro2].length != 0) {
           // NSLog(@"22%@",weather.provinces);
            //获取城市编码
            StringCityID = weather.coding;
            
        }
    }
    NSString *Str = strPro2;


    NSString * nameID = StringCityID;
    NSString * nameCity = [Str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    
    NSString *httpArg = [NSString stringWithFormat:@"cityname=%@&cityid=%@",nameCity,nameID];
    
    [self request:httpUrl withHttpArg:httpArg block:^{
        
    }];
    
}




//解析 cityname=%E5%8C%97%E4%BA%AC&cityid=101010100
-(void)request:(NSString*)httpUrl withHttpArg: (NSString*)HttpArg block:(Block)block
{
    
    NSLog(@"%@",HttpArg);
    
        NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
        NSURL *url = [NSURL URLWithString: urlStr];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
        [request setHTTPMethod: @"GET"];
        [request addValue: @"1b456264513ea1a4b4862bd6909c5ab2" forHTTPHeaderField: @"apikey"];
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
          
            
            if (data == nil) {
                
                return;
            }
            
            
            
            if (error) {
                
            } else {
                
               
                //更新UI的操作，放在主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                NSDictionary *Dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                _allArray = [[NSMutableArray alloc] initWithCapacity:10];
                
                //1获取当前城市以及城市ID
                NSDictionary *dic = [Dict objectForKey:@"retData"];
                
                Weather *weather = [Weather new];
                [weather setValuesForKeysWithDictionary:dic];
                
                [_allArray addObject:weather];
                
                self.cityLabel.text = weather.city;
                
                
                    
                    //存入本地
                   
                    self.weatherModel.city = weather.city;
                    
                    NSLog(@"%@",weather.city);
                    
                
                NSArray *array = [NSArray arrayWithArray:_allArray];
                [self.allDataDic setObject:array forKey:@"City"];
                
                
                
                    
                    
                //2获取今天的天气
                _allArray = [[NSMutableArray alloc] initWithCapacity:10];
                
                
                
                NSDictionary *di = [dic objectForKey:@"today"];
                
                Weather *weather2 = [Weather new];
                [weather2 setValuesForKeysWithDictionary:di];
                    
    
                self.nowDate.text = weather2.date;
                self.nowWeek.text = weather2.week;
                self.nowTemperature.text = weather2.curTemp;
                self.minTemperature.text = weather2.lowtemp;
                self.maxTemperature.text = weather2.hightemp;
                self.wahtWeather.text = weather2.type;
                self.wind.text = weather2.fengli;
                
                self.week3.text = weather2.week;
                self.date3.text = weather2.date;
                self.weather3.text = weather2.type;
                self.minTemperature3.text = weather2.lowtemp;
                self.maxTemperature3.text = weather2.hightemp;
                
                    //添加天气图片
                    [self imageWithType:weather2.type];
                    
                    //写入本地
                    self.weatherModel.nowDate = weather2.date;
                    self.weatherModel.nowWeek = weather2.week;
                    self.weatherModel.nowTemperature = weather2.curTemp;
                    self.weatherModel.minTemperature = weather2.lowtemp;
                    self.weatherModel.maxTemperature = weather2.hightemp;
                    self.weatherModel.wahtWeather = weather2.type;
                    self.weatherModel.wind = weather2.fengli;
                    
                    self.weatherModel.week3 = weather2.week;
                    self.weatherModel.date3 = weather2.date;
                    self.weatherModel.wether3 = weather2.type;
                    self.weatherModel.minTemperature3 = weather2.lowtemp;
                    self.weatherModel.maxTemperature3 = weather2.hightemp;
                    
                
                
                
                NSArray *array2 = [NSArray arrayWithArray:_allArray];
                [self.allDataDic setObject:array2 forKey:@"Today"];
                
                
                
                
                //3获取今天的天指数
                NSMutableArray *arrayIndex = [[NSMutableArray alloc] initWithCapacity:10];
                for (NSDictionary *dictionary in [di objectForKey:@"index"]) {
                    
                    Weather *weath = [Weather new];
                    [weath setValuesForKeysWithDictionary:dictionary];
                    
                    [arrayIndex addObject:weath];
                }
                
                Weather *weatherIndex1 = arrayIndex[0];
                self.cold.text = weatherIndex1.name;
                self.coldIndex.text = weatherIndex1.index;
                self.coldContent.text = weatherIndex1.details;
                
                
                Weather *weatherIndex2 = arrayIndex[2];
                self.dress.text = weatherIndex2.name;
                self.dressIndex.text = weatherIndex2.index;
                self.dressContent.text = weatherIndex2.details;
                
                Weather *weatherIndex3 = arrayIndex[1];
                self.sunscreen.text = weatherIndex3.name;
                self.sunscreenIndex.text = weatherIndex3.index;
                self.sunscreenContent.text = weatherIndex3.details;
                
                
                Weather *weatherIndex4 = arrayIndex[3];
                self.sport.text = weatherIndex4.name;
                self.sportIndex.text = weatherIndex4.index;
                self.sporeContent.text = weatherIndex4.details;
                
                    
                    //写入本地
                    self.weatherModel.cold = weatherIndex1.name;
                    self.weatherModel.coldIndex = weatherIndex1.index;
                    self.weatherModel.coldContent = weatherIndex1.details;
                    
                    
                    self.weatherModel.dress = weatherIndex2.name;
                    self.weatherModel.dressIndex = weatherIndex2.index;
                    self.weatherModel.dressContent = weatherIndex2.details;
                    
                    
                    self.weatherModel.sunscreen = weatherIndex3.name;
                    self.weatherModel.sunscreenIndex = weatherIndex3.index;
                    self.weatherModel.sunscreenContent = weatherIndex3.details;
                    
                    
                    self.weatherModel.sport = weatherIndex4.name;
                    self.weatherModel.sporeIndex = weatherIndex4.index;
                    self.weatherModel.sportContent = weatherIndex4.details;
                
                
                
                
                
                //4获取预测4天得天气
                NSMutableArray *arrayFuture = [[NSMutableArray alloc] initWithCapacity:5];
                for (NSDictionary *dictionary in [dic objectForKey:@"forecast"]) {
                    
                    Weather *weath = [Weather new];
                    [weath setValuesForKeysWithDictionary:dictionary];
                    [arrayFuture addObject:weath];
                    
                }
                
                Weather *weatherFuture4 = arrayFuture[0];
                self.week4.text = weatherFuture4.week;
                self.date4.text = weatherFuture4.date;
                self.weather4.text = weatherFuture4.type;
                self.minTemperature4.text = weatherFuture4.lowtemp;
                self.maxTemperature4.text = weatherFuture4.hightemp;
                
                Weather *weatherFuture5 = arrayFuture[1];
                self.week5.text = weatherFuture5.week;
                self.date5.text = weatherFuture5.date;
                self.weather5.text = weatherFuture5.type;
                self.minTemperature5.text = weatherFuture5.lowtemp;
                self.maxTemperature5.text = weatherFuture5.hightemp;
                
                Weather *weatherFuture6 = arrayFuture[2];
                self.week6.text = weatherFuture6.week;
                self.date6.text = weatherFuture6.date;
                self.weather6.text = weatherFuture6.type;
                self.minTemperature6.text = weatherFuture6.lowtemp;
                self.maxTemperature6.text = weatherFuture6.hightemp;
                
                Weather *weatherFuture7 = arrayFuture[3];
                self.week7.text = weatherFuture7.week;
                self.date7.text = weatherFuture7.date;
                self.weather7.text = weatherFuture7.type;
                self.minTemperature7.text = weatherFuture7.lowtemp;
                self.maxTemperature7.text = weatherFuture7.hightemp;
                
                
                    //写入本地
                    self.weatherModel.week4 = weatherFuture4.week;
                    self.weatherModel.date4 = weatherFuture4.date;
                    self.weatherModel.wether4 = weatherFuture4.type;
                    self.weatherModel.minTemperature4 = weatherFuture4.lowtemp;
                    self.weatherModel.maxTemperature4 = weatherFuture4.hightemp;
                    
                    self.weatherModel.week5 = weatherFuture5.week;
                    self.weatherModel.date5 = weatherFuture5.date;
                    self.weatherModel.wether5 = weatherFuture5.type;
                    self.weatherModel.minTemperature5 = weatherFuture5.lowtemp;
                    self.weatherModel.maxTemperature5 = weatherFuture5.hightemp;
                    
                    
                    self.weatherModel.week6 = weatherFuture6.week;
                    self.weatherModel.date6 = weatherFuture6.date;
                    self.weatherModel.wether6 = weatherFuture6.type;
                    self.weatherModel.minTemperature6 = weatherFuture6.lowtemp;
                    self.weatherModel.maxTemperature6 = weatherFuture6.hightemp;
                    
                    
                    self.weatherModel.week7 = weatherFuture7.week;
                    self.weatherModel.date7 = weatherFuture7.date;
                    self.weatherModel.wether7 = weatherFuture7.type;
                    self.weatherModel.minTemperature7 = weatherFuture7.lowtemp;
                    self.weatherModel.maxTemperature7 = weatherFuture7.hightemp;
                    
                    
                
                
                //5.获取历史两天的天气
                NSMutableArray *arrayHistory = [[NSMutableArray alloc] initWithCapacity:7];
                for (NSDictionary *Dictionary in [dic objectForKey:@"history"]) {
                    
                    Weather *weath = [Weather new];
                    [weath  setValuesForKeysWithDictionary:Dictionary];
                    [arrayHistory addObject:weath];
                }
                
                Weather *weatherHistory1 = arrayHistory[5];
                self.week1.text = weatherHistory1.week;
                self.date1.text = weatherHistory1.date;
                self.wether1.text = weatherHistory1.type;
                self.minTemperature1.text = weatherHistory1.lowtemp;
                self.maxTemperature1.text = weatherHistory1.hightemp;
                
                
                Weather *weatherHistory2 = arrayHistory[6];
                self.week2.text = weatherHistory2.week;
                self.date2.text = weatherHistory2.date;
                self.reather2.text = weatherHistory2.type;
                self.minTemperature2.text = weatherHistory2.lowtemp;
                self.maxTemperature2.text = weatherHistory2.hightemp;
                    
                    //写入本地
                    self.weatherModel.week1 = weatherHistory1.week;
                    self.weatherModel.date1 = weatherHistory1.date;
                    self.weatherModel.wether1 = weatherHistory1.type;
                    self.weatherModel.minTemperature1 = weatherHistory1.lowtemp;
                    self.weatherModel.maxTemperature1 = weatherHistory1.hightemp;
                    
                    
                    self.weatherModel.week2 = weatherHistory2.week;
                    self.weatherModel.date2 = weatherHistory2.date;
                    self.weatherModel.wether2 = weatherHistory2.type;
                    self.weatherModel.minTemperature2 = weatherHistory2.lowtemp;
                    self.weatherModel.maxTemperature2 = weatherHistory2.hightemp;
 
                    [[WeatherSQL shareWeatherManger] deleteWeather];
                    [[WeatherSQL shareWeatherManger] insertWeather:self.weatherModel];
                       });
                
                
            }
            
            
            
            
           
            
            
        }];
        
        [task resume];
        
   

}


-(void)imageWithType:(NSString *)type{
    if ([type isEqualToString:@"多云"]) {
        self.weatherImage.image = [UIImage imageNamed:@"duoyun"];
    }else if ([type isEqualToString:@"晴"]){
        self.weatherImage.image = [UIImage imageNamed:@"qing"];
    }else if ([type isEqualToString:@"阴"]){
        self.weatherImage.image = [UIImage imageNamed:@"yin"];
    }else if ([type hasSuffix:@"雨"] && ![type hasPrefix:@"lei"]){
        self.weatherImage.image = [UIImage imageNamed:@"yu"];
    }else if ([type isEqualToString:@"雷阵雨"]){
        self.weatherImage.image = [UIImage imageNamed:@"lei"];
    }else if ([type hasSuffix:@"雪"]){
        self.weatherImage.image = [UIImage imageNamed:@"xue"];
    }else{
        self.weatherImage.image = [UIImage imageNamed:@"duoyun"];
    }
}


#pragma mark -位置发生了改变

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //NSLog(@"location == %@",locations[0]);
    //获取第一个元素
    CLLocation *location = locations.firstObject;
    
    //1.获取经纬度
    //    CLLocation *location = [locations lastObject];
    
    //维度
    CLLocationDegrees latitude = location.coordinate.latitude;
    
    //精度
    CLLocationDegrees longitude = location.coordinate.longitude;
    
    _userLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    // 打印经纬度信息
  //  NSLog(@"经度  == %f 纬度 ==  %f", location.coordinate.latitude, location.coordinate.longitude);
    NSLog(@"定位");
    
    [self geographicNi];
    
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorLocationUnknown) {
        
        //NSLog(@"无法获得位置信息");
        
    }
    
    if ([error code] == kCLErrorDenied) {
        
       // NSLog(@"访问被拒绝");
        
    }
}

//地理逆编码
- (void)geographicNi
{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:_userLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error)
     {
         
         if (!error)
         {
             CLPlacemark *mark = placemarks[0];
             NSString *city = [mark.addressDictionary objectForKey:@"City"];
             
             NSString *subLocality = [mark.addressDictionary objectForKey:@"SubLocality"];
             self.StrCity = city;
             self.StrProvinces = subLocality;
             
             self.city2Label.text = subLocality;
             self.weatherModel.city2 = self.city2Label.text;
             
             NSLog(@"%@,%@",city,subLocality);
             NSLog(@"%@",mark.addressDictionary);
             [self loadData];
         }
         //NSLog(@"编码完成");
     }];
    
}



//地理编码
- (void)geographic{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    NSString *Str = @"碧云寺路";
    [geocoder geocodeAddressString:Str completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        
//        CLPlacemark *placemake = placemarks.firstObject;
       
    }];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //停止定位
    [self.manger stopUpdatingLocation];
}

@end
