//
//  UIAlertController+LabAddition.h
//  Lab
//
//  Created by zhaohao on 2018/8/2.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (LabAddition)

/**
 @brief UIAlertController 分类，提供 sheet style 的 alert 工厂方法

 @param titleArray sheet action 对应的标题数组
 @param colorArray 标题对应的现实颜色
 @param handlerArray sheet action 对应的回调 block
 @return 生成的 UIAlertController 对象实例
 */
+ (instancetype)mgt_alertSheetWithActionTitles:(nonnull NSArray<NSString *> *)titleArray titleColors:(nonnull NSArray<UIColor *>*)colorArray handlers:(nonnull NSArray<void (^)(UIAlertAction *action)> *)handlerArray;


/**
 @brief UIAlertController 分类，提供 sheet style 的 alert 工厂方法

 @param titleArray sheet action 对应的标题数组
 @param colorArray 标题对应的现实颜色
 @param eventArray sheet action 对应的事件数组
 @param routerView 传递 action event 的 view 对象实例
 @return 生成的 UIAlertController 对象实例
 */
+ (instancetype)mgt_alertSheetWithActionTitles:(NSArray<NSString *> *)titleArray titleColors:(NSArray<UIColor *> *)colorArray events:(NSArray<NSString *> *)eventArray routerView:(UIView *)routerView;

@end

