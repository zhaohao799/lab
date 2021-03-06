//
//  MGTVideoEffectEditor.m
//  Lab
//
//  Created by hao on 2018/8/5.
//

#import "MGTVideoEffectEditor.h"
#import "MGTVideoEditorPanelOperationBar.h"
#import <MGTCategories/UIColor+MGTAddition.h>
#import <Masonry/Masonry.h>
#import "MGTVideoTimelineEffectTrack.h"
#import "UIResponder+LabAddition.h"
#import <SDWebImage/UIImage+GIF.h>

@interface MGTVideoEffectEditor ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) MGTVideoTimelineEffectTrack *timelineTrack;

@property (strong, nonatomic) UICollectionView *filterBar;

@property (copy, nonatomic) NSArray *buttonArray;

@end

@implementation MGTVideoEffectEditor

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,222.0f)];
    self.view.backgroundColor = [UIColor mgt_colorWithHex:0x000000 opacity:0.03];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLayout];
}

- (void)onNoneButtonTap:(UIButton *)sender {
    [self switchButtonSelected:sender];
    [self.timelineTrack hideTrackItem];
}

- (void)onSlowButtonTap:(UIButton *)sender {
    [self switchButtonSelected:sender];
    [self.timelineTrack setupTrackItem];
}

- (void)onReverseButtonTap:(UIButton *)sender {
    [self switchButtonSelected:sender];
    [self.timelineTrack setupTrackItem];
}

- (void)onRepeatButtonTap:(UIButton *)sender {
    [self switchButtonSelected:sender];
    [self.timelineTrack setupTrackItem];
}

- (void)switchButtonSelected:(UIButton *)sender {
    for (UIButton *button in self.buttonArray) {
        if ([sender isEqual:button]) {
            button.imageView.layer.borderColor = [UIColor mgt_colorWithHex:0xFE3579].CGColor;
            button.imageView.layer.borderWidth = 1.5f;
        } else {
            button.imageView.layer.borderWidth = 0.0f;
        }
    }
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:kEffectTrackItemPanEvent]) {
        CGFloat value = [userInfo[kEffectTrackItemPositionUserInfoKey] floatValue];
        NSLog(@"%f", value);
    }
    [self.nextResponder routerEventWithName:eventName userInfo:userInfo];
}

- (void)setupLayout {
    self.timelineTrack = [[MGTVideoTimelineEffectTrack alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.timelineTrack];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(56, 66);
    layout.minimumLineSpacing = 40;
    layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    self.filterBar = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) collectionViewLayout:layout];
