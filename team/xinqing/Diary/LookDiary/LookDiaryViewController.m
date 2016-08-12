//
//  LookDiaryViewController.m
//  team
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "LookDiaryViewController.h"
//#import "ViewImg1.h"
#import "ViewModel.h"
#import "ModelColor.h"
@interface LookDiaryViewController ()<UMSocialUIDelegate>
//@property (nonatomic,strong)ViewImg1 *viewimg;
@property (nonatomic,strong)ViewModel *viewModel;
@property (nonatomic,strong)UIImage *image;
@end

@implementation LookDiaryViewController
-(void)loadView
{
 
        
      
        self.viewModel = [[ViewModel alloc] initWithFrame:Bounds];
        
        self.view = self.viewModel;
        
        self.viewModel.backgroundColor = [UIColor whiteColor];
   
    
    
}

- (void)share
{
    CGSize size = CGSizeMake(Width, Height);
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    
 
    
    UIGraphicsEndImageContext();
    
    
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5645a32ce0f55afcea001210"
                                      shareText:self.viewModel.textView.text
                                     shareImage:self.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,nil]
                                       delegate:self];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    
    
    
    
    self.viewModel.textView.editable = NO;
    
    
    
    
    
}

- (void)backAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    self.viewModel.scrollViewMain.bounces = YES;
    self.viewModel.scrollViewMain.contentSize = CGSizeMake(Width, (Height * 1.5) + 216);
    
    
    

    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:self.name];
    

    NSString *strFont = array[0];
    NSString *strSize = array[1];
    CGFloat fontFlot = [strSize floatValue];
    
    self.viewModel.textView.font = [UIFont fontWithName:strFont size:fontFlot];
    //颜色
    NSString *strRed = array[2];
    NSString *strGreen = array[3];
    NSString *strBlue = array[4];
    CGFloat Red = [strRed floatValue];
    CGFloat Green = [strGreen floatValue];
    CGFloat Blue = [strBlue floatValue];
    
    self.viewModel.textView.textColor = [UIColor colorWithRed:Red green:Green blue:Blue alpha:1];
    

    if ([self.index isEqualToString:@"1"]) {
        
        [self loadData1];
      
       [self.viewModel.imageViewMain setImage:[UIImage imageNamed:@"2211"]];
       
    }else if ([self.index isEqualToString:@"2"])
    {
        
        [self loadData2];
        [self.viewModel.imageViewMain setImage:[UIImage imageNamed:@"2227"]];
    }else if ([self.index isEqualToString:@"3"])
    {
        
        [self loadData3];
         [self.viewModel.imageViewMain setImage:[UIImage imageNamed:@"2223"]];
    }else if ([self.index isEqualToString:@"4"])
    {
        
        [self loadData4];
     [self.viewModel.imageViewMain setImage:[UIImage imageNamed:@"2224"]];
    }else if ([self.index isEqualToString:@"5"])
    {
        
        [self loadData5];
           [self.viewModel.imageViewMain setImage:[UIImage imageNamed:@"2225"]];
    }else
    {
         [self loadData];
           [self.viewModel.imageViewMain setImage:[UIImage imageNamed:@"2226"]];
    }
    
    
  
}

