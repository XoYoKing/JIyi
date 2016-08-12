//
//  Weather.m
//  Weather
//
//  Created by lanou3g on 15/11/7.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "Weather.h"

@implementation Weather

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    NSLog(@"%@",key);
    if ([key isEqualToString:@"市名"]) {
        
        self.provinces = value;
        
    }
    if ([key isEqualToString:@"编码"]) {
        
        self.coding = value;
        
    }
    
    if ([key isEqualToString:@"省"]) {
        
//        self.flag = [value stringValue];
        self.flag = value;
        
    }
    
}




@end
