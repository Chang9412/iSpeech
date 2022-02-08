//
//  IPBanner.h
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/10.
//

#import <UIKit/UIKit.h>
#import "IPOperation.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, IPBannerAction) {
    IPBannerActionNone = IPOperationTypeNone,
    IPBannerActionInputFile = IPOperationTypeInput,
    IPBannerActionRecoeder = IPOperationTypeRecorder,
    IPBannerActionToAudio = IPOperationTypeTextToAudio,
};

@interface IPBannerItem : NSObject

@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) IPBannerAction action;

+ (NSArray *)banners;

@end

@interface IPBanner : UIView

@property (nonatomic, strong) NSArray *banners;

@property (nonatomic, copy) void(^didSelectItem)(IPBannerItem *item);

@end

NS_ASSUME_NONNULL_END
