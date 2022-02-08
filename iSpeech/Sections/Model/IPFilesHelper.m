//
//  IPFilesHelper.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/14.
//

#import "IPFilesHelper.h"
#import <FCFileManager.h>
#import "BYRecorder.h"
#import "BYRecognizer.h"

static NSString * const kFilesSortKey = @"kFilesSortKey";

@implementation IPFilesHelper

+ (NSArray *)allFiles {
    IPFilesSortType type = [[NSUserDefaults standardUserDefaults] integerForKey:kFilesSortKey];
    return [self allFilesSorted:type];
}

+ (NSArray *)allFilesSorted:(IPFilesSortType)type {
    NSString *inboxDirectory = [self inboxDirectory];
    NSString *recorderDirectory = [self recorderDirectory];
    NSString *recognizerDirectory = [self recognizerDirectory];
    NSArray *inboxFiles = [self allFilesInDirectory:inboxDirectory];
    NSArray *recorderFiles = [self allFilesInDirectory:recorderDirectory];
    NSArray *recognizerFiles = [self allFilesInDirectory:recognizerDirectory];

    NSMutableArray *allFiles = [NSMutableArray array];
    [allFiles addObjectsFromArray:inboxFiles];
    [allFiles addObjectsFromArray:recorderFiles];
    [allFiles addObjectsFromArray:recognizerFiles];
    
    NSArray *sortedArray = [allFiles sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString * obj2) {
        NSDictionary *attributes1 = [FCFileManager attributesOfItemAtPath:obj1];
        NSDictionary *attributes2 = [FCFileManager attributesOfItemAtPath:obj2];

        if (type == IPFilesSortTypeCreateTime) {
            return [attributes1[NSFileCreationDate] floatValue] > [attributes2[NSFileCreationDate] floatValue];
        }
        if (type == IPFilesSortTypeCreateTime2) {
            return [attributes1[NSFileCreationDate] floatValue] < [attributes2[NSFileCreationDate] floatValue];
        }
        if (type == IPFilesSortTypeFileSize) {
            return [attributes1[NSFileSize] floatValue] > [attributes2[NSFileSize] floatValue];
        }
        if (type == IPFilesSortTypeFileSize2) {
            return [attributes1[NSFileSize] floatValue] < [attributes2[NSFileSize] floatValue];
        }
        return 0;
    }];
    [[NSUserDefaults standardUserDefaults] setInteger:type forKey:kFilesSortKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSMutableArray *marray = [NSMutableArray array];
    for (NSString *string in sortedArray) {
        IPFile *file = [[IPFile alloc] init];
        file.name = string;
//        file.
        [marray addObject:file];
    }
    return marray;
}

+ (NSArray *)allFilesInDirectory:(NSString *)directory {
    if (![FCFileManager isDirectoryItemAtPath:directory]) {
        return nil;
    }
    NSArray *list = [FCFileManager listFilesInDirectoryAtPath:directory withSuffix:nil];
    return list;
}

+ (BOOL)deleteFileAtPath:(NSString *)path {
    NSError *error;
    [FCFileManager removeItemAtPath:path error:&error];
    if (error) {
        return NO;
    }
    return YES;
}

+ (NSString *)inboxDirectory {
//    return [[FCFileManager pathForDocumentsDirectory] stringByAppendingPathComponent:@"Inbox"];
    return [[FCFileManager pathForDocumentsDirectory] stringByAppendingString:@"/Inbox"];

}

+ (NSString *)recorderDirectory {
    return [BYRecorder fileDirectory];
}

+ (NSString *)recognizerDirectory {
    return [BYRecognizer fileDirectory];
}

@end
