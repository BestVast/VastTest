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
