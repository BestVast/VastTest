//
//  AppDelegate.m
//  VastTest
//
//  Created by GoodSrc on 2018/7/24.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "AppDelegate.h"
#import "VastCatchCrash.h"
#import "ViewController.h"
#import "SplitViewController.h"
@interface AppDelegate ()<UISplitViewControllerDelegate>
@property (strong,nonatomic)UISplitViewController *splitViewController; //声明分割控制器

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler); // 该函数可在任务未知调用。
    InstallSignalHandler();
    
#if DEBUG
    // iOS
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
#endif
    
    //创建分割控制器
    self.splitViewController = [[UISplitViewController alloc]init];
    //创建MasterVC
    ViewController *MasterVC = [[ViewController alloc]init];
    //创建DetailVC
    SplitViewController *DetailVC = [[SplitViewController alloc]init];
    //创建左侧导航控制器
    UINavigationController *MasterNavigationController = [[UINavigationController alloc]initWithRootViewController:MasterVC];
    //创建右侧导航栏控制器
    UINavigationController *DetailNavigationController = [[UINavigationController alloc]initWithRootViewController:DetailVC];
    // 设置 UISplitViewController 所管理的左、右两个 UIViewController
    self.splitViewController.viewControllers = @[MasterNavigationController, DetailNavigationController];
    //设置分割控制器分割模式
    self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
    //设置代理
    self.splitViewController.delegate = self;
    //设置window的根控制器
    self.window.rootViewController = self.splitViewController;
    
    return YES;
}

#pragma mark -<UISplitViewController>
//主控制器将要隐藏时触发的方法
-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = @"Master";
    //master将要隐藏时，给detail设置一个返回按钮
    UINavigationController *Nav = [self.splitViewController.viewControllers lastObject];
    SplitViewController *Detail = (SplitViewController *)[Nav topViewController];
    
    Detail.navigationItem.leftBarButtonItem = barButtonItem;
}
//开始时取消二级控制器,只显示详细控制器
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    return YES;
}
//主控制器将要显示时触发的方法
-(void)splitViewController:(UISplitViewController *)sender willShowViewController:(UIViewController *)master invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    //master将要显示时,取消detail的返回按钮
    UINavigationController *Nav = [self.splitViewController.viewControllers lastObject];
    SplitViewController *Detail = (SplitViewController *)[Nav topViewController];
    
    Detail.navigationItem.leftBarButtonItem = nil;
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
