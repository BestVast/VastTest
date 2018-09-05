//
//  DrawViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/6.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "DrawViewController.h"

@interface DrawViewController ()

@end

@implementation DrawViewController
{
    BOOL isSucc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"start !");
    [self uiConfig];
}

- (void)uiConfig {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 100, 300, 700);
    [btn setTitle:@"MVVM1" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"MVVM1.png"] forState:UIControlStateNormal];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
}



- (void)globalTest {
    isSucc = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (self->isSucc) {
            [NSThread sleepForTimeInterval:3.0];
            NSLog(@"create an obj");
        }
    });
}
- (void)backUpper {
    [super backUpper];
    isSucc = NO;
}
- (void)dealloc {
    DLog(@"dealloc");
}


@end
