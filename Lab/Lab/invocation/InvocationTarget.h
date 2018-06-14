//
//  InvocationTarget.h
//  Lab
//
//  Created by zhaohao on 2018/6/4.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InvocationTarget : NSObject

- (void)noArgumentReturnMethod;

- (NSInteger)returnIntNoArgumentMethod;

- (UIViewController *)returnControllerNoArgumentMethod;

- (UIViewController *)returnControllerColorArgumentMethod:(UIColor *)color colorName:(NSString *)colorName;

@end
