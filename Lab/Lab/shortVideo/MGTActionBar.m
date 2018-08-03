//
//  MGTActionBar.m
//  Lab
//
//  Created by zhaohao on 2018/8/2.
//

#import "MGTActionBar.h"
#import "MGTActionItem.h"

@interface MGTActionBar()

@property (strong, nonatomic) NSMutableArray<MGTActionItem *> *items;

@property (assign, nonatomic) MGTActionBarStyle barStyle;

@property (assign, nonatomic) CGFloat padding;

@end

@implementation MGTActionBar

+ (instancetype)actionBarWithStyle:(MGTActionBarStyle)barStyle {
    return [[MGTActionBar alloc] initWithItems:nil style:barStyle];
}

+ (instancetype)actionBarWithItems:(NSArray<MGTActionItem *> *)itemArray style:(MGTActionBarStyle)barStyle {
    return [[MGTActionBar alloc] initWithItems:itemArray style:barStyle];
}

- (instancetype)initWithItems:(NSArray<MGTActionItem *> *)itemArray style:(MGTActionBarStyle)barStyle {
    self = [super init];
    if (self) {
        _items = [NSMutableArray arrayWithArray:itemArray];
        _barStyle = barStyle;
        _padding = 20.0f;
        for (MGTActionItem *item in _items) {
            [self addSubview:item];
        }
    }
    return self;
}

- (void)addActionItem:(MGTActionItem *)item {
    if (item) {
        [self.items addObject:item];
        [self addSubview:item];
    }
    [self setupLayout];
}

- (void)removeActionItem:(MGTActionItem *)item {
    if (item) {
        [self.items removeObject:item];
        [item removeFromSuperview];
    }
    [self setupLayout];
}

- (void)setupLayout {
    if (self.barStyle == MGTActionBarStylePortrait) {
        [self layoutSubviewsForPortraitStyle];
    } else {
        [self layoutSubviewsForLandscapeStyle];
    }
}

- (void)layoutSubviewsForLandscapeStyle {
    CGFloat kItemWidth = 44.0f;
    CGFloat kItemHeight = 44.0f;
    CGPoint oringin = CGPointMake(0, 0);
    for (MGTActionItem *item in self.items) {
        CGRect frame = CGRectMake(oringin.x, oringin.y, kItemWidth, kItemHeight);
        item.frame = frame;
        [item setupLayout];
        oringin.x = oringin.x + kItemWidth + self.padding;
    }
    CGFloat newWidth = oringin.x - self.padding;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newWidth, self.frame.size.height);
}

- (void)layoutSubviewsForPortraitStyle {
    CGFloat kItemWidth = 37.0f;
    CGFloat kItemHeight = 57.0f;
    CGPoint origin = CGPointMake(0, 0);
    for (MGTActionItem *item in self.items) {
        CGRect frame = CGRectMake(origin.x, origin.y, kItemWidth, kItemHeight);
        item.frame = frame;
        [item setupLayout];
        origin.y = origin.y + kItemHeight + self.padding;
    }
    CGFloat newHeight = origin.y - self.padding;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newHeight);
}

@end
