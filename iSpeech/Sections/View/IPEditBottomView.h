//
//  IPEditView.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IPEditBottomView : UIView

@property (nonatomic, copy) void (^selectAllBlock)(BOOL selected);
@property (nonatomic, copy) void(^deleteBlock)(void);

- (void)selectAll:(BOOL)select;
- (void)enableDelete:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
