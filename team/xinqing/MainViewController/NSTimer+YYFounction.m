//
//  NSTimer+YYFounction.m
//  YYLunBoScrollView
//
//  Created by wangyuanyuan on 15/3/3.
//  Copyright (c) 2015年 wangyuanyuan. All rights reserved.
//

#import "NSTimer+YYFounction.h"

@implementation NSTimer (YYFounction)

-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}


@end
