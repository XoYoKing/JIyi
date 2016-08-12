//
//  WaterFallFlowLayout.h
//  ColorfulTravelNotes
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFallFlowLayout : UICollectionViewFlowLayout

@property(nonatomic,assign)id<UICollectionViewDelegateFlowLayout> delegate;

@property(nonatomic,assign)NSInteger cellCount;//cell的个数

@property(nonatomic,strong)NSMutableArray *colArr;//存放列的高度


@property(nonatomic,strong)NSMutableDictionary *attributeDict;//cell的位置信息

@end
