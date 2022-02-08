//
//  IPRecognizerHelper.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class IPRecordViewController;

@interface IPRecognizerHelper : NSObject

+ (BOOL)openUrl:(NSURL *)url;

+ (IPRecordViewController *)openRecorderViewController;
+ (IPRecordViewController *)openRecognizerViewControllerWithUrl:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
