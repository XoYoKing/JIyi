//
//  ModelViewController.m
//  team
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "ModelViewController.h"
#import "ViewModel.h"
#import "DropDown1.h"
#import "ModelColor.h"
#import "changeImageViewController.h"



@interface ModelViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UIGestureRecognizerDelegate,UMSocialUIDelegate,DropDownDelegate>

@property (nonatomic,strong)NSMutableDictionary *allDataDic;
@property (nonatomic,retain)ViewModel *viewModel;
@property (nonatomic,strong)UIImagePickerController *imagePicker;
@property (nonatomic,assign)NSInteger flag;
@property (nonatomic,strong)NSMutableArray *allImgArray;
//是否保存
@property (nonatomic,assign)BOOL isSaving;
@property (nonatomic,strong)UIImage *image;
//用于接收textView的frame
@property (nonatomic,assign)CGRect frameTextView;
@property (nonatomic,strong)DropDown1 *dropDown;
@property (nonatomic,strong)NSArray *arrayFont;
@property (nonatomic,strong)NSArray *arrayColor;
@property (nonatomic,strong)NSArray *arraySize;
@property (nonatomic,strong)UIWindow *tool;
@property (nonatomic,strong)UIWindow *windowColor;
@property (nonatomic,assign)BOOL taps;
//判断键盘按钮的字体颜色控制
@property (nonatomic,assign)BOOL colortaps;
@property (nonatomic,strong)NSString *FontStr;
@property (nonatomic,strong)DropDown1 *dropFont;
@property (nonatomic,strong)DropDown1 *dropColor;
@property (nonatomic,strong)DropDown1 *dropSize;
@property (nonatomic,strong)NSMutableDictionary *dictionary;

@property (nonatomic,strong)UISlider *sliderRed;
@property (nonatomic,strong)UISlider *sliderGreen;
@property (nonatomic,strong)UISlider *sliderBlue;


@end
#define FILEPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
@implementation ModelViewController
+ (instancetype)shareModelVC
{
    static ModelViewController *model = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        model = [[UIStoryboard storyboardWithName:@"NIU" bundle:nil] instantiateViewControllerWithIdentifier:@"ModelView"];
    });
    return model;
    
}
- (void)share
{
    CGSize size = CGSizeMake(Width, Height);
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    
    //UIImageWriteToSavedPhotosAlbum(img, self, nil, nil);
    
    UIGraphicsEndImageContext();

    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5645a32ce0f55afcea001210"
                                      shareText:self.viewModel.textView.text
                                     shareImage:self.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,nil]
                                       delegate:self];
    
}

- (void)loadView
{
    self.viewModel = [[ViewModel alloc] initWithFrame:Bounds];
    self.view = self.viewModel;
    self.viewModel.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.taps = YES;
    self.colortaps = YES;
    self.FontStr = @"Helvetica";
    
    //对textView的控制
    self.viewModel.textView.delegate = self;
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"写作模式" style:UIBarButtonItemStylePlain target:self action:@selector(buttonActionEid:)];
    item2.tag = 686;
    
    NSArray *array = @[item1,item2];
    
    self.navigationItem.rightBarButtonItems = array;
    
    
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button1.frame = CGRectMake(15, 6, 60, 30);
//    [button1 setTitle:@"返回" forState:UIControlStateNormal];
//    [button1 addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.navigationController.navigationBar addSubview:button1];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回首界面" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    

    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tgrAction:)];
    
    tgr.numberOfTapsRequired = 2;
    
    
    [self.view addGestureRecognizer:tgr];

    [self imageLod];
    self.viewModel.labelName.hidden = NO;
    


    

    
#pragma mark 编辑字体
    
    //编辑字体
    UIWindow *toor = [[UIWindow alloc] initWithFrame:CGRectMake(((Width - 30)/2) + 10 , Height *0.32692,Width - (((Width - 30)/2) + 10), Height * 0.475641)];
    
    toor.backgroundColor = [UIColor grayColor];
    
    toor.alpha = 0.8;
    
    UIButton *imgView = [[UIButton alloc] initWithFrame:CGRectMake(toor.frame.size.width - 20, 0, 20, 20)];
    [imgView setImage:[UIImage imageNamed:@"wrong"] forState:UIControlStateNormal];
    [imgView addTarget:self action:@selector(wrongAction1:) forControlEvents:UIControlEventTouchUpInside];
    [toor addSubview:imgView];
    
    
    
    
    
    
    UILabel *labelFont = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,toor.frame.size.width - 30, 20)];
    labelFont.text = @"设置字体";
    labelFont.font = [UIFont fontWithName:@"Helvetica" size:12];
    [toor addSubview:labelFont];
    
    DropDown1* dd1 = [[DropDown1 alloc]initWithFrame:CGRectMake(0, 25, toor.frame.size.width,  100)];
    
    
    self.arrayFont = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    dd1.tableArray = self.arrayFont;
    dd1.label.backgroundColor = [UIColor whiteColor];
    dd1.label.font = [UIFont systemFontOfSize:15];
    dd1.label.userInteractionEnabled = YES;
    dd1.label.font = [UIFont fontWithName:@"Helvetica" size:12];
    dd1.label.text = @"Helvetica";
    
    
    [toor addSubview:dd1];
    
    self.FontStr = dd1.label.text;
    self.dropFont = dd1;
    
    //字体颜色
    UILabel *labelColor = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, toor.frame.size.width, 20)];
    labelColor.text = @"模式切换";
    labelColor.font = [UIFont fontWithName:@"Helvetica" size:12];
    [toor addSubview:labelColor];
    
    DropDown1* dd2 = [[DropDown1 alloc]initWithFrame:CGRectMake(0, 145, toor.frame.size.width,  100)];
    self.arrayColor = [[NSArray alloc]initWithObjects:@"白天",@"夜间",@"正常", nil];
    
    dd2.tableArray = self.arrayColor;
    dd2.label.backgroundColor = [UIColor whiteColor];
    dd2.label.font = [UIFont systemFontOfSize:15];
    dd2.label.userInteractionEnabled= YES;
    dd2.label.font = [UIFont fontWithName:@"Helvetica" size:12];
    dd2.label.text = @"白天";
    [toor addSubview:dd2];
    self.dropColor = dd2;
    
    //字体Size;
    UILabel *labelSize = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, toor.frame.size.width, 20)];    labelSize.text = @"字体大小";
    labelSize.font = [UIFont fontWithName:@"Helvetica" size:12];
    [toor addSubview:labelSize];
    
    DropDown1* dd3 = [[DropDown1 alloc]initWithFrame:CGRectMake(0, 85, toor.frame.size.width,  100)];
    
    self.arrayFont = [[NSArray alloc]initWithArray:[UIFont familyNames]];
    self.arraySize = [[NSArray alloc] initWithObjects:@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
    dd3.tableArray = self.arraySize;
    dd3.label.backgroundColor = [UIColor whiteColor];
    dd3.label.font = [UIFont systemFontOfSize:15];
    dd3.label.userInteractionEnabled= YES;
    dd3.label.font = [UIFont fontWithName:@"Helvetica" size:12];
    dd3.label.text = @"12";
    [toor addSubview:dd3];
    self.dropSize = dd3;
    

    //颜色控制
    
    UIButton *buttonColor = [[UIButton alloc] initWithFrame:CGRectMake(0, 180, toor.frame.size.width / 2, 30)];
    buttonColor.backgroundColor = [UIColor redColor];
    [buttonColor setTitle:@"字体颜色" forState:UIControlStateNormal];
    [buttonColor addTarget:self action:@selector(btnColorAction:) forControlEvents:UIControlEventTouchUpInside];
    [toor addSubview:buttonColor];
    
    
   
    
    
    
    
    NSInteger intSize = [self.dropSize.label.text intValue];
    
     self.dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[UIFont fontWithName:self.dropFont.label.text size:intSize],NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName, nil];
    
    
    [self.viewModel.imageViewMain addSubview:toor];
    
    self.tool = toor;
    self.tool.hidden = YES;
    [toor makeKeyAndVisible];
    
    
   
    
