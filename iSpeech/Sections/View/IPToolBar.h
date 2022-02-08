//
//  IPToolBar.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IPToolBar : UIView

@property (nonatomic, copy) void(^didSelected)(NSInteger index);


@end

NS_ASSUME_NONNULL_END
