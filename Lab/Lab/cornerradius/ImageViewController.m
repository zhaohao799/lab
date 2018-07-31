//
//  ImageViewController.m
//  Lab
//
//  Created by zhaohao on 2018/7/31.
//

#import "ImageViewController.h"
#import <MGTCategories/UIView+MGTAddition.h>
#import "UIImageView+LabAddition.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demo"]];
    imageView.frame = CGRectMake(10.0f, 30.0f, self.view.width - 20, self.view.height - 90);
    imageView.mgtCornerRadius = 10.0f;
    
    [self.view addSubview:imageView];
}



@end