- (void)loadData1
{
    [[DBManager showDBManager] openDBManager];
    
    NSArray *array = [[DBManager showDBManager] selectTitle:self.name];
    
    [[DBManager showDBManager] closeDBmanager];
    
    Diary *diary = array[0];
    
    NSArray *arrayTime = [diary.time componentsSeparatedByString:@"&"];
    
    self.viewModel.labelTime.text = arrayTime[0];
    self.viewModel.labelName.text = diary.name;
    self.viewModel.textView.text = diary.textContact;
    
    
    //从本地区图片
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingFormat:@"/%@",diary.name];
    
    NSLog(@"%@",path);
    
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    
    NSKeyedUnarchiver *kedUN = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    NSArray *arrayImg = [kedUN decodeObject];
    [kedUN finishDecoding];
    
    self.viewModel.imagView1.image = arrayImg[0];

    self.viewModel.control1.hidden = YES;
    self.viewModel.control2.hidden = YES;
    self.viewModel.control3.hidden = YES;
    self.viewModel.control4.hidden = YES;
    self.viewModel.control5.hidden = YES;
    self.viewModel.control6.hidden = YES;
    
    
    NSString * path111 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path111 = [path111 stringByAppendingPathComponent:@"/FFFframe1frame1frame1"];
    NSArray *array111 = [NSArray arrayWithContentsOfFile:path111];
    
    self.viewModel.imagView1.frame =  CGRectFromString(array111[0]);
   
    self.viewModel.imageViewMain.frame = CGRectFromString(array111[1]);
    self.viewModel.imageViewMain.backgroundColor = Gray;
    self.viewModel.labelName .frame = CGRectFromString(array111[2]);
    self.viewModel.textView .frame = CGRectFromString(array111[3]);
    self.viewModel.labelTime .frame = CGRectFromString(array111[4]);
    
    
    self.viewModel.imagView1.layer.cornerRadius = self.viewModel.imagView1.frame.size.width/2;
    
    self.viewModel.labelName.hidden = NO;
    
    self.viewModel.scrollViewMain.contentSize = CGSizeMake(self.viewModel.imageViewMain.frame.size.width, self.viewModel.imageViewMain.frame.size.height - 64);
    self.viewModel.scrollViewMain.bounces = NO;

}

//模型2
- (void)loadData2
{
    [[DBManager showDBManager] openDBManager];
    
    NSArray *array = [[DBManager showDBManager] selectTitle:self.name];
    
    [[DBManager showDBManager] closeDBmanager];
    
    Diary *diary = array[0];
    
    NSArray *arrayTime = [diary.time componentsSeparatedByString:@"&"];
    
    self.viewModel.labelTime.text = arrayTime[0];
    self.viewModel.labelName.text = diary.name;
    self.viewModel.textView.text = diary.textContact;
    
    
    //从本地区图片
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingFormat:@"/%@",diary.name];
    
    NSLog(@"%@",path);
    
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    
    NSKeyedUnarchiver *kedUN = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    NSArray *arrayImg = [kedUN decodeObject];
    [kedUN finishDecoding];
    
    self.viewModel.imagView1.image = arrayImg[0];
    
    self.viewModel.imagView2.image = arrayImg[1];
   
    self.viewModel.control1.hidden = YES;
    self.viewModel.control2.hidden = YES;
    self.viewModel.control3.hidden = YES;
    self.viewModel.control4.hidden = YES;
    self.viewModel.control5.hidden = YES;
    self.viewModel.control6.hidden = YES;
    
    
    NSString * path111 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path111 = [path111 stringByAppendingPathComponent:@"/FFFframe2frame2frame2"];
    NSArray *array111 = [NSArray arrayWithContentsOfFile:path111];
    
    self.viewModel.imagView1.frame =  CGRectFromString(array111[0]);
    self.viewModel.imagView2.frame = CGRectFromString(array111[1]);
      self.viewModel.imageViewMain.frame = CGRectFromString(array111[2]);
    self.viewModel.labelName .frame = CGRectFromString(array111[3]);
    self.viewModel.textView .frame = CGRectFromString(array111[4]);
    self.viewModel.labelTime .frame = CGRectFromString(array111[5]);
    
    
    self.viewModel.imagView1.layer.cornerRadius = self.viewModel.imagView1.frame.size.width/2;
    
    self.viewModel.imagView2.layer.cornerRadius = self.viewModel.imagView2.frame.size.width/2;
    
    self.viewModel.labelName.hidden = NO;
    
    
    self.viewModel.imageViewMain.backgroundColor = Gray;
   self.viewModel.scrollViewMain.contentSize = CGSizeMake(self.viewModel.imageViewMain.frame.size.width, self.viewModel.imageViewMain.frame.size.height - 64);
    self.viewModel.scrollViewMain.bounces = NO;
    
    
    
    
   
}
//Model3
- (void)loadData3
{
    [[DBManager showDBManager] openDBManager];
    
    NSArray *array = [[DBManager showDBManager] selectTitle:self.name];
    
    [[DBManager showDBManager] closeDBmanager];
    
    Diary *diary = array[0];
    
    NSArray *arrayTime = [diary.time componentsSeparatedByString:@"&"];
    
    self.viewModel.labelTime.text = arrayTime[0];
    self.viewModel.labelName.text = diary.name;
    self.viewModel.textView.text = diary.textContact;
    
    
    //从本地区图片
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingFormat:@"/%@",diary.name];
    
    NSLog(@"%@",path);
    
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    
    NSKeyedUnarchiver *kedUN = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    NSArray *arrayImg = [kedUN decodeObject];
    [kedUN finishDecoding];
    
    self.viewModel.imagView1.image = arrayImg[0];
    
    self.viewModel.imagView2.image = arrayImg[1];
    self.viewModel.imagView3.image = arrayImg[2];
        self.viewModel.control1.hidden = YES;
    self.viewModel.control2.hidden = YES;
    self.viewModel.control3.hidden = YES;
    self.viewModel.control4.hidden = YES;
    self.viewModel.control5.hidden = YES;
    self.viewModel.control6.hidden = YES;
    
    
    NSString * path111 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path111 = [path111 stringByAppendingPathComponent:@"/FFFframe3frame3frame3"];
    NSArray *array111 = [NSArray arrayWithContentsOfFile:path111];
    
    self.viewModel.imagView1.frame =  CGRectFromString(array111[0]);
    self.viewModel.imagView2.frame = CGRectFromString(array111[1]);
    self.viewModel.imagView3.frame = CGRectFromString(array111[2]);
     self.viewModel.imageViewMain.frame = CGRectFromString(array111[3]);
    self.viewModel.labelName .frame = CGRectFromString(array111[4]);
    self.viewModel.textView .frame = CGRectFromString(array111[5]);
    self.viewModel.labelTime .frame = CGRectFromString(array111[6]);
    
    
    self.viewModel.imagView1.layer.cornerRadius = self.viewModel.imagView1.frame.size.width/2;
    
    self.viewModel.imagView2.layer.cornerRadius = self.viewModel.imagView2.frame.size.width/2;
    
    self.viewModel.imagView3.layer.cornerRadius = self.viewModel.imagView3.frame.size.width/2;
    
 
    
    self.viewModel.labelName.hidden = NO;

    self.viewModel.imageViewMain.backgroundColor = Gray;
    self.viewModel.scrollViewMain.contentSize = CGSizeMake(self.viewModel.imageViewMain.frame.size.width, self.viewModel.imageViewMain.frame.size.height - 64);
    self.viewModel.scrollViewMain.bounces = NO;
    
    
}

