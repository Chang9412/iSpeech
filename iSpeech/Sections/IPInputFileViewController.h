//
//  IPInputFileViewController.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IPInputFileViewController : UIViewController

@property (nonatomic, copy) void(^didPickDocument)(NSURL *url);


@end

NS_ASSUME_NONNULL_END