#pragma mark 字体颜色
    UIWindow *windowColor = [[UIWindow alloc]initWithFrame:CGRectMake(((Width - 30)/2) + 10 , Height *0.32692,Width - (((Width - 30)/2) + 10), Height * 0.475641)];
    
    UIButton *imgView1 = [[UIButton alloc] initWithFrame:CGRectMake(windowColor.frame.size.width - 20, 0, 20, 20)];
    [imgView1 setImage:[UIImage imageNamed:@"wrong"] forState:UIControlStateNormal];
    [imgView1 addTarget:self action:@selector(wrongAction:) forControlEvents:UIControlEventTouchUpInside];
    [windowColor addSubview:imgView1];
    
    
    UISlider *Red = [[UISlider alloc] initWithFrame:CGRectMake(-30, windowColor.frame.size.height / 2, windowColor.frame.size.width - 20, 30)];
    Red.transform = CGAffineTransformMakeRotation(-M_PI_2);
    Red.minimumTrackTintColor = [UIColor redColor];
    Red.maximumTrackTintColor = [UIColor redColor];
    Red.thumbTintColor = [UIColor redColor];
    [windowColor addSubview:Red];
    self.sliderRed = Red;

    
    UISlider *Green = [[UISlider alloc] initWithFrame:CGRectMake(20, windowColor.frame.size.height / 2, windowColor.frame.size.width - 20, 30)];
    Green.transform = CGAffineTransformMakeRotation(-M_PI_2);
    Green.minimumTrackTintColor = [UIColor greenColor];
    Green.maximumTrackTintColor = [UIColor greenColor];
    Green.thumbTintColor = [UIColor greenColor];
    [windowColor addSubview:Green];
    self.sliderGreen = Green;
    
    
    UISlider *Blue = [[UISlider alloc] initWithFrame:CGRectMake(70, windowColor.frame.size.height / 2, windowColor.frame.size.width - 20, 30)];
    Blue.transform = CGAffineTransformMakeRotation(-M_PI_2);
    Blue.minimumTrackTintColor = [UIColor blueColor];
    Blue.maximumTrackTintColor = [UIColor blueColor];
    Blue.thumbTintColor = [UIColor blueColor];
    [windowColor addSubview:Blue];
    self.sliderBlue = Blue;
    
    
    [self.sliderRed addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.sliderGreen addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.sliderBlue addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
    
    // 获取颜色值，赋值给滑杆
    
    CGFloat red, green, blue, alpah;
    // 把变量的内存地址传入，内部修改变量的值
    [self.viewModel.textView.textColor getRed:&red
                                green:&green
                                 blue:&blue
                                alpha:&alpah];
    
    
    self.sliderRed.value = red;
    self.sliderGreen.value = green;
    self.sliderBlue.value = blue;
    
    


    windowColor.windowLevel = UIWindowLevelAlert;
  
    [self.viewModel.imageViewMain addSubview:windowColor];
   
    windowColor.backgroundColor = [UIColor grayColor];
    [windowColor makeKeyAndVisible];
    
     windowColor.alpha = 0.8;
      windowColor.hidden = YES;
    self.windowColor = windowColor;
    
    

    
    UIToolbar *tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, Width, 20)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(Width - 60, 0, 60, 20);
