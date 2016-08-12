//
//  ViewImg1.m
//  team
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "ViewImg1.h"

@implementation ViewImg1

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self =  [super initWithFrame:frame]) {
        
        [self addAllViews];
        
    }
    return self;
}

- (void)addAllViews
{
    self.userInteractionEnabled = YES;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:Bounds];
    
    [self addSubview:scrollView];
    self.scrollViewMain = scrollView;
    
    
//    UIImage *image = [UIImage imageNamed:@"jian.jpg"];
    UIImageView *imagView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, [UIScreen mainScreen].bounds.size.height * 1.5)];
    
    imagView.userInteractionEnabled= YES;
    
    self.imageViewMain = imagView;
    
    
    
     UIImage *image1 = [UIImage imageNamed:@"111.jpg"];
    //切换图片1
    self.imagView1 = [[ImageViewMine alloc] initWithFrame:CGRectMake(10, 40,(Width - 30) / 2 , (Width - 30) / 2)];
    [self.imagView1 setImage:image1];
    self.imagView1.userInteractionEnabled = YES;
    self.imagView1.layer.cornerRadius = (Width - 30) / 4;
    self.imagView1.layer.masksToBounds = YES;
    self.imagView1.clipsToBounds = YES;
    
    self.imagView1.contentMode = UIViewContentModeScaleAspectFill;
     [imagView addSubview:self.imagView1];
    
    

    
    //切换图片1 的蒙版
    UIControl *changPic1 = [[UIControl alloc] initWithFrame:CGRectMake(10, 40,(Width - 30) / 2 , (Width - 30) / 2)];
    changPic1.layer.cornerRadius = (Width - 30) / 4;
    
    [changPic1 setBackgroundColor:[UIColor colorWithWhite: 0 alpha: 0.7]];
    
    UILabel *tiplabel1 = [[UILabel alloc] init];
    tiplabel1.center = CGPointMake(self.imagView1.frame.size.width * 0.5,self.imagView1.frame.size.height * 0.5);
    tiplabel1.bounds = CGRectMake(0, 0, self.imagView1.frame.size.width * 0.5, self.imagView1.frame.size.height * 0.5);
    
    tiplabel1.text = @"添加图片";
    tiplabel1.textAlignment = NSTextAlignmentCenter;
    tiplabel1.textColor = [UIColor whiteColor];
    [changPic1 addSubview:tiplabel1];

    [imagView insertSubview:changPic1 aboveSubview:self.imagView1];
    
    [imagView addSubview:changPic1];
    [self bringSubviewToFront:changPic1];
    
    self.label1 = tiplabel1;
    self.control1 = changPic1;
    
    
    
    
    
    
    
   //图片2
    self.imagView2 = [[ImageViewMine alloc] initWithFrame:CGRectMake(20 +( (Width - 30) / 2) , 40, (Width - 30)/2, (Width - 30) / 2)];
    [self.imagView2 setImage:image1];
    
    self.imagView2.userInteractionEnabled = YES;
    self.imagView2.layer.cornerRadius = (Width - 30) / 4;
    self.imagView2.layer.masksToBounds = YES;

    self.imagView2.clipsToBounds = YES;
    
    self.imagView2.contentMode = UIViewContentModeScaleAspectFill;

       [imagView addSubview:self.imagView2];

    //切换图片2 的蒙版


    UIControl *changPic2 = [UIControl new];
    
    changPic2.frame = CGRectMake(20 +( (Width - 30) / 2), 104 - 64,(Width - 30) / 2 , (Width - 30) / 2);
    changPic2.layer.cornerRadius = (Width - 30) / 4;
    
    
    [changPic2 setBackgroundColor:[UIColor colorWithWhite: 0 alpha: 0.7]];
    
    UILabel *tiplabel2 = [[UILabel alloc] init];
    tiplabel2.center = CGPointMake(self.imagView2.frame.size.width * 0.5,self.imagView2.frame.size.height * 0.5);
    tiplabel2.bounds = CGRectMake(0, 0, self.imagView2.frame.size.width * 0.5, self.imagView2.frame.size.height * 0.5);

    
    tiplabel2.text = @"添加图片";
    tiplabel2.textAlignment = NSTextAlignmentCenter;
    tiplabel2.textColor = [UIColor whiteColor];
    [changPic2 addSubview:tiplabel2];
    
    
    [imagView addSubview:changPic2];
    
    [imagView insertSubview:changPic2 aboveSubview:self.imagView2];
    self.label2 = tiplabel2;
    self.control2 = changPic2;

    
    
    
    self.imagView3 = [[ImageViewMine alloc] initWithFrame:CGRectMake(10, 50  +(Width - 30)/2 ,(Width - 30) / 2 , (Width - 30) / 2)];
    [self.imagView3 setImage:image1];
        self.imagView3.userInteractionEnabled = YES;
    self.imagView3.layer.cornerRadius = (Width - 30) / 4;
    self.imagView3.layer.masksToBounds = YES;
    self.imagView3.clipsToBounds = YES;
    
    self.imagView3.contentMode = UIViewContentModeScaleAspectFill;

     [imagView addSubview:self.imagView3];

    
    //切换图片3 的蒙版
    UIControl *changPic3 = [[UIControl alloc] initWithFrame:CGRectMake(10, 104 +10 - 64 +(Width - 30)/2,(Width - 30) / 2 , (Width - 30) / 2)];
    changPic3.layer.cornerRadius = (Width - 30) / 4;
    
    [changPic3 setBackgroundColor:[UIColor colorWithWhite: 0 alpha: 0.7]];
    
    UILabel *tiplabel3 = [[UILabel alloc] init];
    tiplabel3.center = CGPointMake( self.imagView3.frame.size.width * 0.5,self.imagView3.frame.size.height * 0.5);
    tiplabel3.bounds = CGRectMake(0, 0, self.imagView3.frame.size.width * 0.5, self.imagView3.frame.size.height * 0.5);
    
    tiplabel3.text = @"添加图片";
    tiplabel3.textAlignment = NSTextAlignmentCenter;
    tiplabel3.textColor = [UIColor whiteColor];
    [changPic3 addSubview:tiplabel3];
    
    [imagView insertSubview:changPic3 aboveSubview:self.imagView3];
    
    self.label3 = tiplabel3;
    self.control3 = changPic3;
    
    
    
    
    
    
    
    
    
    
    
    
    self.imagView4 = [[ImageViewMine alloc] initWithFrame:CGRectMake(20 +( (Width - 30) / 2) , 50 +((Width - 30)/2), (Width - 30)/2, (Width - 30) / 2)];
    [self.imagView4 setImage:image1];

        self.imagView4.userInteractionEnabled = YES;
    self.imagView4.layer.cornerRadius = (Width - 30) / 4;
    self.imagView4.layer.masksToBounds = YES;
    self.imagView4.clipsToBounds = YES;
    
    self.imagView4.contentMode = UIViewContentModeScaleAspectFill;

       [imagView addSubview:self.imagView4];

    //切换图片4 的蒙版
    

    
    UIControl *changPic4 = [[UIControl alloc] initWithFrame:CGRectMake(20 +( (Width - 30) / 2), 104 + 10 - 64 +((Width - 30)/2),(Width - 30) / 2 , (Width - 30) / 2)];
    
    changPic4.layer.cornerRadius = (Width - 30) / 4;
    
    
    
    [changPic4 setBackgroundColor:[UIColor colorWithWhite: 0 alpha: 0.7]];
    
    
    
    UILabel *tiplabel4 = [[UILabel alloc] init];
    
    tiplabel4.center = CGPointMake( self.imagView4.frame.size.width * 0.5,self.imagView4.frame.size.height * 0.5);
    tiplabel4.bounds = CGRectMake(0, 0, self.imagView4.frame.size.width * 0.5, self.imagView4.frame.size.height * 0.5);
    
    tiplabel4.text = @"添加图片";
    
    tiplabel4.textAlignment = NSTextAlignmentCenter;
    
    tiplabel4.textColor = [UIColor whiteColor];
    
    [changPic4 addSubview:tiplabel4];
    
    
    
