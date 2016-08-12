//
//  RootViewController.m
//  lesosn7scrollView
//
//  Created by lanou3g on 15/9/7.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "RootViewController.h"
#import "RootView.h"
@interface RootViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)RootView *rootView;
@end

@implementation RootViewController

-(void)loadView{
  
    self.rootView = [[RootView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.view = self.rootView;

    
}

- (BOOL)prefersStatusBarHidden
{
    
    return YES;//隐藏为YES，显示为NO
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        
        // iOS 7
        
        [self prefersStatusBarHidden];
        
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *img = [UIImage imageWithData:self.data];
    
    self.rootView.imgView.image = img;
    self.rootView.imgView.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    self.rootView.imgView.center = CGPointMake(Width / 2 , Height/2);
    
    
    
    self.rootView.scrollView.delegate = self;
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tgrAction:)];
    tgr.numberOfTapsRequired = 1;
    tgr.numberOfTouchesRequired = 1;
    [self.rootView addGestureRecognizer:tgr];
    
    
    UITapGestureRecognizer *tgr2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tgrAction2:)];
    
    tgr2.numberOfTapsRequired = 1;
    tgr2.numberOfTouchesRequired = 2;
    
    [self.rootView addGestureRecognizer:tgr2];
    
}
//恢复
- (void)tgrAction2:(UIGestureRecognizer *)sender
{
    [self.rootView normal];
}

//取消回到原先
- (void)tgrAction:(UIGestureRecognizer *)sender
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
    
}

#pragma mark -实现缩放的协议方法
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    //通过Tag值获取内部图片,并返回
   return [scrollView viewWithTag:100];
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
//       //由于缩放及修改了缩放视图大小也修改了contentSize,所以不能 单纯的使用center
//    
    //获取缩放视图位置和大小
    CGRect viewFram  =view.frame;
    //获取scrollView的大小
    CGSize scrollViewSize = scrollView.frame.size;

    //如果内容视图的宽度,小于scrollView的宽度,需要进行计算,否则设置为0;
    if (viewFram.size.width < scrollViewSize.width) {
        viewFram.origin.x = (scrollViewSize.width - viewFram.size.width) / 2;
        
    }else {
        viewFram.origin.x = 0;
    }

    //如果内容视图的高度,小于scrollView的高度,需要进行计算,否则,设置为0;
    if (viewFram.size.height < scrollViewSize.height) {
        viewFram.origin.y = (scrollViewSize.height - viewFram.size.height) / 2;
    }else {
        viewFram.origin.y = 0;
    }
 //将计算好的结果赋值给view
    view.frame = viewFram;
    
    
    
}


@end
