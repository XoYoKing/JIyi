//
//  ContactData.h
//  feel
//
//  Created by lanou3g on 15/11/7.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactData : NSObject

+(instancetype)shareWithContactData;
@property(nonatomic,assign)NSInteger count;


- (void)contactArchiverWithArray:(NSMutableArray *)array Diary:(Diary *)Diary;

- (NSMutableArray *)contactWithDecodeDiary:(Diary *)Diary;

- (NSMutableArray *)removeObjectAtIndexRow:(NSInteger )indexRow;






@end
