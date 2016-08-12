//
//  AnimationHelper.m
//  team
//
//  Created by apple on 15/11/18.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "AnimationHelper.h"

@implementation AnimationHelper

+(instancetype)sharedManager{
    
    static AnimationHelper * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AnimationHelper new];
    });
    return manager;
}




-(CATransition *)MyCAnimation:(UIView *)viewNum upDown:(BOOL )boolUpDown typeAnimation:(NSString *)typeAnimation duration:(CGFloat)duration{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = duration ;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.endProgress = 1;
    animation.removedOnCompletion = NO;
    animation.type = typeAnimation;//101
    if (boolUpDown) {
        animation.subtype = kCATransitionFromRight;
    }else{
        animation.subtype = kCATransitionFromLeft;
    }
    
    return animation;
}


@end
