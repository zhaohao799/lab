//
//  MGTActionItem.m
//  Lab
//
//  Created by zhaohao on 2018/8/2.
//

#import "MGTActionItem.h"

typedef NS_ENUM(NSInteger, MGTActionItemStyle){
    MGTActionItemStyleImageTitle,
    MGTActionItemStyleImage,
    MGTActionItemStyleTitle,
    MGTActionItemStyleCustom
};

@interface MGTActionItem()

@property (strong, nonatomic, readwrite) UIImage *image;

@property (copy, nonatomic, readwrite) NSString *title;

@property (strong, nonatomic, readwrite) UIView *customView;

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (assign, nonatomic) MGTActionItemStyle itemStyle;

@property (copy, nonatomic) NSDictionary *layoutStrategy;

@property (copy, nonatomic) NSString *eventName;

@end

@implementation MGTActionItem

+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title event:(NSString *)eventName {
    
    return nil;
}

+ (instancetype)itemWithImage:(UIImage *)image event:(NSString *)eventName {
    return nil;
}

+ (instancetype)itemWithTitle:(NSString *)title event:(NSString *)eventName {
    return nil;
}

+ (instancetype)itemWithCustomView:(UIView *)customView {
    return nil;
}

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title event:(NSString *)eventName {
    self = [super initWithFrame:CGRectMake(0, 0, 37.0f, 57.0f)];
    if (self) {
        _image = image;
        _title = title;
        _eventName = eventName;
        _itemStyle = MGTActionItemStyleImageTitle;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image event:(NSString *)eventName {
    self = [super initWithFrame:CGRectMake(0, 0, 37.0f, 37.0f)];
    if (self) {
        _image = image;
        _eventName = eventName;
        _itemStyle = MGTActionItemStyleImage;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title event:(NSString *)eventName {
    self = [super initWithFrame:CGRectMake(0, 0, 37.0f, 20.0f)];
    if (self) {
        _title = title;
        _eventName = eventName;
        _itemStyle = MGTActionItemStyleTitle;
    }
    return self;
}

- (instancetype)initWithCustomView:(UIView *)customView {
    self = [super initWithFrame:CGRectMake(0, 0, customView.bounds.size.width, customView.bounds.size.height)];
    if (self) {
        _customView = customView;
        _itemStyle = MGTActionItemStyleCustom;
    }
    return self;
}

- (void)layoutSubviews {
    NSInvocation *invocation = self.layoutStrategy[@(self.itemStyle)];
    [invocation invokeWithTarget:self];
}

- (void)layoutImageTitleItem {
    
}

- (void)layoutImageItem {
    
}

- (void)layoutTitleItem {
    
}

- (void)layoutCustomItem {
    
}

- (NSDictionary <NSNumber*, NSInvocation*> *)layoutStrategy {
    if (!_layoutStrategy) {
        _layoutStrategy = @{@(MGTActionItemStyleImageTitle) : [self createInvocationWithSelector:@selector(layoutImageTitleItem)],
                            @(MGTActionItemStyleImage) : [self createInvocationWithSelector:@selector(layoutImageItem)],
                            @(MGTActionItemStyleTitle) : [self createInvocationWithSelector:@selector(layoutTitleItem)],
                            @(MGTActionItemStyleCustom) : [self createInvocationWithSelector:@selector(layoutCustomItem)]
                            };
    }
    return _layoutStrategy;
}

- (NSInvocation *)createInvocationWithSelector:(SEL)selector {
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature methodSignatureForSelector:selector]];
    return invocation;
}

@end
