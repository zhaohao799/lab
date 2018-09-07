//
//  UIResponder+LabAddition.h
//  Lab
//
//  Created by zhaohao on 2018/8/2.
//

#import <UIKit/UIKit.h>

@interface UIResponder (LabAddition)

/**
 @brief UIResponder 类及子类的对象可以通过响应链传递事件和参数。

 @param eventName 事件名称
 @param userInfo 该事件需要的参数
 */
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end
