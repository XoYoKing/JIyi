//
//  ModelViewController.h
//  team
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ModelViewController : UIViewController
+ (instancetype)shareModelVC;
//接收传过来的值，用来确定模板是哪一张图片
@property(nonatomic,assign)NSInteger indexPath;
@property(nonatomic,strong)NSMutableData *data;
@property(nonatomic,strong)NSString *str;
@end
