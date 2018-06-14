//
//  WCShareView.m
//  MiGuWorldCup
//
//  Created by zhaohao on 2018/5/24.
//  Copyright © 2018年 咪咕. All rights reserved.
//

#import "WCShareView.h"
#import <Masonry.h>

@interface WCShareView()

@property (nonatomic, strong) UIView *weibo;
@property (nonatomic, strong) UIView *wechat;
@property (nonatomic, strong) UIView *wechatTimeline;
@property (nonatomic, strong) UIView *qq;
@property (nonatomic, strong) UIView *qqZone;

@property (nonatomic, strong) UIView *landscapeContent;

@property (nonatomic, strong) UIView *contentBackground;
@property (nonatomic, strong) UIView *cancel;
@property (nonatomic, strong) UIView *footer;

@property (nonatomic, strong) UIImageView *styleImageView;

@property (nonatomic, assign) BOOL stylish;
@property (nonatomic, copy) NSString *styleImageUrl;

@end

@implementation WCShareView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _stylish = NO;
        [self layoutNormalPortrait];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onOrientationChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    }
    return self;
}

- (void)onOrientationChanged:(NSNotification *)info {
    [self layout];
}

- (void)showWithStyle:(NSString *_Nullable)styleImageUrl orientation:(NSString *_Nonnull)orientation {
    if (styleImageUrl) {
        self.stylish = YES;
        self.styleImageUrl = styleImageUrl;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:styleImageUrl]];
            UIImage *styleImage = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.styleImageView.image = styleImage;
            });
        });
        if ([orientation isEqualToString:@"portrait"]) {
            [self layoutStylePortrait];
        } else {
            [self layoutStyleLandscape];
        }
    } else {
        self.stylish = NO;
        self.styleImageUrl = nil;
        if ([orientation isEqualToString:@"portrait"]) {
            [self layoutNormalPortrait];
        } else {
            [self layoutNormalLandscape];
        }
    }
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(keyWindow);
    }];
}

- (void)showWithStyle:(NSString *)styleImageUrl {
    if (styleImageUrl) {
        self.stylish = YES;
        self.styleImageUrl = styleImageUrl;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:styleImageUrl]];
            UIImage *styleImage = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.styleImageView.image = styleImage;
            });
        });
        [self layout];
    } else {
        self.stylish = NO;
        self.styleImageUrl = nil;
        [self layout];
    }
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(keyWindow);
    }];
}

- (void)layout {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        if (self.stylish) {
            [self layoutStylePortrait];
        } else {
            [self layoutNormalPortrait];
        }
    }
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        if (self.stylish) {
            [self layoutStyleLandscape];
        } else {
            [self layoutNormalLandscape];
        }
    }
}

#pragma mark ----------- Portrait -----------

- (void)layoutNormalPortrait {
    [self switchLayoutForPortrait];
    
    [self switchColorForPortrait];
}

- (void)layoutStylePortrait {
    [self switchLayoutForPortrait];
    
    [self addSubview:self.styleImageView];
    [self.styleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(43);
        make.leading.equalTo(self.mas_leading).with.offset(70);
        make.bottom.equalTo(self.footer.mas_top).with.offset(-43);
        make.trailing.equalTo(self.mas_trailing).with.offset(-70);
    }];
    
    [self switchColorForPortrait];
}

