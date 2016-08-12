//
//  dataImageManager.h
//  team
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^Block) ();
@interface dataImageManager : NSObject

@property(nonatomic,strong)Block block;

+ (instancetype)sharedataImageManager;

//增
- (void)loadDataImageData:(Diary *)ImageData imageArray:(NSMutableArray *)imageArray;
//查
- (NSArray *)selectImageArrayName:(Diary *)ArrayName ;
//改
- (void)deleateImageArrayName:(Diary *)ArrayName;



- (NSArray *)allData;



@end
