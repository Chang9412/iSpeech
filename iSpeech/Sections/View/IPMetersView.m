//
//  IPMetersView.m
//  iSpeech
//
//  Created by zhengqiang zhang on 2022/1/10.
//

#import "IPMetersView.h"

static float kLineWidth = 3;
static float kLinespace = 2;

@interface IPMetersView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) NSMutableArray *meters;
@property (nonatomic, strong) NSMutableArray *paths;

@end

@implementation IPMetersView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.meters = [NSMutableArray array];
    self.paths = [NSMutableArray array];
    [self.layer addSublayer:self.shapeLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.shapeLayer.frame = self.bounds;
}

- (void)updateMeters:(NSArray *)meters {
    if (!meters || meters.count == 0) {
        return;
    }
    NSInteger maxCount = CGRectGetWidth(self.bounds) / (kLineWidth + kLinespace);
    if (self.meters.count >= maxCount) {
        [self.meters removeObjectsInRange:NSMakeRange(0, self.meters.count - maxCount + 1)];
    }
    [self.meters addObject:meters.firstObject];
    [self.paths removeAllObjects];
    for (NSNumber *value in self.meters) {
        float meter = 1- ABS([value floatValue] / 120);
        NSInteger index = [self.meters indexOfObject:value];
        float top = CGRectGetHeight(self.bounds) * (1 - meter) / 2;
        float bottom = CGRectGetHeight(self.bounds) * (1 + meter) / 2;
        CGPoint p1 = CGPointMake(index * (kLinespace + kLineWidth) - kLineWidth, top);
        CGPoint p2 = CGPointMake(index * (kLinespace + kLineWidth), top);
        CGPoint p3 = CGPointMake(index * (kLinespace + kLineWidth), bottom);
        CGPoint p4 = CGPointMake(index * (kLinespace + kLineWidth) - kLineWidth, bottom);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:p1];
        [path addLineToPoint:p2];
        [path addLineToPoint:p3];
        [path addLineToPoint:p4];
        [path addLineToPoint:p1];
        [self.paths addObject:path];
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, 0, 0);
    UIBezierPath *thePath = [UIBezierPath bezierPath];
    for (UIBezierPath *path in self.paths) {
        [[UIColor flatGreenColor] setFill];
        [path fill];
        [thePath appendPath:path];
    }
    self.shapeLayer.path = thePath.CGPath;
    UIGraphicsEndImageContext();
}

- (CAShapeLayer *)shapeLayer {
    if (_shapeLayer) {
        return _shapeLayer;
    }
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = [UIColor flatGreenColor].CGColor;
    return _shapeLayer;
}

- (CADisplayLink *)link {
    if (_link) {
        return _link;
    }
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _link.paused = YES;
    _link.preferredFramesPerSecond = 20;
    return _link;
}

@end