- (void)switchLayoutForPortrait {
    [self cleanLayout];
    
    [self.contentBackground addSubview:self.weibo];
    [self.contentBackground addSubview:self.wechat];
    [self.contentBackground addSubview:self.wechatTimeline];
    [self.contentBackground addSubview:self.qq];
    [self.contentBackground addSubview:self.qqZone];
    CGFloat padding = ([UIScreen mainScreen].bounds.size.width - 250)/5;
    
    [self addSubview:_footer];
    [_footer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@160);
        make.leading.bottom.and.trailing.equalTo(self);
    }];
    
    [self.footer addSubview:self.cancel];
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.and.trailing.equalTo(self.footer);
        make.height.equalTo(@50);
    }];
    
    [self.wechatTimeline mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentBackground.mas_top).with.offset(22.0f);
        make.centerX.equalTo(self.contentBackground.mas_centerX);
        make.width.equalTo(@50);
        make.height.equalTo(@60);
    }];
    
    [self.wechat mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wechatTimeline.mas_top);
        make.trailing.equalTo(self.wechatTimeline.mas_leading).with.offset(-padding);
        make.width.equalTo(@50);
        make.height.equalTo(@60);
    }];
    
    [self.qq mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wechatTimeline.mas_top);
        make.leading.equalTo(self.wechatTimeline.mas_trailing).with.offset(padding);
        make.width.equalTo(@50);
        make.height.equalTo(@60);
    }];
    
    [self.weibo mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wechatTimeline.mas_top);
        make.trailing.equalTo(self.wechat.mas_leading).with.offset(-padding).priorityLow();
        make.width.equalTo(@50);
        make.height.equalTo(@60);
    }];
    
    [self.qqZone mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wechatTimeline.mas_top);
        make.leading.equalTo(self.qq.mas_trailing).with.offset(padding).priorityLow();
        make.width.equalTo(@50);
        make.height.equalTo(@60);
    }];
}

- (void)switchColorForPortrait {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.footer.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    self.contentBackground.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    self.cancel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    self.weibo.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    self.wechat.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    self.wechatTimeline.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    self.qq.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    self.qqZone.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
}


#pragma mark ----------- Landscape -----------

- (void)layoutNormalLandscape {
    [self cleanLayout];
    [self switchColorForNormalLandscape];
    [self addSubview:self.landscapeContent];
    [self.landscapeContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.and.bottom.equalTo(self);
        make.width.equalTo(@260);
    }];

    [self.landscapeContent addSubview:self.weibo];
    [self.landscapeContent addSubview:self.wechat];
    [self.landscapeContent addSubview:self.wechatTimeline];
    [self.landscapeContent addSubview:self.qq];
    [self.landscapeContent addSubview:self.qqZone];
    
    [self.wechat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.landscapeContent.mas_top).with.offset(34);
        make.centerX.equalTo(self.landscapeContent.mas_centerX);
        make.width.equalTo(@50);
        make.height.equalTo(@60);
    }];
    
    [self.weibo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wechat.mas_top);
        make.trailing.equalTo(self.wechat.mas_leading).with.offset(-30);
        make.width.equalTo(@50);
        make.height.equalTo(@60);
    }];
    
    [self.wechatTimeline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wechat.mas_top);
        make.leading.equalTo(self.wechat.mas_trailing).with.offset(30);
        make.width.equalTo(@50);
        make.height.equalTo(@60);
    }];
    
    [self.qq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weibo.mas_bottom).with.offset(25);
        make.centerX.equalTo(self.weibo.mas_centerX);
        make.width.equalTo(@50);
        make.height.equalTo(@60);
    }];
    
    [self.qqZone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qq.mas_top);
        make.centerX.equalTo(self.wechat.mas_centerX);
        make.width.equalTo(@50);
        make.height.equalTo(@60);
    }];
}

- (void)switchColorForNormalLandscape {
    self.backgroundColor = [UIColor clearColor];
    self.weibo.backgroundColor = [UIColor clearColor];
    self.wechat.backgroundColor = [UIColor clearColor];
    self.wechatTimeline.backgroundColor = [UIColor clearColor];
    self.qq.backgroundColor = [UIColor clearColor];
    self.qqZone.backgroundColor = [UIColor clearColor];
}

- (void)layoutStyleLandscape {
    [self cleanLayout];
    [self addSubview:self.weibo];
    [self addSubview:self.wechat];
    [self addSubview:self.wechatTimeline];
    [self addSubview:self.qq];
    [self addSubview:self.qqZone];
    
    [self switchColorForStyleLandscape];
    
    [self addSubview:self.styleImageView];
    [self.styleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(18);
        make.bottom.equalTo(self.wechatTimeline.mas_top).with.offset(-18);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.wechatTimeline mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(-18.0f);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@50);
        make.height.equalTo(@60);
    }];
    
    [self.wechat mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.wechatTimeline.mas_bottom);
        make.trailing.equalTo(self.wechatTimeline.mas_leading).with.offset(-38);
        make.width.equalTo(@50);
        make.height.equalTo(@60);
    }];
    
    [self.qq mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.wechatTimeline.mas_bottom);
        make.leading.equalTo(self.wechatTimeline.mas_trailing).with.offset(38);
        make.width.equalTo(@50);
        make.height.equalTo(@60);
    }];
    
    [self.weibo mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.wechatTimeline.mas_bottom);
        make.trailing.equalTo(self.wechat.mas_leading).with.offset(-38).priorityLow();
        make.width.equalTo(@50);
        make.height.equalTo(@60);
    }];
    
    [self.qqZone mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.wechatTimeline.mas_bottom);
        make.leading.equalTo(self.qq.mas_trailing).with.offset(38).priorityLow();
        make.width.equalTo(@50);
        make.height.equalTo(@60);
    }];
}

