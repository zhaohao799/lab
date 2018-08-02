//
//  UIAlertController+LabAddition.h
//  Lab
//
//  Created by zhaohao on 2018/8/2.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (LabAddition)

+ (instancetype)mgt_alertSheetWithActionTitles:(nonnull NSArray<NSString *> *)titleArray titleColors:(nonnull NSArray<UIColor *>*)colorArray handlers:(nonnull NSArray<void (^)(UIAlertAction *action)> *)handlerArray;

+ (instancetype)mgt_alertSheetWithActionTitles:(NSArray<NSString *> *)titleArray titleColors:(NSArray<UIColor *> *)colorArray events:(NSArray<NSString *> *)eventArray routerView:(UIView *)routerView;

@end