//模型4
- (void)loadData4
{
    
    [[DBManager showDBManager] openDBManager];
    
    NSArray *array = [[DBManager showDBManager] selectTitle:self.name];
    
    [[DBManager showDBManager] closeDBmanager];
    
    Diary *diary = array[0];
    
    NSArray *arrayTime = [diary.time componentsSeparatedByString:@"&"];
    
    self.viewModel.labelTime.text = arrayTime[0];
    self.viewModel.labelName.text = diary.name;
    self.viewModel.textView.text = diary.textContact;
    
    
    //从本地区图片
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingFormat:@"/%@",diary.name];
    
    NSLog(@"%@",path);
    
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    
    NSKeyedUnarchiver *kedUN = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    NSArray *arrayImg = [kedUN decodeObject];
    [kedUN finishDecoding];
    
    self.viewModel.imagView1.image = arrayImg[0];
    
    self.viewModel.imagView2.image = arrayImg[1];
    self.viewModel.imagView3.image = arrayImg[2];
    self.viewModel.imagView4.image = arrayImg[3];
  
    self.viewModel.control1.hidden = YES;
    self.viewModel.control2.hidden = YES;
    self.viewModel.control3.hidden = YES;
    self.viewModel.control4.hidden = YES;
    self.viewModel.control5.hidden = YES;
    self.viewModel.control6.hidden = YES;
    
    
    NSString * path111 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path111 = [path111 stringByAppendingPathComponent:@"/FFFframe4frame4frame4"];
    NSArray *array111 = [NSArray arrayWithContentsOfFile:path111];
    
    self.viewModel.imagView1.frame =  CGRectFromString(array111[0]);
    self.viewModel.imagView2.frame = CGRectFromString(array111[1]);
    self.viewModel.imagView3.frame = CGRectFromString(array111[2]);
    self.viewModel.imagView4.frame = CGRectFromString(array111[3]);

    self.viewModel.imageViewMain.frame = CGRectFromString(array111[4]);
    self.viewModel.labelName .frame = CGRectFromString(array111[5]);
    self.viewModel.textView .frame = CGRectFromString(array111[6]);
    self.viewModel.labelTime .frame = CGRectFromString(array111[7]);
    
    
    self.viewModel.imagView1.layer.cornerRadius = self.viewModel.imagView1.frame.size.width/2;
    
    self.viewModel.imagView2.layer.cornerRadius = self.viewModel.imagView2.frame.size.width/2;
    
    self.viewModel.imagView3.layer.cornerRadius = self.viewModel.imagView3.frame.size.width/2;
    
    self.viewModel.imagView4.layer.cornerRadius = self.viewModel.imagView4.frame.size.width/2;
    
    
    self.viewModel.labelName.hidden = NO;
    
   
    
    self.viewModel.scrollViewMain.contentSize = CGSizeMake(self.viewModel.imageViewMain.frame.size.width, self.viewModel.imageViewMain.frame.size.height - 64);
    self.viewModel.scrollViewMain.bounces = NO;

    
    

}

