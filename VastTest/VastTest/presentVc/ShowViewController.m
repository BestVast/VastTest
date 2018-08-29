//
//  ShowViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/7/24.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "ShowViewController.h"
#import "VastAlertView.h"
@interface ShowViewController ()

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    UIView *alert = [[UIView alloc] initWithFrame:CGRectMake(60, 150, SCREEN_WIDTH - 120, 300)];
    
    alert.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:alert];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
    [self.view addGestureRecognizer:tap];
    DLog(@"2");
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    DLog(@"1");
}
- (void)tapView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#warning mark == Warning: Attempt to present <UIAlertController: 0x7f838687b200>  on <ViewController: 0x7f838650a4a0> which is already presenting <ShowViewController: 0x7f838660c4d0> ==
- (void)click {
    VastAlertAction *action1 = [[VastAlertAction alloc] initWithTitle:@"退出" index:0 style:UIAlertActionStyleDestructive];
    VastAlertAction *action2 = [[VastAlertAction alloc] initWithTitle:@"取消" index:1 style:UIAlertActionStyleDefault];
    [VastAlertView presentVastAlertVcTitle:@"提示" message:@"是否退出当前页面" preferredStyle:UIAlertControllerStyleAlert actions:@[action1, action2] callback:^(VastAlertAction * _Nonnull action) {
        if (action.index == 0) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
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
