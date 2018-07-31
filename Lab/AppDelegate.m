//
//  AppDelegate.m
//  Lab
//
//  Created by zhaohao on 2018/5/25.
//

#import "AppDelegate.h"
#import "EntryViewController.h"
#import "ShareViewController.h"
#import "ImageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    EntryViewController *entryVC = [[EntryViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:entryVC];
    nav.title = @"nav";
    UITabBarController *tabController = [[UITabBarController alloc] init];
    ShareViewController *shareVC = [[ShareViewController alloc] init];
    shareVC.title = @"share";
    ImageViewController *imageVC = [[ImageViewController alloc] init];
    imageVC.title = @"image";
    
    NSMutableArray *controllerArray = [NSMutableArray arrayWithCapacity:3];
    [controllerArray addObject:shareVC];
    [controllerArray addObject:nav];
    [controllerArray addObject:imageVC];
    
//    for (int index = 0; index < 5; index++) {
//        UIViewController *vc = [[UIViewController alloc] init];
//        vc.title = [NSString stringWithFormat:@"%d vc", index];
//        vc.view.backgroundColor = [UIColor yellowColor];
//        [controllerArray addObject:vc];
//    }
    
    
    [tabController setViewControllers:controllerArray];
    tabController.tabBar.tintColor = [UIColor blueColor];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tabController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
