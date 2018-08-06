//
//  MGTVideoTimelineEffectTrack.m
//  Lab
//
//  Created by zhaohao on 2018/8/6.
//

#import "MGTVideoTimelineEffectTrack.h"
#import "UIResponder+LabAddition.h"

NSString *const kEffectTrackItemPanEvent = @"kEffectTrackItemPanEvent";
NSString *const kEffectTrackItemPositionUserInfoKey = @"kEffectTrackItemPosition";

@interface MGTVideoTimelineEffectTrack()

@property (strong, nonatomic) UIImageView *item;

@end

@implementation MGTVideoTimelineEffectTrack

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _item = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"trackItem"]];
        _item.frame = CGRectMake(0, 0, 26, self.bounds.size.height);
        _item.center = self.center;
        [self addSubview:_item];
        
        _item.userInteractionEnabled = YES;
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onItemPan:)];
        [_item addGestureRecognizer:panGesture];
    }
    
    return self;
}

- (void)onItemPan:(UIPanGestureRecognizer *)panGesture {
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGesture translationInView:self];
        CGFloat newPosition = self.item.center.x + translation.x;
        if (newPosition < 0) {
            newPosition = 3;
        }
        if (newPosition > self.bounds.size.width - 3) {
            newPosition = self.bounds.size.width - 3;
        }
        self.item.center = CGPointMake(newPosition, self.sequenceView.center.y);
        [panGesture setTranslation:CGPointZero inView:self];
        
        [self routerEventWithName:kEffectTrackItemPanEvent userInfo:@{kEffectTrackItemPositionUserInfoKey:[NSNumber numberWithFloat:self.item.center.x / self.sequenceView.bounds.size.width]}];
    }
}

- (void)setupTrackItem {
    self.item.center = self.sequenceView.center;
    [self showTrackItem];
}

- (void)showTrackItem {
    self.item.hidden = NO;
}

- (void)hideTrackItem {
    self.item.hidden = YES;
}

@end
