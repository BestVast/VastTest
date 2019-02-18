//
//  SecondViewController.m
//  SplitProject
//
//  Created by GoodSrc on 2019/2/18.
//  Copyright © 2019 GoodSrc. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 254 / 255.0 green:arc4random() % 254 / 255.0 blue:arc4random() % 254 / 255.0 alpha:1];
    self.navigationItem.title = @"Second";

    [self uiConfig];
}

- (void)uiConfig {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor cyanColor];
    btn.frame = CGRectMake(10, 100 + 55, 88, 45);
    btn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 200) / 2, 150, 200, 55);
    [self.view addSubview:btn];
    [btn setTitle:NSStringFromClass([self class]) forState:UIControlStateNormal];
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
