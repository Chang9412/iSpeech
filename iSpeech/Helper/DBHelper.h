//
//  DBHelper.h
//  faces
//
//  Created by m on 15/9/15.
//  Copyright (c) 2015年 上海宝云网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

@interface DBHelper : NSObject

+ (NSString *)dbFilePath;

+ (void)batchUpdate:(void(^)(FMDatabase *db)) block;

+ (BOOL)execSQL:(NSString *)sql , ...;

+ (NSArray *)getRows:(NSString *)sql, ...;

+ (NSArray *)getRows:(NSString *)sql params:(NSArray *)params;

+ (NSSet *)getColumnsInTable:(NSString *)table;

+ (NSSet *)getColumnsInTable:(NSString *)table inDB:(FMDatabase *)db;

@end
