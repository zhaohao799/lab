//
//  WCShareView.h
//  MiGuWorldCup
//
//  Created by zhaohao on 2018/5/24.
//  Copyright © 2018年 咪咕. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WCShareViewDelegate <NSObject>

- (void)shareToPlatform:(NSString *_Nonnull)platform;

@end

@interface WCShareView : UIView

@property (nonatomic, weak) id<WCShareViewDelegate> delegate;

- (void)showWithStyle:(NSString *_Nullable)styleImageUrl orientation:(NSString *_Nonnull)orientation;

- (void)showWithStyle:(NSString *)styleImageUrl;

@end
