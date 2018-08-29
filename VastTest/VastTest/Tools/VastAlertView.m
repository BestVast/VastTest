//
//  VastAlertView.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/6.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "VastAlertView.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
@implementation VastAlertAction
- (instancetype)initWithTitle:(NSString *)title index:(NSInteger)index style:(UIAlertActionStyle)style {
    if (self == [super init]) {
        self.title = title;
        self.index = index;
        self.style = style;
    }
    return self;
}
@end


@implementation VastAlertView
+ (void)presentVastAlertVcTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)style actions:(NSArray<VastAlertAction *> *)actions callback:(void (^)(VastAlertAction * _Nonnull))callback {
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    [[self getRootNavController] presentViewController:alertVc animated:YES completion:nil];
    for (VastAlertAction *action in actions) {
        @WeakObj(action);
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:action.title style:action.style handler:^(UIAlertAction * _Nonnull action) {
            if (callback) callback(actionWeak);
        }];
        [alertVc addAction:action1];
    }
}

//获取当前视图
+ (UIViewController *)getRootNavController {
    //获取根视图
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootController= (BaseViewController *)appdelegate.window.rootViewController;
    return rootController;
}
/** 获取当前控制器 */
+ (UIViewController *)currentVC
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    //当前windows的根控制器
    UIViewController *controller = window.rootViewController;
    
    //通过循环一层一层往下查找
    while (YES) {
        //先判断是否有present的控制器
        if (controller.presentedViewController) {
            //有的话直接拿到弹出控制器，省去多余的判断
            controller = controller.presentedViewController;
        } else {
            if ([controller isKindOfClass:[UINavigationController class]]) {
                //如果是NavigationController，取最后一个控制器（当前）
                controller = [controller.childViewControllers lastObject];
            } else if ([controller isKindOfClass:[UITabBarController class]]) {
                //如果TabBarController，取当前控制器
                UITabBarController *tabBarController = (UITabBarController *)controller;
                controller = tabBarController.selectedViewController;
            } else {
                if (controller.childViewControllers.count > 0) {
                    //如果是普通控制器，找childViewControllers最后一个
                    controller = [controller.childViewControllers lastObject];
                } else {
                    //没有present，没有childViewController，则表示当前控制器
                    return controller;
                }
            }
        }
    }
}
@end
