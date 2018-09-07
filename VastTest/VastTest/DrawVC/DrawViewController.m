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
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(10, 100, 120, 120);
    btn.backgroundColor = [UIColor cyanColor];
    [btn setTitle:@"button" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self btnTopImageAndBottomTitle:btn];
}

- (void)btnTopImageAndBottomTitle:(UIButton *)btn {
    CGFloat spacing = 10.0f;
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    
    // lower the text and push it left to center it
    btn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing/2), 0.0);
    
    // the text width might have changed (in case it was shortened before due to
    // lack of space and isn't anymore now), so we get the frame size again
    titleSize = btn.titleLabel.frame.size;
    
    // raise the image and push it right to center it
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing/2), 0.0, 0.0, - titleSize.width);
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
