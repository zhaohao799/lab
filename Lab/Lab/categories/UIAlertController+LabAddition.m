//
//  UIAlertController+LabAddition.m
//  Lab
//
//  Created by zhaohao on 2018/8/2.
//

#import "UIAlertController+LabAddition.h"
#import "UIResponder+LabAddition.h"

@implementation UIAlertController (LabAddition)

+ (instancetype)mgt_alertSheetWithActionTitles:(NSArray<NSString *> *)titleArray titleColors:(NSArray<UIColor *> *)colorArray handlers:(NSArray<void (^)(UIAlertAction *)> *)handlerArray {
    if (titleArray.count == 0 || handlerArray.count == 0) {
        return nil;
    }
    
    NSMutableArray *actionArray = [NSMutableArray arrayWithCapacity:titleArray.count];
    for (NSInteger index = 0; index < titleArray.count; index++) {
        UIAlertAction *action;
        if (index != (titleArray.count - 1)) {
            if (index < handlerArray.count) {
                action = [UIAlertAction actionWithTitle:titleArray[index] style:UIAlertActionStyleDefault handler:handlerArray[index]];
            } else {
                action = [UIAlertAction actionWithTitle:titleArray[index] style:UIAlertActionStyleDefault handler:nil];
            }
        } else {
            if (index < handlerArray.count) {
                action = [UIAlertAction actionWithTitle:titleArray[index] style:UIAlertActionStyleCancel handler:handlerArray[index]];
            } else {
                action = [UIAlertAction actionWithTitle:titleArray[index] style:UIAlertActionStyleCancel handler:nil];
            }
        }
        [actionArray addObject:action];
    }
    
    if (colorArray.count == 1) {
        UIAlertAction *cancelAction = actionArray.lastObject;
        [cancelAction setValue:colorArray.firstObject forKey:@"titleTextColor"];
    }
    
    if (colorArray.count == 2) {
        for (UIAlertAction *action in [actionArray subarrayWithRange:NSMakeRange(0, actionArray.count - 1)]) {
            [action setValue:colorArray.firstObject forKey:@"titleTextColor"];
        }
        UIAlertAction *cancelAction = actionArray.lastObject;
        [cancelAction setValue:colorArray.lastObject forKey:@"titleTextColor"];
    }
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (UIAlertAction *action in actionArray) {
        [controller addAction:action];
    }
    
    return controller;
}

+ (instancetype)mgt_alertSheetWithActionTitles:(NSArray<NSString *> *)titleArray titleColors:(NSArray<UIColor *> *)colorArray events:(NSArray<NSString *> *)eventArray routerView:(UIView *)routerView {
    if (titleArray.count == 0 || eventArray.count == 0) {
        return nil;
    }
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSMutableArray *actionArray = [NSMutableArray arrayWithCapacity:titleArray.count];
    for (NSInteger index = 0; index < titleArray.count; index++) {
        UIAlertAction *action;
        if (index != (titleArray.count - 1)) {
            if (index < eventArray.count) {
                action = [UIAlertAction actionWithTitle:titleArray[index] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    [controller.presentingViewController routerEventWithName:eventArray[index] userInfo:nil];
                    [routerView routerEventWithName:eventArray[index] userInfo:nil];
                }];
            } else {
                action = [UIAlertAction actionWithTitle:titleArray[index] style:UIAlertActionStyleDefault handler:nil];
            }
        } else {
            if (index < eventArray.count) {
                action = [UIAlertAction actionWithTitle:titleArray[index] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [controller routerEventWithName:eventArray[index] userInfo:nil];
                }];
            } else {
                action = [UIAlertAction actionWithTitle:titleArray[index] style:UIAlertActionStyleCancel handler:nil];
            }
        }
        [actionArray addObject:action];
    }
    
    if (colorArray.count == 1) {
        UIAlertAction *cancelAction = actionArray.lastObject;
        [cancelAction setValue:colorArray.firstObject forKey:@"titleTextColor"];
    }
    
    if (colorArray.count == 2) {
        for (UIAlertAction *action in [actionArray subarrayWithRange:NSMakeRange(0, actionArray.count - 1)]) {
            [action setValue:colorArray.firstObject forKey:@"titleTextColor"];
        }
        UIAlertAction *cancelAction = actionArray.lastObject;
        [cancelAction setValue:colorArray.lastObject forKey:@"titleTextColor"];
    }
    
    
    for (UIAlertAction *action in actionArray) {
        [controller addAction:action];
    }
    
    return controller;
}

@end
