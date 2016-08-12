//
//  ModelColor.m
//  team
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "ModelColor.h"

@implementation ModelColor


- (instancetype)initWithCGColor:(NSString *)rgb1 Rgb2:(NSString *)rgb2 Rgb3:(NSString *)rgb3
{
    if (self = [super init]) {
        _Rgb1 = rgb1;
        _Rgb2=  rgb2;
        _Rgb3 = rgb3;
        
    }
    return self;
}

@end
