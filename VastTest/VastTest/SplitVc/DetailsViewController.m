//
//  DetailsViewController.m
//  SplitProject
//
//  Created by GoodSrc on 2019/2/18.
//  Copyright © 2019 GoodSrc. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 254 / 255.0 green:arc4random() % 254 / 255.0 blue:arc4random() % 254 / 255.0 alpha:1];
    self.navigationItem.title = @"Details";
    
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


@end
