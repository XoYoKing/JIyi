//
//  AppDelegate.m
//  team
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#pragma mark ++++ 3D Touch +++++++
    //不在info.plist中添加行，动态创建标签
    //创建方式有多种，下面举得例子为创建可变的标签
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"imageName"];
    UIMutableApplicationShortcutItem *item = [[UIMutableApplicationShortcutItem alloc] initWithType:@"diary" localizedTitle:@"心晴日记" localizedSubtitle:@"记录此刻" icon:icon userInfo:@{@"key": @"value"}];
    
    
    
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"imageName"];
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"schedule" localizedTitle:@"日程提醒" localizedSubtitle:@"添加提醒" icon:icon1 userInfo:@{@"key": @"value"}];
    [UIApplication sharedApplication].shortcutItems = @[item1,item];

    
       
    
    
    
    
    
    
    
    
    
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        
        InfoViewController *infoVC = [[InfoViewController alloc] init];
        
        self.window.rootViewController = infoVC;
        
        
        self.m_opened = NO;
        
        NSLog(@"第一次启动");
    }else {
        
         self.m_opened = YES;
        
       NSLog(@"已经不是第一次启动了");
        
        MainNavigationViewController *mainNavigationController = [[UIStoryboard storyboardWithName:@"NIU" bundle:nil] instantiateViewControllerWithIdentifier:@"mainNavigation"];
        
        
        
        //一键换肤(统一修改UI)
        
        UIColor *color = [[UIColor alloc] initWithRed:237/255.0 green:138/255.0 blue:78/255.0 alpha:0.8];
        [[UINavigationBar appearance] setBarTintColor:color];
        
        
        self.window.rootViewController = mainNavigationController;
        
    }

#pragma mark模型
    
    [self model1];
    [self model2];
    [self model3];
    [self model4];
    [self model5];
    [self model5];
    [self model6];
    
#pragma mark 来自友盟的社会化分享
    [UMSocialData setAppKey:@"5645a32ce0f55afcea001210"];
    
     return YES;
}


#pragma mark -- 接收到通知的时候触发 --

//本地推送通知
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //成功注册registerUserNotificationSettings:后，回调的方法
    NSLog(@"%@",notificationSettings);
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:notification.alertBody delegate:self cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
    [alertView show];
    
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge--;
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
    
    //收到本地推送消息后调用的方法
    NSLog(@"%@",notification);
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
{
    //在非本App界面时收到本地消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法，根据identifier来判断点击的哪个按钮，notification为消息内容
    //    if ([identifier isEqualToString:@"aaa"]) {
    //        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"嘿嘿" message:@"fff" delegate:self cancelButtonTitle:@"ff" otherButtonTitles:@"ttt", nil];
    //        [view show];
    //    }
    
    //NSLog(@"%@----%@",identifier,notification);
    
    completionHandler();//处理完消息，最后一定要调用这个代码块
    
}







- (void)model1
{
#pragma mark 模型1
    //图片1的frame
    CGRect frame11 =  CGRectMake(10,Height * 0.02808,Width *0.4445  , Width *0.4445);
    //mainScroll的frame
    CGRect frame71 =  CGRectMake(0, 0, Width, Height);
    //标题
    CGRect frame81 =  CGRectMake(Width * 0.4889,Height *0.1667 ,Width * 0.4665, 30);
    
    
    
    
    
    //心情的内容
    CGRect frame91 = CGRectNull;
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        NSLog(@"4s 3.7");
        frame91 =  CGRectMake(10,Height *0.32692 , (Width - 20) ,Height * 0.400641);
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
    {
        NSLog(@"5s 4");
        frame91 =  CGRectMake(10,Height *0.32692 , (Width - 20) ,Height * 0.400641);
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
    {
        NSLog(@"6 4.7");
        frame91 =  CGRectMake(10,Height *0.32692 , (Width - 20) ,Height * 0.475641);
    }
    else
    {
        NSLog(@"6plus 5.5");
        frame91 =  CGRectMake(10,Height *0.32692 , (Width - 20) ,Height * 0.475641);
        
    }
    
    
    
    
    
    //时间
    CGRect frame101 =  CGRectMake(Width  - 110,Height - 64 -30  , 100 , 30);
    
    NSString *string11 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame11)];
    NSString *string71 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame71)];
    NSString *string81 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame81)];
    NSString *string91 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame91)];
    NSString *string101 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame101)];
    
    NSArray *array1 = [NSArray arrayWithObjects:string11,string71,string81,string91,string101,nil];
    
    NSString * path1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path1 = [path1 stringByAppendingPathComponent:@"/FFFframe1frame1frame1"];
    [array1 writeToFile:path1 atomically:YES];
    
}


