//
//  DBManager.h
//  你听啥
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject
+ (instancetype)showDBManager;

-(void)openDBManager;
-(void)closeDBmanager;

//创建表
- (void)createTable;

//增
- (void)insertDiary:(Diary *)diary;
//删
- (void)deletefromTitle:(NSString *)Title;

//查
- (NSArray *)selectAll;
//
- (NSArray *)selectTitle:(NSString *)Title;
//
- (NSArray *)selectTime:(NSString *)time;











@end