//    [button setTitle:@"结束" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"down2.jpg"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonSize = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSize.frame = CGRectMake(0, 0, 100, 20);
//    [buttonSize setTitle:@"设置字体" forState:UIControlStateNormal];
    [buttonSize setImage:[UIImage imageNamed:@"font2"] forState:UIControlStateNormal];
    [buttonSize setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buttonSize addTarget:self action:@selector(buttonActionEid2:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonColor1 = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonColor1.frame = CGRectMake((Width / 2) - 50, 0, 100, 20);
//    buttonColor1.center = CGPointMake(Width / 2, 0);
//    [buttonColor1 setTitle:@"字体颜色" forState:UIControlStateNormal];
    [buttonColor1 setImage:[UIImage imageNamed:@"color2"] forState:UIControlStateNormal];
    [buttonColor1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buttonColor1 addTarget:self action:@selector(btnColorAction2:) forControlEvents:UIControlEventTouchUpInside];
    
 
    [tool addSubview:button];
    [tool addSubview:buttonSize];
    [tool addSubview:buttonColor1];
    self.viewModel.textView.inputAccessoryView = tool;
    
#pragma mark text
  
    dd1.delegate = self;
    dd3.delegate = self;
    dd2.delegate = self;
    
}

//获取字体
- (void)getLabelText:(NSString *)text
{
    NSString *strSuze = text;
    CGFloat fontFlot = [strSuze floatValue];
    NSLog(@"%f",fontFlot);
    
    if ([text isEqualToString:@"白天"])
    {
        if (self.viewModel.textView.becomeFirstResponder) {
        
            if (self.viewModel.textView.textColor == [UIColor whiteColor]) {
                self.viewModel.textView.textColor = [UIColor blackColor];
            }
            
            self.viewModel.textView.backgroundColor = [UIColor whiteColor];
            
        }
        
        
    }else if ([text isEqualToString:@"夜间"])
    {
        if (self.viewModel.textView.becomeFirstResponder) {
        
            self.viewModel.textView.backgroundColor = [UIColor blackColor];
            if (self.viewModel.textView.textColor == [UIColor blackColor]) {
                self.viewModel.textView.textColor = [UIColor whiteColor];
            }
            
        }
        
    }else if ([text isEqualToString:@"正常"])
    {
        
        if (self.viewModel.textView.becomeFirstResponder) {
            
            self.viewModel.textView.backgroundColor = [UIColor clearColor];
          
        }

        
    }
    
    else if (fontFlot < 9) {
        NSString *StrSize = self.dropSize.label.text;
        CGFloat fontFlot = [StrSize floatValue];
       
        
        //    [UIFont fontWithName:text size:fontFlot];
        self.dropFont.label.text = text;
        
        self.viewModel.textView.font = [UIFont fontWithName:self.dropFont.label.text size:fontFlot];

    }else {
        NSString *strSuze = text;
        CGFloat fontFlot = [strSuze floatValue];
        
        self.viewModel.textView.font = [UIFont fontWithName:self.dropFont.label.text size:fontFlot];
        
    }
}
#pragma mark 设置字体

//根据滑竿控制字体颜色
- (void)sliderAction:(UISlider *)sender
{
    
    CGFloat red = self.sliderRed.value;
    CGFloat green = self.sliderGreen.value;
    CGFloat blue = self.sliderBlue.value;
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.viewModel.textView.textColor = color;
}

#pragma mark 字体颜色控制
- (void)btnColorAction:(UIButton *)sender
{
    
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:2 initialSpringVelocity:2 options:UIViewAnimationOptionTransitionCurlDown animations:^{
       
        self.tool.hidden = YES;
        self.windowColor.hidden = NO;
        
    } completion:^(BOOL finished) {
        
        
    }];
   
}

//键盘上的字体颜色控制
- (void)btnColorAction2:(UIButton *)sender
{
    
    if (self.colortaps) {
        [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:2 initialSpringVelocity:2 options:UIViewAnimationOptionTransitionCurlDown animations:^{
            
            //        self.tool.hidden = YES;
            self.windowColor.hidden = NO;
            self.colortaps = NO;
            
        } completion:^(BOOL finished) {
            
            
        }];

    }else
    {
        [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:2 initialSpringVelocity:2 options:UIViewAnimationOptionTransitionCurlDown animations:^{
            
            //        self.tool.hidden = YES;
            self.windowColor.hidden = YES;
            
            self.colortaps = YES;
        } completion:^(BOOL finished) {
            
            
        }];
        
    }
}

- (void)wrongAction:(UIButton *)sender
{
    self.windowColor.hidden = YES;
    self.tool.hidden = NO;
}

- (void)wrongAction1:(UIButton *)sender
{
    self.tool.hidden = YES;
    UIBarButtonItem *item = (UIBarButtonItem *)[self.viewModel viewWithTag:686];
    item.title = @"写作模式";
}
#pragma mark 写作模式

