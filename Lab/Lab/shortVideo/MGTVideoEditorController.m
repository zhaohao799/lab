//
//  MGTVideoEditorController.m
//  Lab
//
//  Created by zhaohao on 2018/8/2.
//

#import "MGTVideoEditorController.h"
#import "MGTActionBar.h"
#import "MGTActionItem.h"
#import "UIResponder+LabAddition.h"

NSString *const kMusicItemEvent = @"kMusicItemEvent";
NSString *const kAudioItemEvent = @"kAudioItemEvent";
NSString *const kVolumeItemEvent = @"kVolumeItemEvent";
NSString *const kEffectItemEvent = @"kEffectItemEvent";

@interface MGTVideoEditorController ()

@end

@implementation MGTVideoEditorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MGTActionItem *musicItem = [MGTActionItem itemWithImage:[UIImage imageNamed:@"music"] title:@"音乐" event:kMusicItemEvent];
    MGTActionItem *audioItem = [MGTActionItem itemWithImage:[UIImage imageNamed:@"audio"] title:@"配音" event:kAudioItemEvent];
    MGTActionItem *volumeItem = [MGTActionItem itemWithImage:[UIImage imageNamed:@"volume"] title:@"音量" event:kVolumeItemEvent];
    MGTActionItem *effectItem = [MGTActionItem itemWithImage:[UIImage imageNamed:@"effect"] title:@"特效" event:kEffectItemEvent];
    
    MGTActionBar *actionBar = [MGTActionBar actionBarWithItems:@[musicItem, audioItem, volumeItem, effectItem] style:MGTActionBarStylePortrait];
    actionBar.frame = CGRectMake(320, 80, 40, 40);
    [actionBar setupLayout];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"demo"]];
    [self.view addSubview:actionBar];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:kMusicItemEvent]) {
        NSLog(@"music item event");
    }
    if ([eventName isEqualToString:kAudioItemEvent]) {
        NSLog(@"audio item event");
    }
}
@end
