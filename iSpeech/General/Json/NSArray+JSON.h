//
//  NSArray+JSON.h
//  App
//
//  Created by m on 16/3/22.
//  Copyright © 2016年 上海宝云网络. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JSON)

- (NSString *)jsonString;
+ (NSArray *)fromJsonString:(NSString *)s;

@end
