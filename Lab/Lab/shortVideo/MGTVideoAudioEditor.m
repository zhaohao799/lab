//
//  MGTVideoAudioEditor.m
//  Lab
//
//  Created by hao on 2018/8/5.
//

#import "MGTVideoAudioEditor.h"
#import "MGTVideoEditorPanelOperationBar.h"
#import <MGTCategories/UIColor+MGTAddition.h>
#import <Masonry/Masonry.h>
#import "MGTVideoTimelineAudioTrack.h"

@interface MGTVideoAudioEditor ()

@property (strong, nonatomic) MGTVideoTimelineAudioTrack *timelineTrack;

@property (strong, nonatomic) UIButton *undoButton;

@property (weak, nonatomic) NSTimer *timer;

@end

@implementation MGTVideoAudioEditor

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,176.0f)];
    self.view.backgroundColor = [UIColor mgt_colorWithHex:0x000000 opacity:0.03];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLayout];
}

- (void)onUndoButtonTap:(UIButton *)sender {
    [self.timelineTrack removeLastDubbingItem];
}

- (void)onRecordButtonPress:(UIButton *)sender {
    self.undoButton.hidden = NO;
    int32_t x = arc4random() % 30;
    [self.timelineTrack addDubbingItemAtPositiongX:x/30.0f];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(updateTimelineDubbingItem) userInfo:nil repeats:YES];
}

- (void)onRecordButtonTouchUp:(UIButton *)sender {
    [self.timer invalidate];
}


#pragma mark - Timeline Item Logic

- (void)updateTimelineDubbingItem {
    [self.timelineTrack updateLastDubbingItemWithSpan:1/30.0f];
}

- (void)setupLayout {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"选择位置后按住录音可替换原声";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:titleLabel];
    
    self.undoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.undoButton setImage:[UIImage imageNamed:@"undo"] forState:UIControlStateNormal];
    [self.undoButton setTitle:@"撤销" forState:UIControlStateNormal];
    [self.undoButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.undoButton setTitleColor:[UIColor mgt_colorWithHex:0xFE3579] forState:UIControlStateNormal];
    [self.undoButton addTarget:self action:@selector(onUndoButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    self.undoButton.hidden = YES;
    [self.view addSubview:self.undoButton];
    
    self.timelineTrack = [[MGTVideoTimelineAudioTrack alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.timelineTrack];
    
    UIButton *recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [recordButton setImage:[UIImage imageNamed:@"recordAudio"] forState:UIControlStateNormal];
    [recordButton addTarget:self action:@selector(onRecordButtonPress:) forControlEvents:UIControlEventTouchDown];
    [recordButton addTarget:self action:@selector(onRecordButtonTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    
    MGTVideoEditorPanelOperationBar *operationBar = [MGTVideoEditorPanelOperationBar barWithCustomView:recordButton];
    [self.view addSubview:operationBar];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(15);
        make.leading.equalTo(self.view).with.offset(15);
    }];
    
    [self.undoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel);
        make.trailing.equalTo(self.view).with.offset(-15);
        make.width.equalTo(@44);
        make.height.equalTo(@14);
    }];
    
    [self.timelineTrack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).with.offset(15);
        make.trailing.equalTo(self.view).with.offset(-15);
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.height.equalTo(@54);
    }];
    
    [operationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(94);
        make.height.equalTo(@82);
    }];
}

@end
