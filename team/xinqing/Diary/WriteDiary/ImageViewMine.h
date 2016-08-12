//
//  ImageViewMine.h
//  team
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewMine : UIImageView

-(void)addTarget:(id)target
          action:(SEL)action
forControlEvents:(UIControlEvents)controlEvents;


@end
