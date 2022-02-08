//
//  IPInputFileCell.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IPInputFileCell : UICollectionViewCell

@property (nonatomic, copy) void(^inputBlock)(void);


@end

@interface IPInputFileCell2 : UICollectionViewCell

@end

NS_ASSUME_NONNULL_END
