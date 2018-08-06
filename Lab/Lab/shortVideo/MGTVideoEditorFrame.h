//
//  MGTVideoEditorFrame.h
//  Lab
//
//  Created by zhaohao on 2018/8/3.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MGTVideoEditorMode){
    MGTVideoEditorModeNormal,
    MGTVideoEditorModeEditing
};

UIKIT_EXTERN NSString *const kMusicItemEvent;
UIKIT_EXTERN NSString *const kAudioItemEvent;
UIKIT_EXTERN NSString *const kVolumeItemEvent;
UIKIT_EXTERN NSString *const kEffectItemEvent;
UIKIT_EXTERN NSString *const kEditorPlayingEvent;
UIKIT_EXTERN NSString *const kEditorStopEvent;
UIKIT_EXTERN NSString *const kNextButtonTap;
UIKIT_EXTERN NSString *const kBackButtonTap;

@interface MGTVideoEditorFrame : UIView

@property (strong, nonatomic, readonly) UIView *editorView;

- (instancetype)initWithMode:(MGTVideoEditorMode)mode;

- (void)switchMode:(MGTVideoEditorMode)mode;

@end
