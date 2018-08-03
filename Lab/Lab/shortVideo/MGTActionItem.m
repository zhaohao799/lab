//
//  MGTActionItem.m
//  Lab
//
//  Created by zhaohao on 2018/8/2.
//

#import "MGTActionItem.h"
#import <MGTCategories/UIView+MGTAddition.h>
#import "UIResponder+LabAddition.h"

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
    return [[MGTActionItem alloc] initWithImage:image title:title event:eventName];
}

+ (instancetype)itemWithImage:(UIImage *)image event:(NSString *)eventName {
    return [[MGTActionItem alloc] initWithImage:image event:eventName];
}

+ (instancetype)itemWithTitle:(NSString *)title event:(NSString *)eventName {
    return [[MGTActionItem alloc] initWithTitle:title event:eventName];
}

+ (instancetype)itemWithCustomView:(UIView *)customView event:(nullable NSString *)eventName {
    return [[MGTActionItem alloc] initWithCustomView:customView event:eventName];
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

- (instancetype)initWithCustomView:(UIView *)customView event:(NSString *)eventName{
    self = [super initWithFrame:CGRectMake(0, 0, customView.bounds.size.width, customView.bounds.size.height)];
    if (self) {
        _customView = customView;
        _eventName = eventName;
        _itemStyle = MGTActionItemStyleCustom;
        [self addSubview:_customView];
    }
    return self;
}

- (void)setupLayout {
    NSInvocation *invocation = self.layoutStrategy[@(self.itemStyle)];
    [invocation invokeWithTarget:self];
}

- (void)layoutImageTitleItem {
    CGRect imageFrame = CGRectMake(0, 0, self.width, self.width);
    self.imageView.frame = imageFrame;
    [self.imageView setImage:self.image];
    CGRect lableFrame = CGRectMake(0, self.imageView.height, self.width, self.height - self.imageView.height);
    self.titleLabel.frame = lableFrame;
    self.titleLabel.text = self.title;
}

- (void)layoutImageItem {
    self.imageView.frame = self.bounds;
    [self.imageView setImage:self.image];
}

- (void)layoutTitleItem {
    self.titleLabel.frame = self.bounds;
    self.titleLabel.text = self.title;
}

- (void)layoutCustomItem {
    self.customView.frame = self.bounds;
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
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self.class instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    return invocation;
}


#pragma mark Interaction

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self routerEventWithName:self.eventName userInfo:nil];
}

#pragma mark - setters getters
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
