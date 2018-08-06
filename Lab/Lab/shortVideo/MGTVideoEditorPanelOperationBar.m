//
//  MGTVideoEditorPanelOperationBar.m
//  Lab
//
//  Created by hao on 2018/8/5.
//

#import "MGTVideoEditorPanelOperationBar.h"
#import "UIResponder+LabAddition.h"
#import <Masonry/Masonry.h>

NSString *const kEditingCancelEvent = @"kEditingCancelEvent";
NSString *const kEditingConfirmEvent = @"kEditingConfirmEvent";

@interface MGTVideoEditorPanelOperationBar()

@property (strong, nonatomic) UIButton *cancel;

@property (strong, nonatomic) UIButton *confirm;

@property (strong, nonatomic) UIView *titleView;

@end

@implementation MGTVideoEditorPanelOperationBar

+ (instancetype)barWithTitle:(NSString *)title {
    return [[MGTVideoEditorPanelOperationBar alloc] initWithTitle:title];
}

+ (instancetype)barWithCustomView:(UIView *)customView {
    return [[MGTVideoEditorPanelOperationBar alloc] initWithCustomView:customView];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancel setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        [_cancel addTarget:self action:@selector(onCancelTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancel];
        
        _confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirm setImage:[UIImage imageNamed:@"confirm"] forState:UIControlStateNormal];
        [_confirm setImage:[UIImage imageNamed:@"confirm"] forState:UIControlStateDisabled];
        [_confirm addTarget:self action:@selector(onConfirmTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confirm];
        
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        [self addSubview:_titleView];
        
        [self setupLayout];
    
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title {
    self = [self initWithFrame:CGRectMake(0, 0, 100, 90)];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = title;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:16.0f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.bottom.and.trailing.equalTo(self.titleView);
        }];
    }
    
    return self;
}

- (instancetype)initWithCustomView:(UIView *)customView {
    self = [self initWithFrame:CGRectMake(0, 0, 100, 90)];
    if (self) {
        [self.titleView addSubview:customView];
        [customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.bottom.and.trailing.equalTo(self.titleView);
        }];
    }
    return self;
}

- (void)onConfirmTap:(UIButton *)sender {
    [self routerEventWithName:kEditingCancelEvent userInfo:nil];
}

- (void)onCancelTap:(UIButton *)sender {
    [self routerEventWithName:kEditingConfirmEvent userInfo:nil];
}

- (void)setupLayout {
    [_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).with.offset(40);
        make.width.and.height.equalTo(@40);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.mas_trailing).with.offset(-40);
        make.width.and.height.equalTo(@40);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@50);
        make.height.equalTo(@50);
        make.centerX.and.centerY.equalTo(self);
    }];
}

@end
