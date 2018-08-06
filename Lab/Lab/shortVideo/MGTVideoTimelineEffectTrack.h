//
//  MGTVideoTimelineEffectTrack.h
//  Lab
//
//  Created by zhaohao on 2018/8/6.
//

#import "MGTVideoTimelineBaseTrack.h"

UIKIT_EXTERN NSString *const kEffectTrackItemPanEvent;
UIKIT_EXTERN NSString *const kEffectTrackItemPositionUserInfoKey;

@interface MGTVideoTimelineEffectTrack : MGTVideoTimelineBaseTrack

- (void)showTrackItem;

- (void)setupTrackItem;

- (void)hideTrackItem;

@end
