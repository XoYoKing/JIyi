//
//  ModelColor.h
//  team
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelColor : NSObject

@property (nonatomic,strong)NSString *Rgb1;
@property(nonatomic,strong)NSString *Rgb2;
@property(nonatomic,strong)NSString *Rgb3;
@property (nonatomic,strong)NSString *Fonts;
@property (nonatomic,strong)NSString *FontsSize;
@property(nonatomic,strong)NSString *FontsColor;

- (instancetype)initWithCGColor:(NSString *)rgb1
                           Rgb2:(NSString *)rgb2
                           Rgb3:(NSString *)rgb3;

@end
