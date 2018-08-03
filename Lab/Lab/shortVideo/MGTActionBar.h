//
//  MGTActionBar.h
//  Lab
//
//  Created by zhaohao on 2018/8/2.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MGTActionBarStyle) {
    MGTActionBarStylePortrait,
    MGTActionBarStyleLandscape
};

@class MGTActionItem;
@interface MGTActionBar : UIView

+ (instancetype)actionBarWithStyle:(MGTActionBarStyle)barStyle;

+ (instancetype)actionBarWithItems:(nonnull NSArray<MGTActionItem *> *)itemArray style:(MGTActionBarStyle)barStyle;

- (void)addActionItem:(nonnull MGTActionItem *)item;

- (void)setupLayout;

@end
