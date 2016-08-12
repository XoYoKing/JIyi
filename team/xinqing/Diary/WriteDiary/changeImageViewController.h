//
//  changeImageViewController.h
//  team
//
//  Created by lanou3g on 15/11/20.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Blcok) (NSData *);
@interface changeImageViewController : UIViewController

@property (nonatomic,strong)NSData *data;

@property(nonatomic,copy)Block block;

@end
