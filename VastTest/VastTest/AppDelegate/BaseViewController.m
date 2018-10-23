//
//  BaseViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/7/31.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = NSStringFromClass([self class]);
    if (self.navigationController.navigationBar.hidden == NO
        || self.navigationController.viewControllers.count == 1
        || [self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backUpper)];
    }
}

- (CGFloat)viewWidth {
    UINavigationController *mastNavi = self.splitViewController.viewControllers.firstObject;
    UIViewController *vc = mastNavi.topViewController;
    DLog(@"mastWidth-> %f", vc.view.bounds.size.width);
    DLog(@"width-> %f, screenWidth-> %f", (self.view.bounds.size.width), SCREEN_WIDTH);
    CGFloat width = self.view.bounds.size.width;
    CGFloat masterWidth = vc.view.bounds.size.width;
    if (width == SCREEN_WIDTH
        && masterWidth < SCREEN_WIDTH) {
        width = SCREEN_WIDTH - masterWidth;
    }
    return width;
}


- (void)backUpper {
    if (self.navigationController.viewControllers
        && ![self.navigationController.viewControllers.firstObject isEqual:self]) {
        
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
