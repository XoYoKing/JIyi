//
//  CalendarController.m
//  日历
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "CalendarController.h"
#import "VRGCalendarView.h"

#define IOS6_LATER (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1)
@interface CalendarController ()<VRGCalendarViewDelegate>

{
    UIScrollView        *_detailScrollView;
    UILabel             *_lunarLabel;
    UILabel             *_constellationLabel;
    UILabel             *_weekdayLabel;
    UILabel             *_yiLabel;
    UILabel             *_jiLabel;
    UILabel             *_ganZhiLabel;
    UILabel             *_chongShaLabel;
    UILabel             *_wuXingLabel;
}

@end

@implementation CalendarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   // [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"日历";
    
#warning -- 添加背景 --
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //imageView.image = [UIImage imageNamed:@"rili.jpg"];
    
    //[self.view addSubview:imageView];

   
    self.view.backgroundColor = [[UIColor alloc] initWithRed:241/255.0 green:168/255.0 blue:114/255.0 alpha:1];
    
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    
    
    calendar.delegate=self;
    [self.view addSubview:calendar];
    calendar.backgroundColor = [[UIColor alloc] initWithRed:241/255.0 green:168/255.0 blue:114/255.0 alpha:1];
    
    // iOS 7 specific
   // self.navigationController.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        calendar.frame=CGRectMake(0, 20, calendar.frame.size.width, calendar.frame.size.height);
        
    }
    
    _detailScrollView=[[UIScrollView alloc] init];
    _detailScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_detailScrollView];
    NSLog(@"----%f",_detailScrollView.frame.size.width);
    _lunarLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [_lunarLabel setFont:[UIFont systemFontOfSize:16]];
    [_lunarLabel setTextColor:[UIColor blackColor]];
    [_detailScrollView addSubview:_lunarLabel];
    
       _constellationLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_lunarLabel.frame), 40, 20)];
    [_constellationLabel setFont:[UIFont systemFontOfSize:12]];
    [_constellationLabel setTextColor:[UIColor blackColor]];
    [_detailScrollView addSubview:_constellationLabel];
    
    _weekdayLabel =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_constellationLabel.frame), CGRectGetMaxY(_lunarLabel.frame), 100, 20)];
    [_weekdayLabel setFont:[UIFont systemFontOfSize:12]];
    [_weekdayLabel setTextColor:[UIColor blackColor]];
    [_detailScrollView addSubview:_weekdayLabel];
    
    //    [self calendarView:nil dateSelected:[NSDate date]];
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate]; // Get necessary date components
    
    [components month]; //gives you month
    [components day]; //gives you day
    [components year];
    
    if (month==[components month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [calendarView markDates:dates];
    }
    
    [_detailScrollView setFrame:CGRectMake(0, targetHeight+(IOS6_LATER?20:0),[UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height-targetHeight)];
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date lunarDict:(NSMutableDictionary*) dict
{
    [_lunarLabel setText:[dict objectForKey:@"LunarDate"]];
    [_constellationLabel setText:[dict objectForKey:@"Constellation"]];
    NSLog(@"1%@",_constellationLabel.text);
    [_weekdayLabel setText:[dict objectForKey:@"Weekday"]];
    
    [_yiLabel setText:[dict objectForKey:@"Yi"]];
    [_jiLabel setText:[dict objectForKey:@"Ji"]];
    [_ganZhiLabel setText:[dict objectForKey:@"ZodiacLunar"]];
    NSLog(@"2%@",_ganZhiLabel.text);
    [_chongShaLabel setText:[dict objectForKey:@"Chong"]];
    [_wuXingLabel setText:[dict objectForKey:@"WuXing"]];
}


@end
