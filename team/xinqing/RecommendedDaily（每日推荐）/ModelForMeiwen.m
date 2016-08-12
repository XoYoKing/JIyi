//
//  ModelForMeiwen.m
//  team
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "ModelForMeiwen.h"

@implementation ModelForMeiwen


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"extra"]) {
        
        self.extra = @"dfg";
    }
    
}



@end
