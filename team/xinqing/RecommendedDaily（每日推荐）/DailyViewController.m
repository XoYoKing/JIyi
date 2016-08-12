//
//  DailyViewController.m
//  team
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "DailyViewController.h"

@interface DailyViewController ()

@property(nonatomic,strong)ModelForMeiwen *model;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *dailyView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;





@end

@implementation DailyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"每日一文";
    
    //关闭滑动反弹
    self.scrollView.bounces = NO;
//    self.scrollView.scrollEnabled = NO;
    
       
    //设置各个视图透明颜色
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.dailyView.backgroundColor = [UIColor clearColor];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self requerAllDatasWithString:nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requerAllDatasWithString:nil];
    
}



//请求数据
-(void)requerAllDatasWithString:(NSString *)string{
    
    //字符串拼接，根据日期，拼接成不同网址
    
    
    //获取今天日期（显示格式年月日）
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYYMMdd"];
    
    NSString *locationString=[dateformatter stringFromDate:senddate];
    string = locationString;
    
    NSString *stringUrl = [kHTTPMEIRIYIWEN stringByAppendingString:string];
    NSURL *url = [[NSURL alloc] initWithString:stringUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data == nil) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"访问失败" message:@"没有网了哦!" preferredStyle:UIAlertControllerStyleAlert];
                
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                });
                
            });
            
            
            
        }else
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            self.model = [[ModelForMeiwen alloc] init];
            [self.model setValuesForKeysWithDictionary:dict];
            
            self.titleLabel.text = self.model.title;
            self.authorLabel.text = self.model.author;
            
            //替换不必要字符串
            NSString *constr = [self.model.content stringByReplacingOccurrencesOfString:@"<p>" withString:@"    " ];
            NSString *contentStr = [constr stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
            
            self.contentLabel.text = contentStr;
            
            
        }

        
       
        
        
    }];
    [task resume];
    
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        if (data == nil) {
//            
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"访问失败" message:@"没有网了哦!" preferredStyle:UIAlertControllerStyleAlert];
//                
//                [self presentViewController:alertController animated:YES completion:^{
//                    
//                }];
//                
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    
//                    [self dismissViewControllerAnimated:YES completion:nil];
//                    
//                });
//                
//            });
//            
//
//            
//        }else
//        {
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//            
//            self.model = [[ModelForMeiwen alloc] init];
//            [self.model setValuesForKeysWithDictionary:dict];
//            
//            self.titleLabel.text = self.model.title;
//            self.authorLabel.text = self.model.author;
//            
//            //替换不必要字符串
//            NSString *constr = [self.model.content stringByReplacingOccurrencesOfString:@"<p>" withString:@"    " ];
//            NSString *contentStr = [constr stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
//            
//            self.contentLabel.text = contentStr;
//
//            
//        }
//           }];
//        
    
    
    
}



@end
