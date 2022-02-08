//
//  BYRecognizer.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2021/12/31.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@class BYRecognizer;

@protocol BYRecognizerDelegate <NSObject>

- (void)recognizerError:(NSError *)error;

@end

@interface BYRecognizer : NSObject

@property (nonatomic, weak) id<BYRecognizerDelegate> delegate;

- (void)recognitionWithUrl:(NSURL *)url;

+ (BOOL)supportedFile:(NSString *)file;
+ (NSString *)fileDirectory;

@end

NS_ASSUME_NONNULL_END
