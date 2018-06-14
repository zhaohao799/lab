//
//  InvocationViewController.m
//  Lab
//
//  Created by zhaohao on 2018/6/4.
//

#import "InvocationViewController.h"
#import <Masonry/Masonry.h>

@interface InvocationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray<NSString *> *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation InvocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"no return, no argu", @"return int, no argu", @"return vc, no argu", @"return vc, color argu"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -------  UITableViewDatasource ----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}
#pragma mark -------  UITableViewDelegate ----------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        Class cls = NSClassFromString(@"InvocationTarget");
        SEL sel = NSSelectorFromString(@"noArgumentReturnMethod");
        NSMethodSignature *signature = [cls instanceMethodSignatureForSelector:sel];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setSelector:sel];
        [invocation invokeWithTarget:[[cls alloc] init]];
    }
    
    if (indexPath.row == 1) {
        Class cls = NSClassFromString(@"InvocationTarget");
        SEL sel = NSSelectorFromString(@"returnIntNoArgumentMethod");
        NSMethodSignature *signature = [cls instanceMethodSignatureForSelector:sel];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        {
        __autoreleasing id instance = [[cls alloc] init];
        [invocation setTarget:instance];
        [invocation setSelector:sel];
        }
        [invocation invoke];
        NSInteger result;
        [invocation getReturnValue:&result];
        NSLog(@"\n + finished: %@, returned value: %ld", NSStringFromSelector(sel), result);
    }
    
    if (indexPath.row == 2) {
        Class cls = NSClassFromString(@"InvocationTarget");
        SEL sel = NSSelectorFromString(@"returnControllerNoArgumentMethod");
        NSMethodSignature *signature = [cls instanceMethodSignatureForSelector:sel];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        id instance = [[cls alloc] init];
        [invocation setTarget:instance];
        [invocation setSelector:sel];
        [invocation invoke];
        __autoreleasing UIViewController *vc;
        [invocation getReturnValue:&vc];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"\n + finished: %@, vc color: cyan", NSStringFromSelector(sel));
        NSLog(@"%@", vc);
    }
    
    if (indexPath.row == 3) {
        Class cls = NSClassFromString(@"InvocationTarget");
        SEL sel = NSSelectorFromString(@"returnControllerColorArgumentMethod:colorName:");
        NSMethodSignature *signature = [cls instanceMethodSignatureForSelector:sel];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        id instance = [[cls alloc] init];
        [invocation setTarget:instance];
        [invocation setSelector:sel];
        UIColor *color = [UIColor magentaColor];
        [invocation setArgument:&color atIndex:2];
        NSString *colorName = @"magenta color";
        [invocation setArgument:&colorName atIndex:3];
        [invocation invoke];
        __autoreleasing UIViewController *vc;
        [invocation getReturnValue:&vc];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"\n + finished: %@, vc color: %@", NSStringFromSelector(sel), colorName);
    }
}

@end