- (void)buttonActionEid:(UIBarButtonItem *)sender
{
    
    if (self.taps) {
        
        [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.taps = NO;
            self.windowColor.hidden = YES;
            self.tool.hidden = NO;
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        
        
        
        
    [self.viewModel.textView resignFirstResponder];
        if ([UIScreen mainScreen].bounds.size.height <= 500) {
            
            NSLog(@"4s 3.7");
            
            self.navigationController.navigationBar.hidden = NO;
            
            
        }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
        {
            NSLog(@"5s 4");
            
//            self.navigationController.navigationBar.hidden = NO;
            
            
        }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
        {
            NSLog(@"6 4.7");
         
        }
        else
        {
            NSLog(@"6plus 5.5");
           
        }

        
        sender.title = @"切换";
        
    }else
    {
        self.taps = YES;
        self.windowColor.hidden = YES;
        self.tool.hidden = YES;
        [self.viewModel.textView becomeFirstResponder];
        
        if ([UIScreen mainScreen].bounds.size.height <= 500) {
            
            NSLog(@"4s 3.7");
            
             self.navigationController.navigationBar.hidden = YES;
            
            
        }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
        {
            NSLog(@"5s 4");
            
//           self.navigationController.navigationBar.hidden = YES;
            
            
        }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
        {
            NSLog(@"6 4.7");
            
        }
        else
        {
            NSLog(@"6plus 5.5");
            
        }
        sender.title = @"写作模式";
    }
}

- (void)buttonActionEid2:(UIBarButtonItem *)sender
{
    
    if (self.taps) {
        
        [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.taps = NO;
            self.windowColor.hidden = YES;
            self.tool.hidden = NO;
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        sender.title = @"切换";
        
    }else
    {
        self.taps = YES;
        self.windowColor.hidden = YES;
        self.tool.hidden = YES;
      
        sender.title = @"写作模式";
    }

}

//imageView1 的响应事件
- (void)imageLod
{
    //imageView1 的响应事件
    [self.viewModel.imagView1 addTarget:self action:@selector(changeImageHiddenAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewModel.imagView2 addTarget:self action:@selector(changeImageHiddenAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewModel.imagView3 addTarget:self action:@selector(changeImageHiddenAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewModel.imagView4 addTarget:self action:@selector(changeImageHiddenAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewModel.imagView5 addTarget:self action:@selector(changeImageHiddenAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewModel.imagView6 addTarget:self action:@selector(changeImageHiddenAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.windowColor.hidden = YES;
    self.tool.hidden = YES;
//    // 获取颜色值，赋值给滑杆
//    
//    CGFloat red, green, blue, alpah;
//    // 把变量的内存地址传入，内部修改变量的值
//    [self.viewModel.textView.textColor getRed:&red
//                                        green:&green
//                                         blue:&blue
//                                        alpha:&alpah];
//    
//    
//    self.sliderRed.value = red;
//    self.sliderGreen.value = green;
//    self.sliderBlue.value = blue;
//    
//    NSLog(@"%f",self.sliderBlue.value);

    self.viewModel.textView.textColor = [UIColor colorWithRed:self.sliderRed.value green:self.sliderGreen.value blue:self.sliderBlue.value alpha:1];
    
    
    self.viewModel.scrollViewMain.bounces = YES;
    self.viewModel.scrollViewMain.contentSize = CGSizeMake(Width, (Height * 1.5) + 216);
    
    
#pragma mark Question从相册传图片
    if (![self.str isEqualToString:@"1"]) {
        
        NSLog(@"%@",self.str);
        
    }else{
        
        NSKeyedUnarchiver *unarchVer = [[NSKeyedUnarchiver alloc] initForReadingWithData:self.data];
        
        self.allImgArray = [unarchVer decodeObject];
        [unarchVer finishDecoding];
        NSLog(@"%@",self.str);
        
        self.viewModel.textView.text = @"    人一生有起有落，起的时候不忘落的时候，落的时候想想起的时候，哪里跌倒，哪里站起。\n    相信有自信的生命与没自信的生命会有不一样的天地";
        self.viewModel.labelName.text = @"";
        self.viewModel.labelTime.text = @"";
        self.viewModel.textView.font = [UIFont fontWithName:self.FontStr size:12];

}
    
    
    
    
    if (self.indexPath == 1) {
        
        [self loadViewModel1Index:1];
          [self.viewModel.imageViewMain setImage:[UIImage imageNamed:@"2211"]];
        
        
        
    }else if (self.indexPath == 2)
    {
        [self loadViewModel2Index:2];
        [self.viewModel.imageViewMain setImage:[UIImage imageNamed:@"2227"]];
        
    }else if (self.indexPath == 3)
    {
        [self loadViewModel3Index:3];
         [self.viewModel.imageViewMain setImage:[UIImage imageNamed:@"2223"]];
        
    }else if (self.indexPath == 4)
    {
        [self loadViewModel4Index:4];
        
        [self.viewModel.imageViewMain setImage:[UIImage imageNamed:@"2224"]];
    }else if (self.indexPath == 5)
    {
        [self loadViewModelIndex5:5];
        [self.viewModel.imageViewMain setImage:[UIImage imageNamed:@"2225"]];
    }else{
        //对模型1的控制
        [self loadviewModelIndex:6];
        
        [self.viewModel.imageViewMain setImage:[UIImage imageNamed:@"2226"]];
    }
    
}

//轻怕手势
- (void)tgrAction:(UIGestureRecognizer *)sender
{
    [self.viewModel.textView resignFirstResponder];
    
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        NSLog(@"4s 3.7");
        
         self.navigationController.navigationBar.hidden = NO;
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
    {
        NSLog(@"5s 4");
        
//         self.navigationController.navigationBar.hidden = NO;
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
    {
        NSLog(@"6 4.7");
        
    }
    else
    {
        NSLog(@"6plus 5.5");
        
    }
  
}

//textViewDelegate
//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
  [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:2 initialSpringVelocity:2 options:UIViewAnimationOptionAllowUserInteraction animations:^{
      //设置偏移量
      CGFloat offset = (Height - ((self.viewModel.textView.frame.origin.y + textView.frame.size.height + 64))) - 216;
      
      
      
      if ([UIScreen mainScreen].bounds.size.height <= 500) {
          
          NSLog(@"4s 3.7");
          CGPoint point = CGPointMake(0,  - offset);
          [self.viewModel.scrollViewMain setContentOffset:point animated:YES];
          
          self.navigationController.navigationBar.hidden = YES;
          
          
      }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
      {
          NSLog(@"5s 4");
          CGPoint point = CGPointMake(0,  - offset);
          [self.viewModel.scrollViewMain setContentOffset:point animated:YES];
          //      self.navigationController.navigationBar.hidden = YES;
          
          
      }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
      {
          NSLog(@"6 4.7");
          CGPoint point = CGPointMake(0,  - offset);
          [self.viewModel.scrollViewMain setContentOffset:point animated:YES];
      }
      else
      {
          NSLog(@"6plus 5.5");
          CGPoint point = CGPointMake(0,  - (offset - 30));
          [self.viewModel.scrollViewMain setContentOffset:point animated:YES];
          
      }

      
  } completion:^(BOOL finished) {
      
      
  }];
    
    
  
    
    
    
    
    if ([self.dropColor.label.text isEqualToString:@"白天"]) {
        
        self.viewModel.textView.backgroundColor = [UIColor whiteColor];
        if (self.viewModel.textView.textColor == [UIColor whiteColor]) {
            UIColor *color = [UIColor blackColor];
            self.viewModel.textView.textColor = color;
        }

        
    }else if([self.dropColor.label.text isEqualToString:@"夜间"])
    {
        
        if (self.viewModel.textView.textColor == [UIColor blackColor]) {
            UIColor *color = [UIColor whiteColor];
             self.viewModel.textView.textColor = color;
        }
        self.viewModel.textView.backgroundColor = [UIColor blackColor];
    }else{
        self.viewModel.textView.backgroundColor = [UIColor clearColor];
    }
    
    //设置Size
    CGFloat intSize = [self.dropSize.label.text floatValue];
    
    //用于接收字体大小颜色等
    self.dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[UIFont fontWithName:self.dropFont.label.text size:intSize],NSFontAttributeName, nil];
    //设置textView的字体
    self.viewModel.textView.font = [self.dictionary objectForKey:NSFontAttributeName];

    
    
    self.viewModel.textView.textAlignment = NSTextAlignmentLeft;
    if ([self.viewModel.textView.text isEqualToString:@"    人一生有起有落，起的时候不忘落的时候，落的时候想想起的时候，哪里跌倒，哪里站起。\n    相信有自信的生命与没自信的生命会有不一样的天地"]) {
        
        NSLog(@"%@",self.dropFont.label.text);
        
        self.viewModel.textView.text = @"";
      
        
    }
}

- (void)btnCancelAction:(UIButton *)sender
{
    [self.viewModel.textView resignFirstResponder];
    self.tool.hidden = YES;
    self.windowColor.hidden = YES;
    
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        NSLog(@"4s 3.7");
        
        self.navigationController.navigationBar.hidden = NO;
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
    {
        NSLog(@"5s 4");
        
//         self.navigationController.navigationBar.hidden = NO;
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
    {
        NSLog(@"6 4.7");
        
    }
    else
    {
        NSLog(@"6plus 5.5");
        
    }
    
    
}

//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
   
    
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        NSLog(@"4s 3.7");
        
          self.navigationController.navigationBar.hidden = NO;
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
    {
        NSLog(@"5s 4");
        
//         self.navigationController.navigationBar.hidden = NO;
        
        
    }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
    {
        NSLog(@"6 4.7");
        
    }
    else
    {
        NSLog(@"6plus 5.5");
        
    }
    
    
    
    
    //设置Size
    CGFloat intSize = [self.dropSize.label.text floatValue];
    
    self.dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[UIFont fontWithName:self.dropFont.label.text size:intSize],NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName, nil];

 
    self.viewModel.textView.font = [self.dictionary objectForKey:NSFontAttributeName];
  
     textView.backgroundColor = [UIColor clearColor];
    [self.viewModel.scrollViewMain setContentOffset:CGPointMake(0, - 64) animated:YES];
    
    
    if (textView.text) {
        
       
        [textView resignFirstResponder];
        if ([textView.text isEqualToString:@""]) {
            
            textView.text = @"    人一生有起有落，起的时候不忘落的时候，落的时候想想起的时候，哪里跌倒，哪里站起。\n    相信有自信的生命与没自信的生命会有不一样的天地";
            
        }
    }
    
  
    
    
    
    
}
//模型1
- (void)loadViewModel1Index:(NSInteger)index
{

    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"/FFFframe1frame1frame1"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    self.viewModel.imagView1.frame =  CGRectFromString(array[0]);
    self.viewModel.imageViewMain.frame = CGRectFromString(array[1]);
    self.viewModel.imageViewMain.backgroundColor = Gray;
        self.viewModel.labelName .frame = CGRectFromString(array[2]);
    self.viewModel.textView .frame = CGRectFromString(array[3]);
    self.viewModel.labelTime .frame = CGRectFromString(array[4]);
    self.viewModel.imagView1.image = self.allImgArray[0];
    
    self.viewModel.imagView1.layer.cornerRadius = self.viewModel.imagView1.frame.size.width/2;
    self.viewModel.imagView1.layer.masksToBounds = YES;
    
    
    self.viewModel.scrollViewMain.contentSize = CGSizeMake(self.viewModel.imageViewMain.frame.size.width, self.viewModel.imageViewMain.frame.size.height - 64);
    self.viewModel.scrollViewMain.bounces = NO;
    

  
    

    
}

//模型2
- (void)loadViewModel2Index:(NSInteger)index
{
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"/FFFframe2frame2frame2"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    self.viewModel.imagView1.frame =  CGRectFromString(array[0]);
    self.viewModel.imagView2.frame = CGRectFromString(array[1]);
       self.viewModel.imageViewMain.frame = CGRectFromString(array[2]);
        self.viewModel.labelName .frame = CGRectFromString(array[3]);
    self.viewModel.textView .frame = CGRectFromString(array[4]);
    self.viewModel.labelTime .frame = CGRectFromString(array[5]);
    self.viewModel.imagView1.image = self.allImgArray[0];
    self.viewModel.imagView2.image = self.allImgArray[1];
  
    
    self.viewModel.imagView1.layer.cornerRadius = self.viewModel.imagView1.frame.size.width/2;
    
    self.viewModel.imagView2.layer.cornerRadius = self.viewModel.imagView2.frame.size.width/2;
   self.viewModel.imagView1.layer.masksToBounds = YES;
     self.viewModel.imagView2.layer.masksToBounds = YES;
    
    self.viewModel.scrollViewMain.backgroundColor = Gray;
    self.viewModel.scrollViewMain.contentSize = CGSizeMake(self.viewModel.imageViewMain.frame.size.width, self.viewModel.imageViewMain.frame.size.height - 64);
    self.viewModel.scrollViewMain.bounces = NO;


    
}

- (void)loadViewModel3Index:(NSInteger)index
{
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"/FFFframe3frame3frame3"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    self.viewModel.imagView1.frame =  CGRectFromString(array[0]);
    self.viewModel.imagView2.frame = CGRectFromString(array[1]);
    self.viewModel.imagView3.frame = CGRectFromString(array[2]);
    
    self.viewModel.imageViewMain.frame = CGRectFromString(array[3]);
    self.viewModel.labelName .frame = CGRectFromString(array[4]);
    self.viewModel.textView .frame = CGRectFromString(array[5]);
    self.viewModel.labelTime .frame = CGRectFromString(array[6]);
    self.viewModel.imagView1.image = self.allImgArray[0];
    self.viewModel.imagView2.image = self.allImgArray[1];
    self.viewModel.imagView3.image = self.allImgArray[2];
  
    
    
    
    
    self.viewModel.imagView1.layer.cornerRadius = self.viewModel.imagView1.frame.size.width/2;
    
    self.viewModel.imagView2.layer.cornerRadius = self.viewModel.imagView2.frame.size.width/2;
    
    self.viewModel.imagView3.layer.cornerRadius = self.viewModel.imagView3.frame.size.width/2;
    
   self.viewModel.imagView1.layer.masksToBounds = YES;
     self.viewModel.imagView2.layer.masksToBounds = YES;
     self.viewModel.imagView3.layer.masksToBounds = YES;
    
    self.viewModel.scrollViewMain.backgroundColor = Gray;
    self.viewModel.scrollViewMain.contentSize = CGSizeMake(self.viewModel.imageViewMain.frame.size.width, self.viewModel.imageViewMain.frame.size.height - 64);
    self.viewModel.scrollViewMain.bounces = NO;
    
    
  

}

- (void)loadViewModel4Index:(NSInteger)Index
{
 
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"/FFFframe4frame4frame4"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    self.viewModel.imagView1.frame =  CGRectFromString(array[0]);
    self.viewModel.imagView2.frame = CGRectFromString(array[1]);
    self.viewModel.imagView3.frame = CGRectFromString(array[2]);
    self.viewModel.imagView4.frame = CGRectFromString(array[3]);
   
    self.viewModel.imageViewMain.frame = CGRectFromString(array[4]);
        self.viewModel.labelName .frame = CGRectFromString(array[5]);
    self.viewModel.textView .frame = CGRectFromString(array[6]);
    self.viewModel.labelTime .frame = CGRectFromString(array[7]);
    self.viewModel.imagView1.image = self.allImgArray[0];
    self.viewModel.imagView2.image = self.allImgArray[1];
    self.viewModel.imagView3.image = self.allImgArray[2];
    self.viewModel.imagView4.image = self.allImgArray[3];
  
    
    self.viewModel.imagView1.layer.cornerRadius = self.viewModel.imagView1.frame.size.width/2;
    
    self.viewModel.imagView2.layer.cornerRadius = self.viewModel.imagView2.frame.size.width/2;
    
    self.viewModel.imagView3.layer.cornerRadius = self.viewModel.imagView3.frame.size.width/2;
    
    self.viewModel.imagView4.layer.cornerRadius = self.viewModel.imagView4.frame.size.width/2;
    
 self.viewModel.imagView1.layer.masksToBounds = YES;
    
     self.viewModel.imagView2.layer.masksToBounds = YES;
     self.viewModel.imagView3.layer.masksToBounds = YES;
    
     self.viewModel.imagView4.layer.masksToBounds = YES;
    
    self.viewModel.scrollViewMain.backgroundColor = Gray;
    self.viewModel.scrollViewMain.contentSize = CGSizeMake(self.viewModel.imageViewMain.frame.size.width, self.viewModel.imageViewMain.frame.size.height - 64);
    self.viewModel.scrollViewMain.bounces = NO;
    
    
}

- (void)loadViewModelIndex5:(NSInteger)Index
{
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"/FFFframe5frame5frame5"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    self.viewModel.imagView1.frame =  CGRectFromString(array[0]);
    self.viewModel.imagView2.frame = CGRectFromString(array[1]);
    self.viewModel.imagView3.frame = CGRectFromString(array[2]);
    self.viewModel.imagView4.frame = CGRectFromString(array[3]);
    self.viewModel.imagView5.frame = CGRectFromString(array[4]);

    self.viewModel.imageViewMain.frame = CGRectFromString(array[5]);
        self.viewModel.labelName .frame = CGRectFromString(array[6]);
    self.viewModel.textView .frame = CGRectFromString(array[7]);
    self.viewModel.labelTime .frame = CGRectFromString(array[8]);
    self.viewModel.imagView1.image = self.allImgArray[0];
    self.viewModel.imagView2.image = self.allImgArray[1];
    self.viewModel.imagView3.image = self.allImgArray[2];
    self.viewModel.imagView4.image = self.allImgArray[3];
    self.viewModel.imagView5.image = self.allImgArray[4];

    
    self.viewModel.imagView1.layer.cornerRadius = self.viewModel.imagView1.frame.size.width/2;
    
    self.viewModel.imagView2.layer.cornerRadius = self.viewModel.imagView2.frame.size.width/2;
    
    self.viewModel.imagView3.layer.cornerRadius = self.viewModel.imagView3.frame.size.width/2;
    
    self.viewModel.imagView4.layer.cornerRadius = self.viewModel.imagView4.frame.size.width/2;
    
    self.viewModel.imagView5.layer.cornerRadius = self.viewModel.imagView5.frame.size.width/2;
    
 
     self.viewModel.imagView1.layer.masksToBounds = YES;
    
    
     self.viewModel.imagView2.layer.masksToBounds = YES;
    
     self.viewModel.imagView3.layer.masksToBounds = YES;
    
     self.viewModel.imagView4.layer.masksToBounds = YES;
     self.viewModel.imagView5.layer.masksToBounds = YES;
  
    
    self.viewModel.scrollViewMain.backgroundColor = Gray;
    self.viewModel.scrollViewMain.contentSize = CGSizeMake(self.viewModel.imageViewMain.frame.size.width, self.viewModel.imageViewMain.frame.size.height - 64);
    self.viewModel.scrollViewMain.bounces = NO;
    
}

//对模型6的控制
- (void)loadviewModelIndex:(NSInteger)Index
{
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"/FFFframe6frame6frame6"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    self.viewModel.imagView1.frame =  CGRectFromString(array[0]);
    self.viewModel.imagView2.frame = CGRectFromString(array[1]);
    self.viewModel.imagView3.frame = CGRectFromString(array[2]);
    self.viewModel.imagView4.frame = CGRectFromString(array[3]);
    self.viewModel.imagView5.frame = CGRectFromString(array[4]);
    self.viewModel.imagView6.frame = CGRectFromString(array[5]);
  
    self.viewModel.imageViewMain.frame = CGRectFromString(array[6]);
    self.viewModel.labelName .frame = CGRectFromString(array[7]);
    self.viewModel.textView .frame = CGRectFromString(array[8]);
    self.viewModel.labelTime .frame = CGRectFromString(array[9]);
    self.viewModel.imagView1.image = self.allImgArray[0];
    self.viewModel.imagView2.image = self.allImgArray[1];
    self.viewModel.imagView3.image = self.allImgArray[2];
    self.viewModel.imagView4.image = self.allImgArray[3];
    self.viewModel.imagView5.image = self.allImgArray[4];
    self.viewModel.imagView6.image = self.allImgArray[5];


    
    self.viewModel.imagView1.layer.cornerRadius = self.viewModel.imagView1.frame.size.width/2;
    
    self.viewModel.imagView2.layer.cornerRadius = self.viewModel.imagView2.frame.size.width/2;
    
     self.viewModel.imagView3.layer.cornerRadius = self.viewModel.imagView3.frame.size.width/2;
    
     self.viewModel.imagView4.layer.cornerRadius = self.viewModel.imagView4.frame.size.width/2;
    
     self.viewModel.imagView5.layer.cornerRadius = self.viewModel.imagView5.frame.size.width/2;
    self.viewModel.imagView6.layer.cornerRadius = self.viewModel.imagView6.frame.size.width/2;
    
     self.viewModel.imagView1.layer.masksToBounds = YES;
     self.viewModel.imagView2.layer.masksToBounds = YES;
     self.viewModel.imagView3.layer.masksToBounds = YES;
     self.viewModel.imagView4.layer.masksToBounds = YES;
     self.viewModel.imagView5.layer.masksToBounds = YES;
     self.viewModel.imagView6.layer.masksToBounds = YES;
    
    self.viewModel.scrollViewMain.backgroundColor = Gray;
    self.viewModel.scrollViewMain.contentSize = CGSizeMake(self.viewModel.imageViewMain.frame.size.width, self.viewModel.imageViewMain.frame.size.height - 64);
    self.viewModel.scrollViewMain.bounces = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.windowColor.hidden = YES;
    self.tool.hidden = YES;
    
    
    
    
    
     [self.viewModel.textView resignFirstResponder];
    UIBarButtonItem *item = (UIBarButtonItem *)[self.viewModel viewWithTag:686];
    item.title = @"写作模式";
    
     self.viewModel.imagView1.frame = CGRectMake(0, 0, 0, 0);
     self.viewModel.imagView2.frame = CGRectMake(0, 0, 0, 0);
     self.viewModel.imagView3.frame = CGRectMake(0, 0, 0, 0);
     self.viewModel.imagView4.frame = CGRectMake(0, 0, 0, 0);
     self.viewModel.imagView5.frame = CGRectMake(0, 0, 0, 0);
     self.viewModel.imagView6.frame = CGRectMake(0, 0, 0, 0);
    
}

//保存相册
- (void)saveAction:(UINavigationBar *)sender
{
    self.tool.hidden = YES;
    self.windowColor.hidden = YES;
    [self.viewModel.textView resignFirstResponder];
    
    
    [self timeAction0:nil];
    
}

- (void)saveData
{
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    

     [dateformatter setDateFormat:@"yyyy-MM-dd&HH:mm:ss"];
    
    NSString * locationString=[dateformatter stringFromDate:senddate];
    
   NSArray *arrayTime = [locationString componentsSeparatedByString:@"&"];
    
    self.viewModel.labelTime.text = arrayTime[0];
    
    Diary *diary = [Diary new];
    diary.name = self.viewModel.labelName.text;
    diary.textContact  = self.viewModel.textView.text;
    diary.time = locationString;
    diary.index = [NSString stringWithFormat:@"%ld",self.indexPath];
  
    //存到数据库
    
    [[DBManager showDBManager] openDBManager];
    [[DBManager showDBManager] createTable];
    
    [[DBManager showDBManager] deletefromTitle:diary.name];
    [[DBManager showDBManager] insertDiary:diary];
    
    [[DBManager showDBManager] closeDBmanager];
    //图片存储到本地
    
        //
        NSMutableData *data = [NSMutableData new];
        NSKeyedArchiver *key = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [key encodeObject:self.allImgArray];
        [key finishEncoding];
    

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
     path = [path stringByAppendingFormat:@"/%@",diary.name];
    [data writeToFile:path atomically:YES];
    
    CGFloat red, green, blue, alpah;
    // 把变量的内存地址传入，内部修改变量的值
    [self.viewModel.textView.textColor getRed:&red
                                        green:&green
                                         blue:&blue
                                        alpha:&alpah];
    
   
    NSString *strRed = [NSString stringWithFormat:@"%f",red];
    NSString *strGreen = [NSString stringWithFormat:@"%f",green];
    NSString *strBlue = [NSString stringWithFormat:@"%f",blue];
  
    NSArray *array = [[NSArray alloc] initWithObjects:self.dropFont.label.text,self.dropSize.label.text,strRed,strGreen,strBlue, nil];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:diary.name]==nil){
        
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:diary.name];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [self timeAction100:nil];
    
}

//返回到跟视图
- (void)backAction:(UIBarButtonItem *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

//选择跳转相册还是访问相机
- (void)addPic:(UIImageView *)sender
{
        [self.viewModel.textView resignFirstResponder];
        [self.viewModel.labelName resignFirstResponder];

//    sender.hidden = YES;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Please" message:@"选择图片来源" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    //    访问相册
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"访问相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//        sender.hidden = YES;
        
        //    访问相册
        //        UIImagePickerController *pic = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePicker.allowsEditing = YES;
        [self presentViewController:self.imagePicker animated:YES completion:^{
            
            
            self.flag = sender.tag;
        }];
        
    }];
    
    UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"访问相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceRear];
        if(!isCamera) {
            
            [self save:404];
            
            return;
        }
        //        UIImagePickerController *pic = [[UIImagePickerController alloc] init];
        // 摄像头
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 允许编辑
        self.imagePicker.allowsEditing = YES;
        
        [self presentViewController: self.imagePicker animated: YES completion:^{
            self.flag = sender.tag;
        }];
    }];
    
    UIAlertAction *alertAction4 = [UIAlertAction actionWithTitle:@"修图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        changeImageViewController *changeImage = [changeImageViewController new];
        self.flag = sender.tag;
        UIImageView *imgView = (UIImageView *)[self.viewModel.scrollViewMain viewWithTag:self.flag];
        
        UIImage *image = [self fixOrientation:imgView.image];

        
        NSData *data = UIImagePNGRepresentation(image);
        changeImage.data = data;
        changeImage.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        changeImage.block = ^(NSData *data)
        {
            UIImage *image = [UIImage imageWithData:data];
            
            NSInteger index = self.flag - 101;
            [self.allImgArray replaceObjectAtIndex:index withObject:image];
            self.str = @"0";

        };
        
        [self showDetailViewController:changeImage sender:nil];
        
    }];

    
    UIAlertAction *alertAction3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    [alertController addAction:alertAction1];
    [alertController addAction:alertAction2];
    [alertController addAction:alertAction4];
    [alertController addAction:alertAction3];
    
    [self presentViewController:alertController animated:YES completion:^{
    }];
    
}

#pragma mark 对模型1 的控制
- (void)changeImageHiddenAction:(UIImageView *)sender
{
    [self addPic:sender];
    
}

#pragma mark 懒加载imagePicker
- (UIImagePickerController *)imagePicker
{
    if(!_imagePicker) {
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
    }
    return _imagePicker;
    
}

//相册回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImageView *viewImg = [[UIImageView alloc]init];
    viewImg.clipsToBounds = YES;
    
    viewImg.contentMode = UIViewContentModeScaleAspectFill;
    viewImg.image = info[UIImagePickerControllerEditedImage];
//    viewImg.image = info[UIImagePickerControllerOriginalImage];

    
    
//    NSData *DataImage = UIImageJPEGRepresentation(viewImg.image, 1);

    NSInteger index = self.flag - 101;
    NSLog(@"%ld",self.flag);
    
    [self.allImgArray replaceObjectAtIndex:index withObject:viewImg.image];
    
    self.str = @"0";
      NSLog(@"%@",self.str);

    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}

