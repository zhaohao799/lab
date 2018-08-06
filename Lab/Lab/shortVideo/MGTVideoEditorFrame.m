//
//  MGTVideoEditorFrame.m
//  Lab
//
//  Created by zhaohao on 2018/8/3.
//

#import "MGTVideoEditorFrame.h"
#import "MGTActionBar.h"
#import "MGTActionItem.h"
#import <Masonry/Masonry.h>
#import "UIResponder+LabAddition.h"

NSString *const kMusicItemEvent = @"kMusicItemEvent";
NSString *const kAudioItemEvent = @"kAudioItemEvent";
NSString *const kVolumeItemEvent = @"kVolumeItemEvent";
NSString *const kEffectItemEvent = @"kEffectItemEvent";
NSString *const kEditorPlayingEvent = @"kEditorPlayingEvent";
NSString *const kEditorStopEvent = @"kEditorStopEvent";
NSString *const kNextButtonTap = @"kNextButtonTap";
NSString *const kBackButtonTap = @"kBackButtonTap";

@interface MGTVideoEditorFrame()

@property (assign, nonatomic) MGTVideoEditorMode mode;

@property (strong, nonatomic, readwrite) UIView *editorView;

@property (strong, nonatomic) MGTActionBar *actionBar;

@property (strong, nonatomic) UIImageView *playButton;

@property (assign, nonatomic) Boolean playing;

@property (strong, nonatomic) UIButton *nextButton;

@property (strong, nonatomic) UIButton *backButton;

@end

@implementation MGTVideoEditorFrame

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        _mode = MGTVideoEditorModeNormal;
        _playing = NO;
        _editorView = [[UIView alloc] initWithFrame:self.bounds];
        _editorView.backgroundColor = [UIColor greenColor];
        [self addSubview:_editorView];
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(onBackButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        
        _playButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play"]];
        _playButton.hidden = YES;
        [self addSubview:_playButton];
        
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setImage:[UIImage imageNamed:@"nextStep"] forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(onNextButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nextButton];
        
        MGTActionItem *musicItem = [MGTActionItem itemWithImage:[UIImage imageNamed:@"music"] title:@"音乐" event:kMusicItemEvent];
        MGTActionItem *audioItem = [MGTActionItem itemWithImage:[UIImage imageNamed:@"audio"] title:@"配音" event:kAudioItemEvent];
        MGTActionItem *volumeItem = [MGTActionItem itemWithImage:[UIImage imageNamed:@"volume"] title:@"音量" event:kVolumeItemEvent];
        MGTActionItem *effectItem = [MGTActionItem itemWithImage:[UIImage imageNamed:@"effect"] title:@"特效" event:kEffectItemEvent];
        
        self.actionBar = [MGTActionBar actionBarWithItems:@[musicItem, audioItem, volumeItem, effectItem] style:MGTActionBarStylePortrait];
        self.actionBar.frame = CGRectMake(320, 80, 40, 40);
        [self.actionBar setupLayout];
        [self addSubview:self.actionBar];
        
        [self setupInitLayout];
    }
    return self;
}

- (instancetype)initWithMode:(MGTVideoEditorMode)mode {
    self = [self initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (self) {
        _mode = mode;
    }
    return self;
}

- (void)setupInitLayout {
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(17);
        make.leading.equalTo(self).with.offset(15);
        make.width.equalTo(@64);
        make.height.equalTo(@32);
    }];
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@54);
        make.height.equalTo(@54);
    }];
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).with.offset(-15);
        make.bottom.equalTo(self).with.offset(-25);
        make.width.equalTo(@90);
        make.height.equalTo(@40);
    }];
    [_actionBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(42);
        make.trailing.equalTo(self).with.offset(-15);
        make.width.equalTo(@40);
        make.height.equalTo(@300);
    }];
    [_editorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)switchMode:(MGTVideoEditorMode)mode {
    self.mode = mode;
    if (self.mode == MGTVideoEditorModeNormal) {
        self.backButton.hidden = NO;
        self.nextButton.hidden = NO;
        self.actionBar.hidden = NO;
        [self.editorView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    if (self.mode == MGTVideoEditorModeEditing) {
        self.backButton.hidden = YES;
        self.nextButton.hidden = YES;
        self.actionBar.hidden = YES;
        [self.editorView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self);
            make.leading.equalTo(self).with.offset(50);
            make.trailing.equalTo(self).with.offset(-50);
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.allObjects.firstObject;
    CGPoint location = [touch locationInView:self];
    if (![self.backButton pointInside:location withEvent:nil] && ![self.nextButton pointInside:location withEvent:nil] && ![self.actionBar pointInside:location withEvent:nil]) {
        [self onPlayButtonTap];
    }
}

- (void)onPlayButtonTap {
    self.playing = !self.playing;
    if (self.playing) {
        self.playButton.hidden = YES;
        [self routerEventWithName:kEditorPlayingEvent userInfo:nil];
    } else {
        self.playButton.hidden = NO;
        [self routerEventWithName:kEditorStopEvent userInfo:nil];
    }
}

- (void)onNextButtonTap:(UIButton *)sender {
    [self routerEventWithName:kNextButtonTap userInfo:nil];
}

- (void)onBackButtonTap:(UIButton *)sender {
    [self routerEventWithName:kBackButtonTap userInfo:nil];
}

@end