//    [self addSubview:changPic4];
    [imagView insertSubview:changPic4 aboveSubview:self.imagView4];
    self.label4 = tiplabel4;
    self.control4 = changPic4;
    
    
    
    
    
    
    
    
    
    
    self. imagView5 = [[ImageViewMine alloc] initWithFrame:CGRectMake(20 +( (Width - 30) / 2), 60 +(Width - 30), (Width - 30)/2, (Width - 30)/2)];
    [self.imagView5 setImage:image1];
        self.imagView5.userInteractionEnabled = YES;
    self.imagView5.layer.cornerRadius = (Width - 30) / 4;
    self.imagView5.layer.masksToBounds = YES;
    self.imagView5.clipsToBounds = YES;
    
    self.imagView5.contentMode = UIViewContentModeScaleAspectFill;

      [imagView addSubview:self.imagView5];
    //切换图片5 的蒙版
    
    UIControl *changPic5 = [[UIControl alloc] initWithFrame:CGRectMake(20 +( (Width - 30) / 2), 104 + - 64 + 20+(Width - 30),(Width - 30) / 2 , (Width - 30) / 2)];
    
    changPic5.layer.cornerRadius = (Width - 30) / 4;
    
    [changPic5 setBackgroundColor:[UIColor colorWithWhite: 0 alpha: 0.7]]; 
    
    UILabel *tiplabel5 = [[UILabel alloc] init];
    
    tiplabel5.center = CGPointMake(self.imagView2.frame.size.width * 0.5,self.imagView5.frame.size.height * 0.5);
    
    tiplabel5.bounds = CGRectMake(0, 0, self.imagView5.frame.size.width * 0.5, self.imagView5.frame.size.height * 0.5);
    
    tiplabel5.text = @"添加图片";
    
    tiplabel5.textAlignment = NSTextAlignmentCenter;
    
    tiplabel5.textColor = [UIColor whiteColor];
    
    [changPic5 addSubview:tiplabel5];
    
    
    
