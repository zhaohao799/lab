//
//  InvocationTarget.m
//  Lab
//
//  Created by zhaohao on 2018/6/4.
//

#import "InvocationTarget.h"

@implementation InvocationTarget

- (void)noArgumentReturnMethod {
    NSLog(@"\n - call: %@", NSStringFromSelector(_cmd));
}

- (NSInteger)returnIntNoArgumentMethod {
    NSInteger value = 100;
    NSLog(@"\n - call: %@, return value: %ld", NSStringFromSelector(_cmd), value);
    return value;
}

- (UIViewController *)returnControllerNoArgumentMethod {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor cyanColor];
    NSLog(@"\n - call: %@, return value: cyanColor", NSStringFromSelector(_cmd));
    return vc;
}

- (UIViewController *)returnControllerColorArgumentMethod:(UIColor *)color colorName:(NSString *)colorName {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = color;
    NSLog(@"\n - call: %@, return value: %@", NSStringFromSelector(_cmd), colorName);
    return vc;
}

@end