- (void)switchColorForStyleLandscape {
    UIColor *styleColor = [UIColor colorWithRed:29/255.0 green:29/255.0 blue:29/255.0 alpha:0.95];
    self.backgroundColor = styleColor;
    self.weibo.backgroundColor = [UIColor clearColor];
    self.wechat.backgroundColor = [UIColor clearColor];
    self.wechatTimeline.backgroundColor = [UIColor clearColor];
    self.qq.backgroundColor = [UIColor clearColor];
    self.qqZone.backgroundColor = [UIColor clearColor];
}

- (void)cleanLayout {
    [self.weibo removeFromSuperview];
    [self.wechat removeFromSuperview];
    [self.wechatTimeline removeFromSuperview];
    [self.qq removeFromSuperview];
    [self.qqZone removeFromSuperview];
    [self.footer removeFromSuperview];
    [self.landscapeContent removeFromSuperview];
    [self.styleImageView removeFromSuperview];
}

#pragma mark ---------- getter -----------

- (UIView *)weibo {
    if (!_weibo) {
        _weibo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        UIImageView *weiboImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wcWeibo"]];
        UILabel *weiboLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        weiboLabel.font = [UIFont systemFontOfSize:14];
        weiboLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        weiboLabel.text = @"微博";
        weiboLabel.textAlignment = NSTextAlignmentCenter;
        [_weibo addSubview:weiboImage];
        [_weibo addSubview:weiboLabel];
        [weiboImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.width.equalTo(@40);
            make.top.and.centerX.equalTo(self->_weibo);
        }];
        [weiboLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@14);
            make.width.equalTo(@50);
            make.top.equalTo(weiboImage.mas_bottom).with.offset(6.0f);
            make.centerX.equalTo(self->_weibo);
        }];
    }
    return _weibo;
}

- (UIView *)wechat {
    if (!_wechat) {
        _wechat = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        UIImageView *wechatImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wcWechat"]];
        UILabel *wechatLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        wechatLabel.font = [UIFont systemFontOfSize:14];
        wechatLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        wechatLabel.text = @"微信";
        wechatLabel.textAlignment = NSTextAlignmentCenter;
        [_wechat addSubview:wechatImage];
        [_wechat addSubview:wechatLabel];
        [wechatImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.width.equalTo(@40);
            make.top.and.centerX.equalTo(self->_wechat);
        }];
        [wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@14);
            make.width.equalTo(@50);
            make.top.equalTo(wechatImage.mas_bottom).with.offset(6.0f);
            make.centerX.equalTo(self->_wechat);
        }];
    }
    return _wechat;
}

- (UIView *)wechatTimeline {
    if (!_wechatTimeline) {
        _wechatTimeline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        UIImageView *timelineImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wcTimeline"]];
        UILabel *timelineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        timelineLabel.font = [UIFont systemFontOfSize:14];
        timelineLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        timelineLabel.text = @"朋友圈";
        timelineLabel.textAlignment = NSTextAlignmentCenter;
        [_wechatTimeline addSubview:timelineImage];
        [_wechatTimeline addSubview:timelineLabel];
        [timelineImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.width.equalTo(@40);
            make.top.and.centerX.equalTo(self->_wechatTimeline);
        }];
        [timelineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@14);
            make.width.equalTo(@50);
            make.top.equalTo(timelineImage.mas_bottom).with.offset(6.0f);
            make.centerX.equalTo(self->_wechatTimeline);
        }];
    }
    return _wechatTimeline;
}

