//
//  DBHelper.m
//  faces
//
//  Created by m on 15/9/15.
//  Copyright (c) 2015年 上海宝云网络. All rights reserved.
//

#import "DBHelper.h"
#import <FCFileManager/FCFileManager.h>

static FMDatabaseQueue *dbqueue;
static NSString * const dbName = @"app.db";

@implementation DBHelper

+ (NSString *)dbFilePath {
    return [FCFileManager pathForDocumentsDirectoryWithPath:dbName];
}

+ (void)initialize {
    dbqueue = [FMDatabaseQueue databaseQueueWithPath:[self dbFilePath]];
}

+ (void)batchUpdate:(void(^)(FMDatabase *db))block {
    [dbqueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if (block) {
            block(db);
        }
        *rollback = NO;
    }];
}

+ (BOOL)execSQL:(NSString *)sql ,... {
    __block va_list args;
    va_start(args, sql);
    va_list *bargs = &args;
    __block BOOL result = NO;
    [dbqueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        result = [db executeUpdate:sql withVAList:*bargs];
    }];
    va_end(args);
    return result;
}

+ (NSArray *)getRows:(NSString *)sql, ...{
    __block va_list args;
    __block NSArray *ra = nil;
    va_list *bargs = &args;
    va_start(args, sql);
    [dbqueue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql withVAList:*bargs];
        ra = [self allRecordsFromResult:result];
        [result close];
    }];
    va_end(args);
    return ra;
}

+ (NSArray *)getRows:(NSString *)sql params:(NSArray *)params {
    __block NSArray *ra = nil;
    [dbqueue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql withArgumentsInArray:params];
        ra = [self allRecordsFromResult:result];
        [result close];
    }];
    return ra;
}

+ (NSArray *)allRecordsFromResult:(FMResultSet *)rs {
    NSMutableArray * allRecords = [[NSMutableArray alloc] init];
    if (rs) {
        while ([rs next]) {
            [allRecords addObject:rs.resultDictionary];
        }
    }
    return allRecords;
}

+ (NSSet *)getColumnsInTable:(NSString *)table inDB:(FMDatabase *)db {
    FMResultSet *result = [db getTableSchema:table];
    NSMutableSet *set = [NSMutableSet set];
    if (result ) {
        while ([result next]) {
            NSDictionary *dict = result.resultDictionary;
            NSString *name = dict[@"name"];
            if (name) {
                [set addObject:name];
            }
        }
        [result close];
    }
    return set;
}

+ (NSSet *)getColumnsInTable:(NSString *)table {
    __block NSSet *set;
    [dbqueue inDatabase:^(FMDatabase *db) {
        set = [self getColumnsInTable:table inDB:db];
    }];
    return set;
}

@end