- (void)model2
{
#pragma mark 模型6
    //图片1的frame
    CGRect frame1 =  CGRectMake(10,Height * 0.02808,Width *0.4445  , Width *0.4445);    CGRect frame2 =  CGRectMake(Width * 0.51136 , Height * 0.01408, Width *0.32954, Width *0.32954);
    
    //mainScroll的frame
    CGRect frame7 =  CGRectMake(0, 0, Width, Height);
    //标题
    CGRect frame8 =  CGRectMake(Width * 0.4889,Height *0.27142 ,Width * 0.4665, 30);
    //心情的内容
    //    CGRect frame9 =  CGRectMake(10,Height *0.32692 , (Width - 20) ,Height * 0.475641);
    CGRect frame9 =  CGRectNull;
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        NSLog(@"4s 3.7");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 20) ,Height * 0.400641);
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
    {
        NSLog(@"5s 4");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 20) ,Height * 0.400641);
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
    {
        NSLog(@"6 4.7");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 20) ,Height * 0.475641);
    }
    else
    {
        NSLog(@"6plus 5.5");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 20) ,Height * 0.475641);
    }
    
    
    
    
    //时间
    CGRect frame10 =  CGRectMake(Width  - 110,Height - 64 -30  , 100 , 30);
    NSString *string1 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame1)];
    NSString *string2 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame2)];
    NSString *string7 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame7)];
    NSString *string8 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame8)];
    NSString *string9 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame9)];
    NSString *string10 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame10)];
    
    
    NSArray *array = [NSArray arrayWithObjects:string1,string2,string7,string8,string9,string10,nil];
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"/FFFframe2frame2frame2"];
    [array writeToFile:path atomically:YES];
    
}

- (void)model3
{
#pragma mark 模型3
    CGRect frame1 =  CGRectMake(10,Height * 0.02808,Width *0.4445  , Width *0.4445);
    CGRect frame2 =  CGRectMake(Width * 0.51136 , Height * 0.01408, Width *0.32954, Width *0.32954);
    CGRect frame3 =  CGRectMake(((Width - 30)/2) + 20, Height * 0.37732 ,(Width - 30) /2, (Width - 30) /2);
    
    //mainScroll的frame
    CGRect frame7 =  CGRectMake(0, 0, Width, Height);
    //标题
    CGRect frame8 =  CGRectMake(Width * 0.4889,Height *0.27142 ,Width * 0.4665, 30);
    //心情的内容
    //    CGRect frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2 ,Height * 0.475641);
    CGRect frame9 =  CGRectNull;
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        NSLog(@"4s 3.7");
        frame9 =  CGRectMake(10,Height *0.32692 ,(Width - 30) /2 ,Height * 0.400641);
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
    {
        NSLog(@"5s 4");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2 ,Height * 0.400641);
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
    {
        NSLog(@"6 4.7");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2 ,Height * 0.475641);
    }
    else
    {
        NSLog(@"6plus 5.5");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2 ,Height * 0.475641);
    }
    
    
    //时间
    CGRect frame10 =  CGRectMake(Width  - 110,Height - 64 -30  , 100 , 30);
    
    
    
    
    NSString *string1 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame1)];
    NSString *string2 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame2)];
    NSString *string3 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame3)];
    NSString *string7 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame7)];
    NSString *string8 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame8)];
    NSString *string9 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame9)];
    NSString *string10 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame10)];
    
    
    NSArray *array = [NSArray arrayWithObjects:string1,string2,string3,string7,string8,string9,string10,nil];
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"/FFFframe3frame3frame3"];
    [array writeToFile:path atomically:YES];
    
}