- (void)save:(NSInteger)sender
{
    
    
    
    if (sender == 1) {
        //保存失败因为重名了
        [self timeAction1:nil];
        
    }else if (sender == -1)
    {
        //保存失败
        [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timeAction0:) userInfo:nil repeats:NO];
    }else if (sender == 3)
    {
        
        //保存失败
        [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timeAction3:) userInfo:nil repeats:NO];
        
    }else if (sender == 404)
    {
        //相机访问失败
        [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timeAction404:) userInfo:nil repeats:NO];
        
    }else if (sender == 100)
    {
        //保存成功
        [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timeAction100:) userInfo:nil repeats:NO];
        
        
    }
    else
    {
        //保存失败
        [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timeAction:) userInfo:nil repeats:NO];
        
    }
    
    
    
}

- (void)timeAction0:(NSTimer *)sender
{

    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存" message:@"请输入标题" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"输入完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[DBManager showDBManager] openDBManager];
        NSArray *array = [[DBManager showDBManager] selectTitle:alertController.textFields.firstObject.text];
        [[DBManager showDBManager] closeDBmanager];
        self.viewModel.labelName.text  = alertController.textFields.firstObject.text;
        
        if (array.count != 0) {
            [alertController dismissViewControllerAnimated:YES completion:^{
                
                
            }];
            
            [self timeAction1:nil];
            return;
        }

        
        [self saveData];

    }];
    
     okAction.enabled = NO;
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我在看看" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
[alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    
}