- (UIView *)qq {
    if (!_qq) {
        _qq = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        UIImageView *qqImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wcQQ"]];
        UILabel *qqLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        qqLabel.font = [UIFont systemFontOfSize:14];
        qqLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        qqLabel.text = @"QQ";
        qqLabel.textAlignment = NSTextAlignmentCenter;
        [_qq addSubview:qqImage];
        [_qq addSubview:qqLabel];
        [qqImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.width.equalTo(@40);
            make.top.equalTo(self->_qq);
            make.centerX.equalTo(self->_qq);
        }];
        [qqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@14);
            make.width.equalTo(@50);
            make.top.equalTo(qqImage.mas_bottom).with.offset(6.0f);
            make.centerX.equalTo(self->_qq);
        }];
    }
    
    return _qq;
}

- (UIView *)qqZone {
    if (!_qqZone) {
        _qqZone = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        UIImageView *zoneImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wcQQzone"]];
        UILabel *zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        zoneLabel.font = [UIFont systemFontOfSize:14];
        zoneLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        zoneLabel.text = @"QQ空间";
        zoneLabel.textAlignment = NSTextAlignmentCenter;
        [_qqZone addSubview:zoneImage];
        [_qqZone addSubview:zoneLabel];
        [zoneImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.width.equalTo(@40);
            make.top.equalTo(self->_qqZone);
            make.centerX.equalTo(self->_qqZone);
        }];
        [zoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@14);
            make.width.equalTo(@50);
            make.top.equalTo(zoneImage.mas_bottom).with.offset(6.0f);
            make.centerX.equalTo(self->_qqZone);
        }];
    }
    return _qqZone;
}

- (UIImageView *)styleImageView {
    if (!_styleImageView) {
        _styleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _styleImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _styleImageView;
}

- (UIView *)contentBackground {
    if (!_contentBackground) {
        _contentBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _contentBackground.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        [self.footer addSubview:_contentBackground];
        [_contentBackground mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.and.trailing.equalTo(self.footer);
            make.height.equalTo(@100);
        }];
    }
    return _contentBackground;
}

- (UIView *)cancel {
    if (!_cancel) {
        _cancel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _cancel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        UILabel *cancelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        cancelLabel.font = [UIFont systemFontOfSize:16];
        cancelLabel.textColor = [UIColor colorWithRed:252/255.0 green:145/255.0 blue:83/255.0 alpha:1];
        cancelLabel.text = @"取消";
        [_cancel addSubview:cancelLabel];
        [cancelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self->_cancel);
            make.centerX.equalTo(self->_cancel);
            make.height.equalTo(@16);
        }];
    }
    return _cancel;
}

- (UIView *)footer {
    if (!_footer) {
        _footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _footer.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    }
    return _footer;
}

- (UIView *)landscapeContent {
    if (!_landscapeContent) {
        _landscapeContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _landscapeContent.backgroundColor = [UIColor colorWithRed:29/255.0 green:29/255.0 blue:29/255.0 alpha:0.95];
    }
    return _landscapeContent;
}


#pragma mark ---------- Touch event -----------

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [touches.allObjects.lastObject locationInView:self];
    UIView *hittedView = [self hitTest:point withEvent:event];
    
    if ([hittedView isEqual:self.weibo]) {
        if ([self.delegate respondsToSelector:@selector(shareToPlatform:)]) {
            [self.delegate shareToPlatform:@"weibo"];
        }
        return;
    }
    
    if ([hittedView isEqual:self.wechat]) {
        if ([self.delegate respondsToSelector:@selector(shareToPlatform:)]) {
            [self.delegate shareToPlatform:@"wechat"];
        }
        return;
    }
    
    if ([hittedView isEqual:self.wechatTimeline]) {
        if ([self.delegate respondsToSelector:@selector(shareToPlatform:)]) {
            [self.delegate shareToPlatform:@"wechatTimeline"];
        }
        return;
    }
    
    if ([hittedView isEqual:self.qq]) {
        if ([self.delegate respondsToSelector:@selector(shareToPlatform:)]) {
            [self.delegate shareToPlatform:@"qq"];
        }
        return;
    }
    
    if ([hittedView isEqual:self.qqZone]) {
        if ([self.delegate respondsToSelector:@selector(shareToPlatform:)]) {
            [self.delegate shareToPlatform:@"qqZone"];
        }
        return;
    }
    
    [self removeFromSuperview];
}

@end
