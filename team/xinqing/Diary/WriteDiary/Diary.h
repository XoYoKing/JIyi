//
//  Diary.h
//  team
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Diary : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *textContact;
@property(nonatomic,strong)NSString *textWeather;
@property (nonatomic,strong)NSString *index;
@property (nonatomic,strong)NSData *imageArray;


@end