//    [self addSubview:changPic5];
    [imagView insertSubview:changPic5 aboveSubview:self.imagView5];
    
    self.label5 = tiplabel5;
    self.control5 = changPic5;
    
    
    
    
    
    
    
    
    
    self. imagView6 = [[ImageViewMine alloc] initWithFrame:CGRectMake(20 +( (Width - 30) / 2), 70 +(Width - 30) * 1.5, (Width - 30)/2, (Width - 30)/2)];
    [self.imagView6 setImage:image1];
        self.imagView6.userInteractionEnabled = YES;
    self.imagView6.layer.cornerRadius = (Width - 30) / 4;
    self.imagView6.layer.masksToBounds = YES;
    self.imagView6.clipsToBounds = YES;
    
    self.imagView6.contentMode = UIViewContentModeScaleAspectFill;

    [imagView addSubview:self.imagView6];

    //切换图片2 的蒙版
    
    UIControl *changPic6 = [[UIControl alloc] initWithFrame:CGRectMake(20 +( (Width - 30) / 2), 104 - 64 +  30 +(Width - 30) * 1.5 ,(Width - 30) / 2 , (Width - 30) / 2)];
    
    changPic6.layer.cornerRadius = (Width - 30) / 4;
    [changPic6 setBackgroundColor:[UIColor colorWithWhite: 0 alpha: 0.7]];
    UILabel *tiplabel6 = [[UILabel alloc] init];
    
    tiplabel6.center = CGPointMake(self.imagView6.frame.size.width * 0.5,self.imagView6.frame.size.height * 0.5);
    tiplabel6.bounds = CGRectMake(0, 0, self.imagView6.frame.size.width * 0.5, self.imagView6.frame.size.height * 0.5);
    
    tiplabel6.text = @"添加图片";
    
    tiplabel6.textAlignment = NSTextAlignmentCenter;
    
    tiplabel6.textColor = [UIColor whiteColor];
    
    [changPic6 addSubview:tiplabel6];
    
    
    //保存后的角标
    UILabel *labelTime = [[UILabel alloc] initWithFrame:CGRectMake(Width - 120,(Height * 1.5) + 10 ,100 , 30)];
    
    [self.scrollViewMain addSubview:labelTime];
    self.labelTime = labelTime;
    
    //内容标题
    UITextField *labelName = [[UITextField alloc] initWithFrame:CGRectMake((Width - 200) / 2, 9, 200, 30)];
    labelName.font = [UIFont fontWithName:@"Helvetica" size:30];
    labelName.textAlignment = NSTextAlignmentCenter;
    labelName.placeholder = @"输入内容标题";
    
    labelName.borderStyle = UITextBorderStyleNone;
    [imagView addSubview:labelName];
    self.labelName = labelName;
    
    
//    [self addSubview:changPic6];
    [imagView insertSubview:changPic6 aboveSubview:self.imagView6];
    
    self.label6 = tiplabel6;
    self.control6 = changPic6;
    
   
    //给图片设置tag值
    self.control1.tag = 1;
    self.control2.tag = 2;
    self.control3.tag = 3;
    self.control4.tag = 4;
    self.control5.tag = 5;
    self.control6.tag = 6;
    
    self.imagView1.tag = 101;
    self.imagView2.tag = 102;
    self.imagView3.tag = 103;
    self.imagView4.tag = 104;
    self.imagView5.tag = 105;
    self.imagView6.tag = 106;
    
    self.label1.tag = 11;
    self.label2.tag = 12;
    self.label3.tag = 13;
    self.label4.tag = 14;
    self.label5.tag = 15;
    self.label6.tag = 16;
 
  
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 70 +(Width - 30), (Width - 30)/2, (Width - 30))];
    
     textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    textView.text = @"人一生有起有落，起的时候不忘落的时候，落的时候想想起的时候，哪里跌倒，哪里站起。\n相信有自信的生命与没自信的生命会有不一样的天地";
    textView.pagingEnabled = NO;
    textView.font = [UIFont systemFontOfSize:20];
    textView.textColor = [UIColor grayColor];
    textView.textAlignment = NSTextAlignmentCenter;
    
    
    textView.backgroundColor = [UIColor whiteColor];
    [imagView addSubview:textView];
    self.textView = textView;
    
//    [imagView setImage:image];
    
    
    
    [scrollView addSubview:imagView];
    
    
//    if (image.size.height > Height) {
    
        scrollView.contentSize = CGSizeMake(Width, (Height * 1.5) + 216);
        
//    }
    
}










@end
