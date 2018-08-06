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

@interface MGTVideoAudioEditor ()

@property (strong, nonatomic) UIButton *undoButton;

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
    [self.undoButton setTintColor:[UIColor mgt_colorWithHex:0xFE3579 opacity:1.0f]];
    [self.undoButton addTarget:self action:@selector(onUndoButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    self.undoButton.hidden = YES;
    [self.view addSubview:self.undoButton];
    
    UIView *timelineTrack = [[UIView alloc] initWithFrame:CGRectZero];
    timelineTrack.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:timelineTrack];
    
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
        make.trailing.equalTo(self.view).with.offset(15);
        make.width.equalTo(@44);
        make.height.equalTo(@14);
    }];
    
    [timelineTrack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).with.offset(15);
        make.trailing.equalTo(self.view).with.offset(-15);
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.height.equalTo(@55);
    }];
    
    [operationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(94);
        make.height.equalTo(@82);
    }];
}

- (void)onUndoButtonTap:(UIButton *)sender {
    
}

- (void)onRecordButtonPress:(UIButton *)sender {
    
}

- (void)onRecordButtonTouchUp:(UIButton *)sender {
    
}

@end
