//
//  MGTVideoEditorController.m
//  Lab
//
//  Created by zhaohao on 2018/8/2.
//

#import "MGTVideoEditorController.h"
#import "UIResponder+LabAddition.h"
#import "MGTVideoEditorFrame.h"
#import "MGTVideoAudioEditor.h"
#import "MGTVideoVolumeEditor.h"
#import "MGTVideoEffectEditor.h"
#import <Masonry/Masonry.h>

@interface MGTVideoEditorController ()

@property (strong, nonatomic) MGTVideoEditorFrame *editorFrame;

@property (strong, nonatomic) UIView *editorOperationPanel;

@property (strong, nonatomic) MGTVideoAudioEditor *audioEditor;

@property (strong, nonatomic) MGTVideoVolumeEditor *volumeEditor;

@property (strong, nonatomic) MGTVideoEffectEditor *effectEditor;

@property (strong, nonatomic) NSDictionary *eventStrategy;

@end

@implementation MGTVideoEditorController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = NO;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.editorFrame = [[MGTVideoEditorFrame alloc] initWithMode:MGTVideoEditorModeNormal];
    [self.view addSubview:self.editorFrame];
    self.editorOperationPanel = [[UIView alloc] initWithFrame:CGRectZero];
    self.editorOperationPanel.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.editorOperationPanel];
    [self.editorOperationPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.and.trailing.equalTo(self.view);
        make.height.equalTo(@0);
    }];
    [self.editorFrame mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.trailing.equalTo(self.view);
        make.bottom.equalTo(self.editorOperationPanel.mas_top);
    }];
    
    self.audioEditor = [[MGTVideoAudioEditor alloc] initWithNibName:nil bundle:nil];
    [self.editorOperationPanel addSubview:self.audioEditor.view];
    
    self.volumeEditor = [[MGTVideoVolumeEditor alloc]  initWithNibName:nil bundle:nil];
    [self.editorOperationPanel addSubview:self.volumeEditor.view];
    
    self.effectEditor = [[MGTVideoEffectEditor alloc] initWithNibName:nil bundle:nil];
    [self.editorOperationPanel addSubview:self.effectEditor.view];
    
    [self hideEditorView];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    NSInvocation *invocation = self.eventStrategy[eventName];
    [invocation invokeWithTarget:self];
}

- (void)onMusicItemTap {
    
}

- (void)onAudioItemTap {
    [self startEditingWithPanelSize:CGSizeMake(self.view.bounds.size.width, 176.0f)];
    [self hideEditorView];
    self.audioEditor.view.hidden = NO;
    
}

- (void)onVolumeItemTap {
    [self startEditingWithPanelSize:CGSizeMake(self.view.bounds.size.width, 176.0f)];
    [self hideEditorView];
    self.volumeEditor.view.hidden = NO;
}

- (void)onEffectItemTap {
    [self startEditingWithPanelSize:CGSizeMake(self.view.bounds.size.width, 222.0f)];
    [self hideEditorView];
    self.effectEditor.view.hidden = NO;
}

- (void)onNextButtonTap {
    
}

- (void)onBackButtonTap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onEditingCancelEvent {
    [self stopEditing];
}

- (void)onEditingConfirmEvent {
    [self stopEditing];
}

- (void)startEditingWithPanelSize:(CGSize)panelSize {
    [self.editorFrame switchMode:MGTVideoEditorModeEditing];
    [UIView animateWithDuration:0.4 animations:^{
        [self.editorOperationPanel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.bottom.and.trailing.equalTo(self.view);
            make.height.equalTo(@(panelSize.height));
        }];
        [self.view layoutIfNeeded];
    }];
}

- (void)stopEditing {
    [self.editorFrame switchMode:MGTVideoEditorModeNormal];
    [UIView animateWithDuration:0.4 animations:^{
        [self.editorOperationPanel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.and.trailing.equalTo(self.view);
            make.top.equalTo(self.view.mas_bottom);
            make.height.equalTo(@0);
        }];
        [self.view layoutIfNeeded];
    }];
}

- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{kMusicItemEvent: [self createInvocationWithSelector:@selector(onMusicItemTap)],
                           kAudioItemEvent: [self createInvocationWithSelector:@selector(onAudioItemTap)],
                           kVolumeItemEvent: [self createInvocationWithSelector:@selector(onVolumeItemTap)],
                           kEffectItemEvent: [self createInvocationWithSelector:@selector(onEffectItemTap)],
                           kNextButtonTap: [self createInvocationWithSelector:@selector(onNextButtonTap)],
                           kBackButtonTap: [self createInvocationWithSelector:@selector(onBackButtonTap)],
                           kEditingCancelEvent: [self createInvocationWithSelector:@selector(onEditingCancelEvent)],
                           kEditingConfirmEvent: [self createInvocationWithSelector:@selector(onEditingConfirmEvent)]
                           };
    }
    return _eventStrategy;
}

- (NSInvocation *)createInvocationWithSelector:(SEL)selector {
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self.class instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    return invocation;
}

- (void)hideEditorView {
    self.audioEditor.view.hidden = YES;
    self.volumeEditor.view.hidden = YES;
    self.effectEditor.view.hidden = YES;
}

@end
