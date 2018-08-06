//
//  MGTVideoVolumeEditor.m
//  Lab
//
//  Created by hao on 2018/8/5.
//

#import "MGTVideoVolumeEditor.h"
#import "MGTVideoEditorPanelOperationBar.h"
#import <MGTCategories/UIColor+MGTAddition.h>
#import <Masonry/Masonry.h>

@interface MGTVideoVolumeEditor ()

@end

@implementation MGTVideoVolumeEditor

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,176.0f)];
    self.view.backgroundColor = [UIColor mgt_colorWithHex:0x000000 opacity:0.03];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor mgt_colorWithHex:0x000000];
    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 176.0f);
    [self setupLayout];
}

- (void)onMusicSliderValueChange:(UISlider *)sender {
    
}

- (void)onVolumeSliderValueChange:(UISlider *)sender {
    
}

- (void)setupLayout {
    UILabel *musicLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    musicLabel.text = @"音乐";
    musicLabel.textColor = [UIColor whiteColor];
    musicLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:musicLabel];
    
    UISlider *musicSlider = [[UISlider alloc] initWithFrame:CGRectZero];
    [musicSlider setValue:0.5];
    [musicSlider setMinimumTrackTintColor:[UIColor mgt_colorWithHex:0xFE3579]];
    [musicSlider setMaximumTrackTintColor:[UIColor mgt_colorWithHex:0xF2F2F2]];
    [musicSlider setThumbImage:[UIImage imageNamed:@"sliderThumbColor"] forState:UIControlStateNormal];
    [musicSlider addTarget:self action:@selector(onMusicSliderValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:musicSlider];
    
    UILabel *volumeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    volumeLabel.text = @"音量";
    volumeLabel.textColor = [UIColor whiteColor];
    volumeLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:volumeLabel];
    
    UISlider *volumeSlider = [[UISlider alloc] initWithFrame:CGRectZero];
    [volumeSlider setValue:0.5];
    [volumeSlider setMinimumTrackTintColor:[UIColor mgt_colorWithHex:0xFE3579]];
    [volumeSlider setMaximumTrackTintColor:[UIColor mgt_colorWithHex:0xF2F2F2]];
    [volumeSlider setThumbImage:[UIImage imageNamed:@"sliderThumbColor"] forState:UIControlStateNormal];
    [volumeSlider addTarget:self action:@selector(onVolumeSliderValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:volumeSlider];
    
    MGTVideoEditorPanelOperationBar *operationBar = [MGTVideoEditorPanelOperationBar barWithTitle:@"音量"];
    [self.view addSubview:operationBar];
    
    [musicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.leading.equalTo(self.view).with.offset(28);
    }];
    
    [musicSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(musicLabel);
        make.leading.equalTo(musicLabel.mas_trailing).with.offset(15);
        make.trailing.equalTo(self.view).with.offset(-28);
        make.height.equalTo(@25);
    }];
    
    [volumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(musicLabel);
        make.top.equalTo(musicLabel.mas_bottom).with.offset(25);
    }];
    
    [volumeSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(musicSlider);
        make.centerY.equalTo(volumeLabel);
        make.height.equalTo(@25);
    }];
    
    [operationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(94);
        make.height.equalTo(@82);
    }];
    
}

@end
