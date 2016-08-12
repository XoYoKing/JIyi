//
//  ImageViewMine.m
//  team
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "ImageViewMine.h"

@interface ImageViewMine ()
{
    //声明3个私有实例变量
    id _target;
    SEL _action;
    UIControlEvents _controlEvents;
}

@end


@implementation ImageViewMine

-(void)addTarget:(id)target
          action:(SEL)action
forControlEvents:(UIControlEvents)controlEvents{
    
    _target = target;
    _action = action;
    _controlEvents = controlEvents;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //判断当前触发方式是否为 TouchUpInside
    if (_controlEvents == UIControlEventTouchUpInside) {
        //让_target去执行_action消息,并且把self作为参数传递
        [_target performSelector:_action withObject:self];
        
    }
}

@end
