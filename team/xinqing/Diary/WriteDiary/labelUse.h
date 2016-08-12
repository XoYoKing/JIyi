//
//  labelUse.h
//  DropDown
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 clyd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface labelUse : UILabel

-(void)addTarget:(id)target
          action:(SEL)action
forControlEvents:(UIControlEvents)controlEvents;


@end
