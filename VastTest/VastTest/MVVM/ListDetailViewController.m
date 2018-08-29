//
//  ListDetailViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/7/31.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "ListDetailViewController.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self uiConfig];
}

- (void)uiConfig {
    self.navigationItem.title = @"详情页面";
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