- (void)loadData5
{
    [[DBManager showDBManager] openDBManager];
    
    NSArray *array = [[DBManager showDBManager] selectTitle:self.name];
    
    [[DBManager showDBManager] closeDBmanager];
    
    Diary *diary = array[0];
    
    NSArray *arrayTime = [diary.time componentsSeparatedByString:@"&"];
    
    self.viewModel.labelTime.text = arrayTime[0];
    self.viewModel.labelName.text = diary.name;
    self.viewModel.textView.text = diary.textContact;
    
    
    //从本地区图片
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingFormat:@"/%@",diary.name];
    
    NSLog(@"%@",path);
    
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    
    NSKeyedUnarchiver *kedUN = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    NSArray *arrayImg = [kedUN decodeObject];
    [kedUN finishDecoding];
    
    self.viewModel.imagView1.image = arrayImg[0];
    
    self.viewModel.imagView2.image = arrayImg[1];
    self.viewModel.imagView3.image = arrayImg[2];
    self.viewModel.imagView4.image = arrayImg[3];
    self.viewModel.imagView5.image = arrayImg[4];
 
    self.viewModel.control1.hidden = YES;
    self.viewModel.control2.hidden = YES;
    self.viewModel.control3.hidden = YES;
    self.viewModel.control4.hidden = YES;
    self.viewModel.control5.hidden = YES;
    self.viewModel.control6.hidden = YES;
    
    
    NSString * path111 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path111 = [path111 stringByAppendingPathComponent:@"/FFFframe5frame5frame5"];
    NSArray *array111 = [NSArray arrayWithContentsOfFile:path111];
    
    self.viewModel.imagView1.frame =  CGRectFromString(array111[0]);
    self.viewModel.imagView2.frame = CGRectFromString(array111[1]);
    self.viewModel.imagView3.frame = CGRectFromString(array111[2]);
    self.viewModel.imagView4.frame = CGRectFromString(array111[3]);
    self.viewModel.imagView5.frame = CGRectFromString(array111[4]);
       self.viewModel.imageViewMain.frame = CGRectFromString(array111[5]);
    self.viewModel.labelName .frame = CGRectFromString(array111[6]);
    self.viewModel.textView .frame = CGRectFromString(array111[7]);
    self.viewModel.labelTime .frame = CGRectFromString(array111[8]);
    
    
    self.viewModel.imagView1.layer.cornerRadius = self.viewModel.imagView1.frame.size.width/2;
    
    self.viewModel.imagView2.layer.cornerRadius = self.viewModel.imagView2.frame.size.width/2;
    
    self.viewModel.imagView3.layer.cornerRadius = self.viewModel.imagView3.frame.size.width/2;
    
    self.viewModel.imagView4.layer.cornerRadius = self.viewModel.imagView4.frame.size.width/2;
    
    self.viewModel.imagView5.layer.cornerRadius = self.viewModel.imagView5.frame.size.width/2;
    
    
    self.viewModel.labelName.hidden = NO;
    
    self.viewModel.scrollViewMain.contentSize = CGSizeMake(self.viewModel.imageViewMain.frame.size.width, self.viewModel.imageViewMain.frame.size.height - 64);
    self.viewModel.scrollViewMain.bounces = NO;

}

