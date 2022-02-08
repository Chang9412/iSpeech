//
//  IPTransiaction.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/4.
//

#import "IPTransiaction.h"


@interface IPTransiaction ()

@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation IPTransiaction

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];

    [containerView addSubview:self.backgroundView];
    
    BOOL isPresent = (toViewController.presentingViewController == fromViewController);

    if (isPresent) {
        [containerView addSubview:toView];
        toView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(toView.bounds));
        self.backgroundView.alpha = 0;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        if (isPresent) {
            self.backgroundView.alpha = 1;
            toView.transform = CGAffineTransformIdentity;
        } else {
            self.backgroundView.alpha = 0;
            fromView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(fromView.bounds));
        }
    } completion:^(BOOL finished) {
        if (!isPresent) {
            [self.backgroundView removeFromSuperview];
        }
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancelled];
    }];
    
}

- (UIView *)backgroundView {
    if (_backgroundView) {
        return _backgroundView;
    }
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.5];
    return _backgroundView;
}

@end
