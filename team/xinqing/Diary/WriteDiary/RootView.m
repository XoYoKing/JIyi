//
//  RootView.m
//  lesosn7scrollView
//
//  Created by lanou3g on 15/9/7.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "RootView.h"

@implementation RootView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[ super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}
//- (void)setData:(NSData *)data
//{
//    self.data = data;
//    UIImage *image = [UIImage imageWithData:self.data];
//    self.imgView.image = image;
//    
//    
//}


-(void)addAllViews{
    //添加UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",NSStringFromCGSize(self.frame.size));
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
//    UIImage *image = [UIImage imageWithData:_data];
    
    //添加图片到滚动视图中
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    imageView.tag = 100;
    [scrollView addSubview:imageView];
    self.imgView = imageView;
    
    //设置内容视图大小
    scrollView.contentSize = imageView.frame.size;
   
    //设置偏移量
//    scrollView.contentOffset = CGPointMake(100, 0);
    //点击状态条是否回到顶部(默认开启)
    scrollView.scrollsToTop = YES;
    //设置是否整页滑动(常用默认关闭)
//    scrollView.pagingEnabled = YES;
    //是否开启边界回弹效果(默认开启)
    scrollView.bounces = YES;
    //设置是否允许滚动(默认开启)
    scrollView.scrollEnabled = YES;
    //如果内容视图contentSize小于ScrollView.frame.size的大小 设置下面两个属性,也可以进行滑动
    //横向
//    scrollView.alwaysBounceHorizontal = NO;
    //竖向
    scrollView.alwaysBounceVertical = YES;
    //设置用户交互
    scrollView.userInteractionEnabled = YES;
    
    //显示横向滚动条
//    scrollView.showsHorizontalScrollIndicator = YES;
    //显示竖向滚动条
//    scrollView.showsVerticalScrollIndicator = YES;
    //设置滚动条
//    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //要想缩放视图,首先要设置最小缩放比,和最大缩放比
    scrollView.minimumZoomScale = 0.2;
    scrollView.maximumZoomScale = 2.;
//    scrollView.zoomScale = 10.0;
    scrollView.bouncesZoom = YES;
    
    
}


- (void) normal{
    //将photoScrollView缩放比例设置为不缩放
    
    self.scrollView.zoomScale = 1;
    
    //将图片的位置调整能为原点对齐
    //获取缩放视图位置和大小
    CGRect viewFram  =CGRectMake(0, 0, _imgView.frame.size.width, _imgView.frame.size.height);
    //获取scrollView的大小
    CGSize scrollViewSize = self.scrollView.frame.size;
    
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
    //将计算好的结果赋值给Imgview
    _imgView.frame = viewFram;
    
    
    
    
    
    
}







@end
