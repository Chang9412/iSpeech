//
//  HomeCell.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2021/12/31.
//

#import <UIKit/UIKit.h>
#import "IPOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeCell : UICollectionViewCell

@end

@interface HomeBaseCell : UICollectionViewCell

@property (nonatomic, copy) void(^didSelectOpration)(IPOperationType type);

@end

@interface HomeCell1 : HomeBaseCell

@property (nonatomic, strong) NSArray *banner;

@end

@interface HomeCell2 : HomeBaseCell

@end

@interface HomeCell3 : HomeBaseCell

@property (nonatomic, strong) IPOperation *operation;

@end

NS_ASSUME_NONNULL_END
