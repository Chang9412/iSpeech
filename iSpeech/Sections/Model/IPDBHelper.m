//
//  IPDBHelper.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/4.
//

#import "IPDBHelper.h"
#import "DBHelper.h"
#import "IPDaily.h"

static NSString * const kTableName = @"Daily";

static NSString * const kColumnID = @"did";
static NSString * const kColumnTitle = @"title";
static NSString * const kColumnContent = @"content";
static NSString * const kColumnUpdateTime = @"updateTime";
static NSString * const kColumnCreateTime = @"createteTime";
static NSString * const kColumnAudio = @"audio";
static NSString * const kColumnExtraData = @"extraData";

@implementation IPDBHelper

+ (void)initialize {
    [self createTable];
}

+ (void)createTable {
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ("
                     "%@ INTEGER PRIMARY KEY AUTOINCREMENT,"
                     "%@ TEXT,"
                     "%@ TEXT,"
                     "%@ INTEGER,"
                     "%@ INTEGER,"
                     "%@ TEXT,"
                     "%@ TEXT",
                     kTableName,
                     kColumnID,
                     kColumnTitle,
                     kColumnContent,
                     kColumnCreateTime,
                     kColumnUpdateTime,
                     kColumnAudio,
                     kColumnExtraData];
    [DBHelper execSQL:sql];
}

+ (void)insertDaily:(IPDaily *)daily
             intoDB:(FMDatabase *)db {
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO "
                           "%@(%@, %@, %@, %@, %@, %@) VALUES"
                           "(?,?,?,?,?,?)",
                           kTableName,
                           kColumnTitle,
                           kColumnContent,
                           kColumnCreateTime,
                           kColumnUpdateTime,
                           kColumnAudio,
                           kColumnExtraData];
    NSTimeInterval createTime = [[NSDate date] timeIntervalSince1970];
    [db executeUpdate:insertSql, daily.did, daily.title, daily.content, @(createTime), @(createTime), daily.audio, daily.extra, nil];
    daily.did = (NSInteger)[db lastInsertRowId];
}

+ (void)updateDaily:(IPDaily *)daily
             intoDB:(FMDatabase *)db {
    if (daily.did == 0) {
        [self insertDaily:daily intoDB:db];
        return;
    }
    NSTimeInterval updateTime = [[NSDate date] timeIntervalSince1970];
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ "
                           "SET %@ = ?, %@ = ?, %@ = ?, %@ = ?"
                           "%@ = ? WHERE %@ = ?",
                           kTableName,
                           kColumnTitle,
                           kColumnContent,
                           kColumnUpdateTime,
                           kColumnAudio,
                           kColumnExtraData,
                           kColumnID];
    [db executeUpdate:updateSql, daily.title, daily.content, @(updateTime), [daily.audio audioString], daily.extra, nil];
}

+ (void)batchUpdateDailies:(NSArray *)dailies {
    if (dailies.count == 0) {
        return;
    }
    [DBHelper batchUpdate:^(FMDatabase *db) {
        for (IPDaily *daily in dailies) {
            [self updateDaily:daily intoDB:db];
        }
    }];
}

+ (void)deleteDaily:(IPDaily *)daily
             fromDB:(FMDatabase *)db {
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?", kTableName, kColumnID];
    [db executeUpdate:deleteSql, @(daily.did), nil];
}

+ (void)deleteDailies:(NSArray *)dailies {
    if (dailies.count == 0) {
        return;
    }
    [DBHelper batchUpdate:^(FMDatabase *db) {
        for (IPDaily *daily in dailies) {
            [self deleteDaily:daily fromDB:db];
        }
    }];
}

+ (NSArray *)allDailies {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ GROUP BY %@ ORDER BY %@ DESC", kTableName, kColumnID, kColumnUpdateTime];
    NSArray *result = [DBHelper getRows:sql, nil];
    if ([result count] == 0) {
        return @[];
    }
    NSMutableArray *fresult = [NSMutableArray array];
    for (NSDictionary *dict in result) {
        IPDaily *daily = [IPDaily dailyWithDict:dict];
        if (daily) {
            [fresult addObject:daily];
        }
    }
    return fresult;
}


@end
