//
//  WaterFallUICollectionViewCell.m
//  ColorfulTravelNotes
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "WaterFallUICollectionViewCell.h"
#define WIDTH ([UIScreen mainScreen].bounds.size.width-15)/2


@implementation WaterFallUICollectionViewCell

-(void)setViewColorful:(UIImageView *)viewColorful{
    if (_viewColorful != viewColorful) {
        _viewColorful = viewColorful;
    }
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    
    float newHeight = _viewColorful.frame.size.height/ _viewColorful.frame.size.width*WIDTH;
    [_viewColorful drawRect:CGRectMake(0, 0, WIDTH, newHeight)];
    
    
}


@end
