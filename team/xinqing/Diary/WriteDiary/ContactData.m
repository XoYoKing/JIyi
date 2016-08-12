//
//  ContactData.m
//  feel
//
//  Created by lanou3g on 15/11/7.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "ContactData.h"

@interface ContactData ()

@property (nonatomic,strong)NSMutableData *Data;
@property (nonatomic,strong)NSMutableArray *allArray;
@property (nonatomic,strong)NSKeyedArchiver *keyedArchiver;
@property (nonatomic,strong)NSKeyedUnarchiver *keyedUnarchiver;



@end

@implementation ContactData


+ (instancetype)shareWithContactData
{
    static ContactData *contact = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        contact = [ContactData new];
        
    });
    
    return contact;
}
//创建可变Data,用来存放归档数据
- (NSMutableData *)Data
{
    if (!_Data) {
        
        self.Data = [[NSMutableData alloc] initWithCapacity:20];
        
    }
    return _Data;
    
}

- (NSMutableArray *)allArray
{
    if (!_allArray) {
        self.allArray = [NSMutableArray new];
    }
    return _allArray;
}

- (NSKeyedArchiver *)keyedArchiver
{
    if (!_keyedArchiver) {
        
        self.keyedArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:self.Data];
        
    }
    return _keyedArchiver;
}

- (NSKeyedUnarchiver *)keyedUnarchiver
{
    if (!_keyedUnarchiver) {
        //沙盒
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        path = [path stringByAppendingFormat:@"/ContactImg.text"];
        
        NSData *Data = [NSData dataWithContentsOfFile:path];
        
        self.keyedUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:Data];
        
    }
    return _keyedUnarchiver;
    
}



//将array归档
- (void)contactArchiverWithArray:(NSMutableArray *)array Diary:(Diary *)Diary;
{
    
//    //沙盒
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    path = [path stringByAppendingFormat:@"/ContactImg.text"];
    
    
    
    //创建可变Data,用来存放归档数据
    //    self.Data = [[NSMutableData alloc] initWithCapacity:20];
    //
    //    //创建归档对象
    //    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:self.Data];
    
    //    //归档
    //    NSString *Str = Diary.name;
    //
    //    [self.keyedArchiver encodeObject:array forKey:Str];
    //
    //    //完成归档
    //    [self.keyedArchiver finishEncoding];
    //    //写入文件
    //    [self.Data writeToFile:path atomically:YES];
    //     [NSKeyedArchiver archiveRootObject:array toFile:path];
    //    NSMutableData *mutData = [NSMutableData data];
    //    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutData];
    //    [archiver encodeObject:array];
    //    [archiver finishEncoding];
    //    Diary.imageArray = mutData;
    
    //    [[dataImageManager sharedataImageManager] loadDataImageData:Diary];
}




//将array反归档
- (NSMutableArray *)contactWithDecodeDiary:(Diary *)Diary
{
    //    //沙盒
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingFormat:@"/ContactImg.text"];
    //
    //    NSData *Data = [NSData dataWithContentsOfFile:path];
    //
    //    NSKeyedUnarchiver *unarchVer = [[NSKeyedUnarchiver alloc] initForReadingWithData:Data];
    
    NSMutableArray *Array =  [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    //    NSString *Str = Diary.name;
    //
    //    NSMutableArray *Array = [self.keyedUnarchiver decodeObjectForKey:Str];
    
    
    
    
    
    
    
    
    return Array;
}

//- (NSMutableArray *)removeObjectAtIndexRow:(NSInteger )indexRow
//{
////    NSMutableArray *array = self.contactWithDecodeDiaty:(nil);
//
//    [array removeObjectAtIndex:indexRow];
//    
//    return array;
//}

//- (NSInteger)count
//{
//    return self.contactWithDecode.count;
//}












@end

