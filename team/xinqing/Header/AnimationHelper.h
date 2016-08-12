//
//  AnimationHelper.h
//  team
//
//  Created by apple on 15/11/18.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimationHelper : NSObject
+(instancetype)sharedManager;
-(CATransition *)MyCAnimation:(UIView *)viewNum upDown:(BOOL)boolUpDown typeAnimation:(NSString *)typeAnimation duration:(CGFloat)duration;
/*
 Fade = 1,                   //淡入淡出
 Push,                       //推挤
 Reveal,                     //揭开
 MoveIn,                     //覆盖
 Cube,                       //立方体
 SuckEffect,                 //吮吸
 OglFlip,                    //翻转
 RippleEffect,               //波纹
 PageCurl,                   //翻页
 PageUnCurl,                 //反翻页
 CameraIrisHollowOpen,       //开镜头
 CameraIrisHollowClose,      //关镜头
 CurlDown,                   //下翻页
 CurlUp,                     //上翻页
 FlipFromLeft,               //左翻转
 FlipFromRight,              //右翻转
 */

@end
