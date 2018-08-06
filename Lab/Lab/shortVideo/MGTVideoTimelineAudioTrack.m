//
//  MGTVideoTimelineAudioTrack.m
//  Lab
//
//  Created by zhaohao on 2018/8/6.
//

#import "MGTVideoTimelineAudioTrack.h"

@interface MGTVideoTimelineAudioTrack()

@property (strong, nonatomic) NSMutableArray <UIView *> *dubbingItems;

@end

@implementation MGTVideoTimelineAudioTrack

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _dubbingItems = [NSMutableArray array];
    }
    return self;
}

- (void)addDubbingItemAtPositiongX:(CGFloat)fractionalX {
    CGFloat positionX = fractionalX * self.bounds.size.width;
    UIView *item = [[UIView alloc] initWithFrame:CGRectMake(positionX, 3, 2, self.sequenceView.bounds.size.height)];
    item.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"audioTrackItem"]];
    item.contentMode = UIViewContentModeCenter;
    
    [self addSubview:item];
    [self.dubbingItems addObject:item];
}

- (void)updateLastDubbingItemWithSpan:(CGFloat)fraction {
    CGFloat span = fraction * self.bounds.size.width;
    UIView *item = self.dubbingItems.lastObject;
    if (item.frame.size.width + span + item.frame.origin.x >= self.bounds.size.width) {
        return;
    }
    [UIView animateWithDuration:0.04 animations:^{
        item.frame = CGRectMake(item.frame.origin.x, item.frame.origin.y, item.frame.size.width + span, item.frame.size.height);
    }];
}

- (void)removeLastDubbingItem {
    UIView *item = self.dubbingItems.lastObject;
    [item removeFromSuperview];
    [self.dubbingItems removeLastObject];
}

@end
