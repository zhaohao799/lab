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

@interface MGTVideoEditorFrame : UIView

@property (strong, nonatomic, readonly) UIView *editorView;

- (void)switchMode:(MGTVideoEditorMode)mode;

@end
