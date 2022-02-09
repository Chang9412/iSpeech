//
//  IPVipActiveView.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/2/9.
//

#import "IPVipActiveView.h"

@interface IPVipActiveView ()

@end

@implementation IPVipActiveView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor randomFlatColor];
}

@end
