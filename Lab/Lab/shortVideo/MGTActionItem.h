//
//  MGTActionItem.h
//  Lab
//
//  Created by zhaohao on 2018/8/2.
//

#import <UIKit/UIKit.h>

@interface MGTActionItem : UIView

@property (strong, nonatomic, readonly) UIImage *image;

@property (copy, nonatomic, readonly) NSString *title;

@property (strong, nonatomic, readonly) UIView *customView;

+ (instancetype)itemWithImage:(nullable UIImage *)image title:(nullable NSString *)title event:(nullable NSString *)eventName;

+ (instancetype)itemWithImage:(nullable UIImage *)image event:(nullable NSString *)eventName;

+ (instancetype)itemWithTitle:(nullable NSString *)title event:(nullable NSString *)eventName;

+ (instancetype)itemWithCustomView:(UIView *)customerView event:(nullable NSString *)eventName;

@end