//对输入框的监听
- (void)alertTextFieldDidChange:(NSNotification *)notification{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
//    //获取本地所有文件名称数组
//    NSFileManager * fileManager = [NSFileManager defaultManager];
//    NSArray * tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:FILEPATH error:nil]];
//
//    //获取播放的本地URL
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
        if (![alertController.textFields.firstObject.text isEqualToString:@""]) {
        
            
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = YES;
        
    }else
    {
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = NO;
    }
    
}

//保存替换
- (void)timeAction1:(NSTimer *)sender
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"你有一个名字与之相同的文件,确认替换吗?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *Action1 = [UIAlertAction actionWithTitle:@"确定替换" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
//        NSDate *  senddate=[NSDate date];
//        
//        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//        
//        [dateformatter setDateFormat:@"YYYY-MM-dd"];
//        
//        NSString *  locationString=[dateformatter stringFromDate:senddate];
//        
//        self.viewModel.labelTime.text = locationString;
//        
//        //把信息存到模型里面
//        Diary *diary = [Diary new];
//        diary.name = self.viewModel.labelName.text;
//        diary.textContact  = self.viewModel.textView.text;
//        diary.time = self.viewModel.labelTime.text;
//        diary.index = [NSString stringWithFormat:@"%ld",self.indexPath];
        
        [self saveData];
        
        
    }];
    
    UIAlertAction *Action2 = [UIAlertAction actionWithTitle:@"再想想吧" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:Action1];
    [alertController addAction:Action2];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    
}

- (void)timeAction404:(NSTimer *)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"访问失败" message:@"你的摄像头出问题了!" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        });
        
    });
    
    
}

- (void)timeAction100:(NSTimer *)sender
{
 
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存成功" message:@"保存成功了呢!快去""我的心情""里查看吧!" preferredStyle:UIAlertControllerStyleAlert];
        
       UIAlertAction *action = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
           [self share];
           
       }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"我再看看" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
        
    
    [alertController addAction:action];
    [alertController addAction:action1];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    
}

- (NSMutableDictionary *)dictionary
{
    if (!_dictionary) {
        
        self.dictionary = [NSMutableDictionary new];
        
    }
    return _dictionary;
    
}

- (NSMutableArray *)allImgArray
{
    if (!_allImgArray) {
        
        self.allImgArray = [NSMutableArray array];
        
    }
    
    return _allImgArray;
    
}



- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
@end