- (void)model4
{
#pragma mark 模型3
    CGRect frame1 =  CGRectMake(10,Height * 0.02808,Width *0.4445  , Width *0.4445);
    CGRect frame2 =  CGRectMake(Width * 0.51136 , Height * 0.01408, Width *0.32954, Width *0.32954);
    CGRect frame3 =  CGRectMake(((Width - 30)/2) + 10, Height *0.31692 ,Width * 0.31909, Width * 0.32909);
    CGRect frame4 =  CGRectMake(((Width - 30)/2) + 10, Height * 0.535211  ,Height * 0.25641, Height * 0.25641);
    
    
    //mainScroll的frame
    CGRect frame7 =  CGRectMake(0, 0, Width, Height);
    //标题
    CGRect frame8 =  CGRectMake(Width * 0.4889,Height *0.27142 ,Width * 0.4665, 30);
    //心情的内容
    //    CGRect frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2 ,Height * 0.475641);
    CGRect frame9 =  CGRectNull;
    
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        NSLog(@"4s 3.7");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2 ,Height * 0.400641);
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
    {
        NSLog(@"5s 4");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2,Height * 0.400641);
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
    {
        NSLog(@"6 4.7");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2 ,Height * 0.475641);
    }
    else
    {
        NSLog(@"6plus 5.5");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2 ,Height * 0.475641);
    }
    
    //时间
    CGRect frame10 =  CGRectMake(Width  - 110,Height - 64 -30  , 100 , 30);
    
    
    NSString *string1 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame1)];
    NSString *string2 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame2)];
    NSString *string3 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame3)];
    NSString *string4 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame4)];
    NSString *string7 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame7)];
    NSString *string8 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame8)];
    NSString *string9 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame9)];
    NSString *string10 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame10)];
    
    
    NSArray *array = [NSArray arrayWithObjects:string1,string2,string3,string4,string7,string8,string9,string10,nil];
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"/FFFframe4frame4frame4"];
    [array writeToFile:path atomically:YES];
    
    
    
}

- (void)model5
{
#pragma mark 模型5
    CGRect frame1 =  CGRectMake(10,Height * 0.02808,Width *0.4445  , Width *0.4445);
    CGRect frame2 =  CGRectMake(Width * 0.51136 , Height * 0.01408, Width *0.32954, Width *0.32954);
    CGRect frame3 =  CGRectMake(((Width - 30)/2) + 10, Height *0.33292 ,Width * 0.22727, Width * 0.22727);
    CGRect frame4 =  CGRectMake(Width * 0.65909,Height * 0.4085  ,Width * 0.27083, Width * 0.27083);
    
    CGRect frame5 =   CGRectMake(((Width - 30)/2) + 10, Height * 0.555211  ,Height * 0.22641, Height * 0.22641);
    
    
    
    
    
    
    //mainScroll的frame
    CGRect frame7 =  CGRectMake(0, 0, Width, Height);
    //标题
    CGRect frame8 =  CGRectMake(Width * 0.4889,Height *0.27142 ,Width * 0.4665, 30);
    //心情的内容
    //    CGRect frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2 ,Height * 0.475641);
    CGRect frame9 =  CGRectNull;
    
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        NSLog(@"4s 3.7");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2,Height * 0.400641);
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
    {
        NSLog(@"5s 4");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2,Height * 0.400641);
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
    {
        NSLog(@"6 4.7");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2,Height * 0.475641);
    }
    else
    {
        NSLog(@"6plus 5.5");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2 ,Height * 0.475641);
    }
    
    //时间
    CGRect frame10 =  CGRectMake(Width  - 110,Height - 64 -30  , 100 , 30);
    
    
    NSString *string1 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame1)];
    NSString *string2 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame2)];
    NSString *string3 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame3)];
    NSString *string4 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame4)];
    NSString *string5 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame5)];
    NSString *string7 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame7)];
    NSString *string8 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame8)];
    NSString *string9 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame9)];
    NSString *string10 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame10)];
    
    
    NSArray *array = [NSArray arrayWithObjects:string1,string2,string3,string4,string5,string7,string8,string9,string10,nil];
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"/FFFframe5frame5frame5"];
    [array writeToFile:path atomically:YES];
    
    
}







