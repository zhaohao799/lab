//
//  MGTVideoTimelineAudioTrack.h
//  Lab
//
//  Created by zhaohao on 2018/8/6.
//

#import "MGTVideoTimelineBaseTrack.h"

@interface MGTVideoTimelineAudioTrack : MGTVideoTimelineBaseTrack

- (void)addDubbingItemAtPositiongX:(CGFloat)fractionalX;

- (void)updateLastDubbingItemWithSpan:(CGFloat)fraction;

- (void)removeLastDubbingItem;

@end
