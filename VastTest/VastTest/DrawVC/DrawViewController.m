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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"start !");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL isSucc = YES;
        while (isSucc) {
            @autoreleasepool {
                [NSThread sleepForTimeInterval:1.0];
                NSLog(@"create an obj");
            }
        }
    });
}
- (void)dealloc {
    DLog(@"dealloc");
}


@end