- (void)model6
{
#pragma mark 模型6
    CGRect frame1 =  CGRectMake(10,Height * 0.02808,Width *0.4445  , Width *0.4445);
    CGRect frame2 =  CGRectMake(Width * 0.45181818 , Height * 0.013808, Width *0.25, Width *0.25);
    CGRect frame3 =  CGRectMake((Width  - 10) - (Width * 0.27083), Height *0.27142 -(Width * 0.27083)  ,Width * 0.27083, Width * 0.27083);
    CGRect frame4 =  CGRectMake(((Width - 30)/2) + 10, Height *0.33292 ,Width * 0.22727, Width * 0.22727);
    
    CGRect frame5 =   CGRectMake(Width * 0.65909,Height * 0.4085  ,Width * 0.27083, Width * 0.27083);
    CGRect frame6 =   CGRectMake(((Width - 30)/2) + 10, Height * 0.555211  ,Height * 0.22641, Height * 0.22641);
    
    
    
    
    //mainScroll的frame
    CGRect frame7 =  CGRectMake(0, 0, Width, Height);
    //标题
    CGRect frame8 =  CGRectMake(Width * 0.4889,Height *0.27142 ,Width * 0.4665, 30);
    //心情的内容
    //    CGRect frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2 ,Height * 0.475641);
    CGRect frame9 =  CGRectNull;
    
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        NSLog(@"4s 3.7");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2 ,Height * 0.400641);
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
    {
        NSLog(@"5s 4");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2 ,Height * 0.400641);
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
    {
        NSLog(@"6 4.7");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2 ,Height * 0.475641);
    }
    else
    {
        NSLog(@"6plus 5.5");
        frame9 =  CGRectMake(10,Height *0.32692 , (Width - 30) /2 ,Height * 0.475641);
    }
    
    //时间
    CGRect frame10 =  CGRectMake(Width  - 110,Height - 64 -30  , 100 , 30);
    NSString *string1 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame1)];
    NSString *string2 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame2)];
    NSString *string3 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame3)];
    NSString *string4 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame4)];
    NSString *string5 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame5)];
    NSString *string6 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame6)];
    NSString *string7 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame7)];
    NSString *string8 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame8)];
    NSString *string9 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame9)];
    NSString *string10 = [NSString stringWithFormat:@"%@",NSStringFromCGRect(frame10)];
    
    
    NSArray *array = [NSArray arrayWithObjects:string1,string2,string3,string4,string5,string6,string7,string8,string9,string10,nil];
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"/FFFframe6frame6frame6"];
    [array writeToFile:path atomically:YES];
    
    
}











- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
    NSLog(@"shortcutItem%@", shortcutItem);
    
    if ([shortcutItem.type isEqualToString: @"diary"]) {
    
        WriteDiaryViewController *writeDiary = [WriteDiaryViewController new];
    [self.window.rootViewController showViewController:writeDiary sender:nil];

    }else if ([shortcutItem.type isEqualToString: @"schedule"]){
        
        CustomTableViewController *listTVC = [[CustomTableViewController alloc] init];
        [self.window.rootViewController showViewController:listTVC sender:nil];
        
     }
    
    
}


@end
