//
//  EntryViewController.m
//  Lab
//
//  Created by zhaohao on 2018/5/25.
//

#import "EntryViewController.h"
#import <Masonry/Masonry.h>

#import "ShareViewController.h"
#import "InvocationViewController.h"
#import "UIAlertController+LabAddition.h"
#import "UIResponder+LabAddition.h"
#import "MGTVideoEditorController.h"

#ifdef DEBUG
#define ENTRY_TITLE @"Entry"
#elif TEST
#define ENTRY_TITLE @"Title"
#else
#define ENTRY_TITLE @"Entry Title"
#endif

@interface EntryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray<NSString *> *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = ENTRY_TITLE;
    self.dataArray = @[@"share test", @"invocation", @"Alert", @"fast alert", @"event alert", @"short video"];
    
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
        ShareViewController *vc = [[ShareViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 1) {
        InvocationViewController *vc = [[InvocationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 2) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"The Alert Action Sheet Title" message:@"The Alert Action Sheet Message" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"First Action Title" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"The Alert Title" message:@"The Alert Message" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"first" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"first");
            }];
            [alert addAction:firstAction];
            
            UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"second" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"destructive");
            }];
            [alert addAction:secondAction];
            
            UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"third" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"cancel");
            }];
            [alert addAction:thirdAction];
            
            [self presentViewController:alert animated:YES completion:nil];
        }];
        [alert addAction:firstAction];
        
        UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Second Action Title" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"second action handler");
        }];
        [alert addAction:secondAction];
        
        UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"cancel action title" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancel action handler");
            
        }];
        [alert addAction:thirdAction];
        
        UIAlertAction *forthAction = [UIAlertAction actionWithTitle:@"destructive action title" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"destructive action handler");
        }];
        [forthAction setValue:[UIColor yellowColor] forKey:@"titleTextColor"];
        [alert addAction:forthAction];
        
        [self presentViewController:alert animated:YES completion:^{
            NSLog(@"present action sheet complete");
        }];
    }
    
    if (indexPath.row == 3) {
        UIAlertController *controller = [UIAlertController mgt_alertSheetWithActionTitles:@[@"aaa", @"bbb", @"ccc"]
                                                                              titleColors:@[[UIColor greenColor], [UIColor magentaColor]]
                                                                                 handlers:@[^(UIAlertAction *action){
                                                                                            NSLog(@"aaa action");},
                                                                                             ^(UIAlertAction *action){
                                                                                        NSLog(@"bbb action");}]];
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    
    if (indexPath.row == 4) {
        UIAlertController *controller = [UIAlertController mgt_alertSheetWithActionTitles:@[@"aaa", @"bbb", @"ccc"] titleColors:@[[UIColor greenColor]] events:@[@"aaa", @"bbb"] routerView:self.view];
        [self presentViewController:controller animated:YES completion:nil];
    }
    
    if (indexPath.row == 5) {
        MGTVideoEditorController *controller = [[MGTVideoEditorController alloc] initWithNibName:nil bundle:nil];
        [controller setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"aaa"]) {
        NSLog(@"aaa action");
    }
    if ([eventName isEqualToString:@"bbb"]) {
        NSLog(@"bbb action");
    }
}

@end