//    [self.filterBar registerClass:[MGTBeautyFilterCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.filterBar.delegate = self;
    self.filterBar.dataSource = self;
    [self.view addSubview:self.filterBar];
    
    UIImage *noneImage = [self createGifImageWithFileName:@"sv_effect_none"];
    UIButton *noneButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [noneButton setImage:noneImage forState:UIControlStateNormal];
    [noneButton setTitle:@"无" forState:UIControlStateNormal];
    noneButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [noneButton setTitleColor:[UIColor mgt_colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
    noneButton.imageView.layer.borderColor = [UIColor mgt_colorWithHex:0xFE3579].CGColor;
    noneButton.imageView.layer.borderWidth = 1.5f;
    noneButton.imageView.layer.cornerRadius = 25.0f;
    noneButton.imageView.layer.masksToBounds = YES;
    [noneButton.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.leading.and.trailing.equalTo(noneButton);
        make.height.equalTo(@50);
    }];
    noneButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    noneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [noneButton setTitleEdgeInsets:UIEdgeInsetsMake(50, -50, 0, 0)];
    [noneButton setImageEdgeInsets:UIEdgeInsetsMake(-17, 0, 0, -50)];
    [noneButton addTarget:self action:@selector(onNoneButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noneButton];
    
    UIImage *slowImage = [self createGifImageWithFileName:@"sv_effect_slow"];
    UIButton *slowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [slowButton setImage:slowImage forState:UIControlStateNormal];
    [slowButton setTitle:@"慢动作" forState:UIControlStateNormal];
    slowButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [slowButton setTitleColor:[UIColor mgt_colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
    slowButton.imageView.layer.cornerRadius = 25.0f;
    slowButton.imageView.layer.masksToBounds = YES;
    [slowButton.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.leading.and.trailing.equalTo(slowButton);
        make.height.equalTo(@50);
    }];
    [slowButton setTitleEdgeInsets:UIEdgeInsetsMake(50, -37, 0, 0)];
    slowButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [slowButton addTarget:self action:@selector(onSlowButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:slowButton];
    
    UIImage *reverseImage = [self createGifImageWithFileName:@"sv_effect_reverse"];
    UIButton *reverseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [reverseButton setImage:reverseImage forState:UIControlStateNormal];
    [reverseButton setTitle:@"倒放" forState:UIControlStateNormal];
    reverseButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [reverseButton setTitleColor:[UIColor mgt_colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
    reverseButton.imageView.layer.cornerRadius = 25.0f;
    reverseButton.imageView.layer.masksToBounds = YES;
    [reverseButton.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.leading.and.trailing.equalTo(reverseButton);
        make.height.equalTo(@50);
    }];
    [reverseButton setTitleEdgeInsets:UIEdgeInsetsMake(50, -37, 0, 0)];
    [reverseButton addTarget:self action:@selector(onReverseButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reverseButton];
    
    UIImage *repeatImage = [self createGifImageWithFileName:@"sv_effect_repeat"];
    UIButton *repeatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [repeatButton setImage:repeatImage forState:UIControlStateNormal];
    [repeatButton setTitle:@"反复" forState:UIControlStateNormal];
    repeatButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [repeatButton setTitleColor:[UIColor mgt_colorWithHex:0xFFFFFF] forState:UIControlStateNormal];
    repeatButton.imageView.layer.cornerRadius = 25.0f;
    repeatButton.imageView.layer.masksToBounds = YES;
    [repeatButton.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.leading.and.trailing.equalTo(repeatButton);
        make.height.equalTo(@50);
    }];
    [repeatButton setTitleEdgeInsets:UIEdgeInsetsMake(50, -37, 0, 0)];
    [repeatButton addTarget:self action:@selector(onRepeatButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:repeatButton];
    
    self.buttonArray = @[noneButton, slowButton, reverseButton, repeatButton];
    
    MGTVideoEditorPanelOperationBar *operationBar = [MGTVideoEditorPanelOperationBar barWithTitle:@"特效"];
    [self.view addSubview:operationBar];
    
    [self.timelineTrack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(8);
        make.leading.equalTo(self.view).with.offset(15);
        make.trailing.equalTo(self.view).with.offset(-15);
        make.height.equalTo(@55);
    }];
    
    CGFloat screenWidth = self.view.bounds.size.width;
    CGFloat buttonPadding = screenWidth/4;
    [noneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timelineTrack.mas_bottom).with.offset(11);
        make.centerX.equalTo(self.view.mas_leading).with.offset(screenWidth/8);
        make.width.equalTo(@50);
        make.height.equalTo(@66);
    }];
    [slowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noneButton);
        make.centerX.equalTo(noneButton).with.offset(buttonPadding);
        make.width.equalTo(@50);
        make.height.equalTo(@66);
    }];
    [reverseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noneButton);
        make.centerX.equalTo(slowButton).with.offset(buttonPadding);
        make.width.equalTo(@50);
        make.height.equalTo(@66);
    }];
    [repeatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noneButton);
        make.centerX.equalTo(reverseButton).with.offset(buttonPadding);
        make.width.equalTo(@50);
        make.height.equalTo(@66);
    }];
    [operationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(140);
        make.height.equalTo(@82);
    }];
}

- (UIImage *)createGifImageWithFileName:(NSString *)name {
    NSString *file = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:file];
    UIImage *image = [UIImage sd_animatedGIFWithData:data];
    
    return image;
}

@end
