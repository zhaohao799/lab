//
//  MGTVideoTimelineBaseTrack.m
//  Lab
//
//  Created by zhaohao on 2018/8/6.
//

#import "MGTVideoTimelineBaseTrack.h"
#import <MGTCategories/UIColor+MGTAddition.h>
#import <Masonry/Masonry.h>

@interface MGTVideoTimelineBaseTrack()

@property (strong, nonatomic) UIView *stickArea;

@property (strong, nonatomic) UIView *stick;

@property (strong, nonatomic, readwrite) UIView *sequenceView;

@end

@implementation MGTVideoTimelineBaseTrack

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 30, 54.0f)];
    if (self) {
        _sequenceView = [[UIView alloc] initWithFrame:CGRectMake(0, 3, self.frame.size.width, self.frame.size.height - 6)];
        _sequenceView.backgroundColor = [UIColor orangeColor];
        
        _stickArea = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25.0f, self.frame.size.height)];
        _stick = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 6, self.frame.size.height)];
        _stick.backgroundColor = [UIColor mgt_colorWithHex:0xFE3579];
        _stick.layer.cornerRadius = 3;
        _stick.layer.masksToBounds = YES;
        [_stickArea addSubview:_stick];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onStickPan:)];
        [_stickArea addGestureRecognizer:panGesture];
        
        [self addSubview:_sequenceView];
        [self addSubview:_stickArea];
    }
    
    return self;
}

- (void)updateStickPositionX:(CGFloat)px {
    self.stickArea.center = CGPointMake(px, self.sequenceView.center.y);
}

- (void)onStickPan:(UIPanGestureRecognizer *)panGesture {
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGesture translationInView:self];
        CGFloat newPosition = self.stickArea.center.x + translation.x;
        if (newPosition < 0) {
            newPosition = 3;
        }
        if (newPosition > self.bounds.size.width - 3) {
            newPosition = self.bounds.size.width - 3;
        }
        self.stickArea.center = CGPointMake(newPosition, self.sequenceView.center.y);
        [panGesture setTranslation:CGPointZero inView:self];
    }
}

@end
