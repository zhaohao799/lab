//
//  ShareViewController.m
//  Lab
//
//  Created by zhaohao on 2018/5/25.
//

#import "ShareViewController.h"
#import "WCShareView.h"

@interface ShareViewController ()<UINavigationControllerDelegate, UITabBarControllerDelegate>

@property (nonatomic, strong) WCShareView *shareView;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.tabBarController.delegate = self;
    
    self.shareView = [[WCShareView alloc] init];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *normalPortrait = [UIButton buttonWithType:UIButtonTypeCustom];
    normalPortrait.tag = 1;
    normalPortrait.frame = CGRectMake(100, 100, 200, 30);
    [normalPortrait setTitle:@"normal portrait" forState:UIControlStateNormal];
    [normalPortrait setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    [normalPortrait addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:normalPortrait];
    
    UIButton *normalLandscape = [UIButton buttonWithType:UIButtonTypeCustom];
    normalLandscape.tag = 2;
    normalLandscape.frame = CGRectMake(100, 150, 200, 30);
    [normalLandscape setTitle:@"normal landscape" forState:UIControlStateNormal];
    [normalLandscape setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    [normalLandscape addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:normalLandscape];
    
    UIButton *stylePortrait = [UIButton buttonWithType:UIButtonTypeCustom];
    stylePortrait.tag = 3;
    stylePortrait.frame = CGRectMake(100, 200, 200, 30);
    [stylePortrait setTitle:@"style portrait" forState:UIControlStateNormal];
    [stylePortrait setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    [stylePortrait addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stylePortrait];
    
    UIButton *styleLandscape = [UIButton buttonWithType:UIButtonTypeCustom];
    styleLandscape.tag = 4;
    styleLandscape.frame = CGRectMake(100, 250, 200, 30);
    [styleLandscape setTitle:@"style landscape" forState:UIControlStateNormal];
    [styleLandscape setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    [styleLandscape addTarget:self action:@selector(onButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:styleLandscape];
}

- (void)onButtonTap:(UIButton *)sender {
    NSString *imageUrl = @"http://f.hiphotos.baidu.com/image/pic/item/8b82b9014a90f603f6a2dfee3312b31bb051ed0d.jpg";
    switch (sender.tag) {
        case 1:
//            [self.shareView showWithStyle:nil orientation:@"portrait"];
            [self.shareView showWithStyle:nil];
            break;
        case 2:
            [self.shareView showWithStyle:nil orientation:@"landscape"];
            break;
        case 3:
            [self.shareView showWithStyle:imageUrl orientation:@"portrait"];
            break;
        case 4:
            [self.shareView showWithStyle:imageUrl orientation:@"landscape"];
            break;
        default:
            break;
    }
}

- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientationMask)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
