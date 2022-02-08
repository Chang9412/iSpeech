//
//  IPRecordViewController.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, IPRecordViewControllerStyle) {
    IPRecordViewControllerStyleRecorder,
    IPRecordViewControllerStylePlayAudio,
};

@interface IPRecordViewController : UIViewController

- (instancetype)initWithStyle:(IPRecordViewControllerStyle)style url:(NSURL * _Nullable)url;

@end

NS_ASSUME_NONNULL_END
