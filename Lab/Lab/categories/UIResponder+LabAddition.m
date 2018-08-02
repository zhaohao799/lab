//
//  UIResponder+LabAddition.m
//  Lab
//
//  Created by zhaohao on 2018/8/2.
//

#import "UIResponder+LabAddition.h"

@implementation UIResponder (LabAddition)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
