//
//  dataImageManager.m
//  team
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 钮海雷. All rights reserved.
//

#import "dataImageManager.h"
#import "FMDB.h"
@interface dataImageManager ()

@property (nonatomic,strong)NSMutableArray *allDataArray;

@end

@implementation dataImageManager



+ (instancetype)sharedataImageManager
{
    static dataImageManager *Data = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Data = [dataImageManager new];
        
    });
    return Data;
    
}



- (NSMutableArray *)allDataArray
{
    if (!_allDataArray) {
        self.allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

- (NSArray *)allData
{
    return [self.allDataArray copy];
}




- (void)loadDataImageData:(Diary *)ImageData imageArray:(NSMutableArray *)imageArray
{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"dataImageManager.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
    };
    //    [db executeUpdate:@"drop table instance"];
    [db executeUpdate:@"CREATE TABLE if not exists '%@' ('instance' BLOB)",ImageData.name];
    
    NSMutableData *mutData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutData];
    [archiver encodeObject:imageArray];
    [archiver finishEncoding];
    [db executeUpdate:@"insert into (?) ('instance')values('%@')",ImageData.name,mutData];
    
    [db close];
}

- (NSArray *)selectImageArrayName:(Diary *)ArrayName
{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"dataImageManager.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    self.allDataArray = [[NSMutableArray alloc] initWithCapacity:20];
    if (![db open]) {
        NSLog(@"Could not open db.");
    };
    
    FMResultSet *rs = [db executeQuery:@"select * from (?)",ArrayName.name];
    NSData *result = nil;
    while ([rs next]) {
        NSData *data = [rs dataForColumn:@"instance"];
        NSLog(@"%@",data);
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        self.allDataArray = [unarchiver decodeObject];
        [unarchiver finishDecoding];
        NSLog(@"%@",result);
    }
    [rs close];
    [db close];
    return  self.allDataArray;
}

- (void)deleateImageArrayName:(Diary *)ArrayName
{
    //    DELETE FROM 'instance' WHERE Title = '%@'",Title
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"dataImageManager.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
    };
    [db executeUpdate:@"DELETE FROM 'instance' WHERE name = '%@'",ArrayName.name];
    
    [db close];
}









@end
