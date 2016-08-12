//
//  MainViewController.m
//  team
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UIScrollViewDelegate>





//心晴日记
@property (weak, nonatomic) IBOutlet UIView *diaryView;
- (IBAction)diaryAction:(UIButton *)sender;

//日程安排
@property (weak, nonatomic) IBOutlet UIView *scheduleView;
- (IBAction)scheduleAction:(UIButton *)sender;

//生日提醒
@property (weak, nonatomic) IBOutlet UIView *birthdayView;
- (IBAction)birthdayAction:(UIButton *)sender;

//每日推荐
- (IBAction)recommendedDaily:(UIButton *)sender;

//天气查询
- (IBAction)weatherAction:(UIButton *)sender;

//扫一扫
- (IBAction)QRCodeAction:(UIButton *)sender;


//日历
- (IBAction)calendarAction:(UIButton *)sender;





@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIBarButtonItem *back = [[UIBarButtonItem alloc]init];
    back.title = @"返回";
    self.navigationItem.backBarButtonItem = back;
    
    
    
    //title
    
    self.title = @"迹忆";
    
    YYCycleScrollView *cycleScrollView = [[YYCycleScrollView alloc] initWithFrame:CGRectMake(0, self.view.frame.origin.y+69, self.view.frame.size.width, self.view.frame.size.height*0.28) animationDuration:2.0];

    cycleScrollView.scrollView.pagingEnabled = YES;
    
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.28)];
        tempImageView.backgroundColor = [UIColor redColor];
        
        tempImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"lunbo%d",i+1]];
        tempImageView.contentMode = UIViewContentModeScaleAspectFill;
        tempImageView.clipsToBounds = true;
        [viewArray addObject:tempImageView];
    }
    [cycleScrollView setFetchContentViewAtIndex:^UIView *(NSInteger(pageIndex)) {
        return [viewArray objectAtIndex:pageIndex];
    }];
    [cycleScrollView setTotalPagesCount:^NSInteger{
        return 3;
    }];
    [cycleScrollView setTapActionBlock:^(NSInteger(pageIndex)) {
        
        NSLog(@"点击的相关的页面%ld",(long)pageIndex);
        if (pageIndex == 0) {
            DailyViewController *dailyVC = [[UIStoryboard storyboardWithName:@"NIU" bundle:nil] instantiateViewControllerWithIdentifier:@"dailyVC"];;
            [self.navigationController showViewController:dailyVC sender:nil];
        }else if (pageIndex ==1){
          
            WriteDiaryViewController *writeDiary = [WriteDiaryViewController new];
            [self.navigationController showViewController:writeDiary sender:nil];
        }else{
            CustomTableViewController *listTVC = [[CustomTableViewController alloc] init];
            [self.navigationController showViewController:listTVC sender:nil];

        }
        
        
    }];
    
    
    [self.view addSubview:cycleScrollView];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//日记界面
- (IBAction)diaryAction:(UIButton *)sender {
    
    WriteDiaryViewController *writeDiary = [WriteDiaryViewController new];
    [self.navigationController showViewController:writeDiary sender:nil];
    
}

//日程安排
- (IBAction)scheduleAction:(UIButton *)sender {
    
    CustomTableViewController *listTVC = [[CustomTableViewController alloc] init];
    [self.navigationController showViewController:listTVC sender:nil];
}

//生日提醒
- (IBAction)birthdayAction:(UIButton *)sender {
    BirthdayViewController *birthdayVC = [BirthdayViewController new];
    [self.navigationController showViewController:birthdayVC sender:nil];
    
    
}

//每日推荐界面
- (IBAction)recommendedDaily:(UIButton *)sender {
    
    DailyViewController *dailyVC = [[UIStoryboard storyboardWithName:@"NIU" bundle:nil] instantiateViewControllerWithIdentifier:@"dailyVC"];;
    [self.navigationController showViewController:dailyVC sender:nil];
    
}

//天气界面
- (IBAction)weatherAction:(UIButton *)sender {

    WeatherViewController *weatherVC = [[UIStoryboard storyboardWithName:@"NIU" bundle:nil] instantiateViewControllerWithIdentifier:@"weatherVC"];
    [self.navigationController showViewController:weatherVC sender:nil];


}

//扫一扫
- (IBAction)QRCodeAction:(UIButton *)sender {
    
    QRViewController *qrVC = [[UIStoryboard storyboardWithName:@"NIU" bundle:nil] instantiateViewControllerWithIdentifier:@"qrView"];
    [self.navigationController showViewController:qrVC sender:nil];
    
}

//日历
- (IBAction)calendarAction:(UIButton *)sender {
    
    CalendarController *calendar = [CalendarController new];
    [self.navigationController showViewController:calendar sender:nil];
}



@end
