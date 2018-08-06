//
//  MGTVideoEditorPanelOperationBar.h
//  Lab
//
//  Created by hao on 2018/8/5.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const kEditingCancelEvent;
UIKIT_EXTERN NSString *const kEditingConfirmEvent;

@interface MGTVideoEditorPanelOperationBar : UIView

+ (instancetype)barWithTitle:(NSString *)title;

+ (instancetype)barWithCustomView:(UIView *)customView;

@end