//模型6
- (void)loadData
{
    [[DBManager showDBManager] openDBManager];
    
    NSArray *array = [[DBManager showDBManager] selectTitle:self.name];
    
    [[DBManager showDBManager] closeDBmanager];
    
    Diary *diary = array[0];
    
    NSArray *arrayTime = [diary.time componentsSeparatedByString:@"&"];
    
    self.viewModel.labelTime.text = arrayTime[0];
    self.viewModel.labelName.text = diary.name;
    self.viewModel.textView.text = diary.textContact;
    
    
    //从本地区图片
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingFormat:@"/%@",diary.name];
    
    NSLog(@"%@",path);
    
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    
    NSKeyedUnarchiver *kedUN = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    NSArray *arrayImg = [kedUN decodeObject];
    [kedUN finishDecoding];

        self.viewModel.imagView1.image = arrayImg[0];
        self.viewModel.imagView2.image = arrayImg[1];
        self.viewModel.imagView3.image = arrayImg[2];
        self.viewModel.imagView4.image = arrayImg[3];
        self.viewModel.imagView5.image = arrayImg[4];
        self.viewModel.imagView6.image = arrayImg[5];
        self.viewModel.control1.hidden = YES;
        self.viewModel.control2.hidden = YES;
        self.viewModel.control3.hidden = YES;
        self.viewModel.control4.hidden = YES;
        self.viewModel.control5.hidden = YES;
        self.viewModel.control6.hidden = YES;

    
    NSString * path111 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path111 = [path111 stringByAppendingPathComponent:@"/FFFframe6frame6frame6"];
    NSArray *array111 = [NSArray arrayWithContentsOfFile:path111];
    
    self.viewModel.imagView1.frame =  CGRectFromString(array111[0]);
    self.viewModel.imagView2.frame = CGRectFromString(array111[1]);
    self.viewModel.imagView3.frame = CGRectFromString(array111[2]);
    self.viewModel.imagView4.frame = CGRectFromString(array111[3]);
    self.viewModel.imagView5.frame = CGRectFromString(array111[4]);
    self.viewModel.imagView6.frame = CGRectFromString(array111[5]);
    self.viewModel.imageViewMain.frame = CGRectFromString(array111[6]);
        self.viewModel.labelName .frame = CGRectFromString(array111[7]);
    self.viewModel.textView .frame = CGRectFromString(array111[8]);
    self.viewModel.labelTime .frame = CGRectFromString(array111[9]);

    
    self.viewModel.imagView1.layer.cornerRadius = self.viewModel.imagView1.frame.size.width/2;
    
    self.viewModel.imagView2.layer.cornerRadius = self.viewModel.imagView2.frame.size.width/2;
    
    self.viewModel.imagView3.layer.cornerRadius = self.viewModel.imagView3.frame.size.width/2;
    
    self.viewModel.imagView4.layer.cornerRadius = self.viewModel.imagView4.frame.size.width/2;
    
    self.viewModel.imagView5.layer.cornerRadius = self.viewModel.imagView5.frame.size.width/2;
    
    self.viewModel.imagView6.layer.cornerRadius = self.viewModel.imagView6.frame.size.width/2;
    
    self.viewModel.labelName.hidden = NO;
    
    self.viewModel.scrollViewMain.contentSize = CGSizeMake(self.viewModel.imageViewMain.frame.size.width, self.viewModel.imageViewMain.frame.size.height - 64);
    self.viewModel.scrollViewMain.bounces = NO;

    
}





@end
