//
//  InfoViewController.m
//  时间印记
//
//  Created by lanou3g on 15/10/24.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()<UIScrollViewDelegate,UIApplicationDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *therdButton;
- (IBAction)firstAction:(UIButton *)sender;
- (IBAction)secondAction:(UIButton *)sender;
- (IBAction)therdAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   

    self.pageControl.numberOfPages = 3;
    
    self.pageControl.currentPage = 0;
    
    self.pageControl.backgroundColor = [UIColor redColor];

    [self.pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventValueChanged];

    self.scrollView.delegate = self;
    
    self.scrollView.bounces = NO;


}

-(void)pageControlAction:(UIPageControl *)sender{
    
    //可以通过currentPage获取当前第几个点
    NSLog(@"%ld",(long)sender.currentPage);
    
    CGPoint offset = CGPointMake(self.scrollView.frame.size.width*sender.currentPage, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}



//当视图完全停止的时候执行（减速结束）
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //使用偏移量 除以 scrollView 的宽度，得到当前页数的下标
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    //赋值给小点点
    self.pageControl.currentPage = index;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)firstAction:(UIButton *)sender {
    
    self.pageControl.currentPage = 1;
    CGPoint offset = CGPointMake(self.scrollView.frame.size.width*1, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

- (IBAction)secondAction:(UIButton *)sender {
    self.pageControl.currentPage = 2;
    CGPoint offset = CGPointMake(self.scrollView.frame.size.width*2, 0);
    [self.scrollView setContentOffset:offset animated:YES];

}

- (IBAction)therdAction:(UIButton *)sender {
    
    
    NSLog(@"已经不是第一次启动了");

    
    
    
    
    
        
    
//    MainViewController *mainVC = [[UIStoryboard storyboardWithName:@"NIU" bundle:nil] instantiateViewControllerWithIdentifier:@"mainVC"];
    
    MainNavigationViewController *mainNavigationController = [[UIStoryboard storyboardWithName:@"NIU" bundle:nil] instantiateViewControllerWithIdentifier:@"mainNavigation"];
    UIColor *color = [[UIColor alloc] initWithRed:237/255.0 green:138/255.0 blue:78/255.0 alpha:0.8];
    [[UINavigationBar appearance] setBarTintColor:color];

    
    
    //程序启动，注册通知
    
    UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc]init];
    action1.identifier = @"aaa";
    action1.title = @"确定";
    action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
    action1.authenticationRequired = YES;
    action1.destructive = YES;
    
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc]init];
    action2.identifier = @"bbb";
    action2.title = @"取消";
    action2.activationMode = UIUserNotificationActivationModeBackground;
    
    UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc]init];
    categorys.identifier = @"ccc";//这组动作的唯一标示
    [categorys setActions:@[action1,action2] forContext:UIUserNotificationActionContextMinimal];
    
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert |UIUserNotificationTypeSound |UIUserNotificationTypeBadge)categories:[NSSet setWithObjects:categorys, nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    

    
    
   
    [self showViewController:mainNavigationController sender:nil];
    
    
}














@end
