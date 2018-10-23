//
//  LoginViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/1.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "LoginModel.h"
#import "FBKVOController.h"
#import "ListViewController.h"
@interface LoginViewController ()
@property (nonatomic, strong) LoginViewModel *loginVM;
@property (nonatomic, strong) FBKVOController *kvo;
@end

@implementation LoginViewController
{
    UITextField *userTf;
    UIButton *btn;
    UIButton *clearBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.kvo = [FBKVOController controllerWithObserver:self];
    self.loginVM = [LoginViewModel new];
    [self uiConfig];
    [self setNavigationBar];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
}
- (void)deviceOrientationDidChange
{
    NSLog(@"deviceOrientationDidChange:%ld",(long)[UIDevice currentDevice].orientation);
    DLog(@"width->%f,\n self.view.width->%f", SCREEN_WIDTH, (self.view.bounds.size.width));
    if([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait
       || [UIDevice currentDevice].orientation == UIDeviceOrientationPortraitUpsideDown) {
//        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        [self orientationChange:NO];
        //注意： UIDeviceOrientationLandscapeLeft 与 UIInterfaceOrientationLandscapeRight
    } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft
               || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        [self orientationChange:YES];
    }
}

- (void)orientationChange:(BOOL)landscapeRight {
    [self viewRefreshByWidth];
}

- (void)viewRefreshByWidth {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.1f animations:^{
            //            self.view.transform = CGAffineTransformMakeRotation(0);
            //            self.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH*2/3, SCREEN_HEIGHT);
            CGFloat viewWidth = [self viewWidth];
            self->userTf.frame = CGRectMake(50, 100, viewWidth - 100, 40);
            self->clearBtn.frame = CGRectMake(viewWidth - 50 - 60, 180, 60, 50);
        }];
    });
}
    

- (void)setNavigationBar {
    self.navigationItem.title = @"Login";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
}

- (void)uiConfig {
    CGFloat viewWidth = [self viewWidth];
    userTf = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, viewWidth - 100, 40)];
    userTf.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:userTf];
    userTf.text = self.loginVM.loginModel.username;
    [userTf addTarget:self action:@selector(_textfieldHandle:) forControlEvents:UIControlEventEditingChanged];
    @WeakObj(userTf);
    [self.kvo observe:self.loginVM.loginModel keyPath:@"username" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
            userTfWeak.text = change[NSKeyValueChangeNewKey];
    }];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 180, 60, 50);
    [btn setTitle:@"Login" forState:UIControlStateNormal];
    [btn setTitle:@"" forState:UIControlStateSelected];
    [btn setTitle:@"" forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(loginButton) forControlEvents:UIControlEventTouchUpInside];
    
    clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(viewWidth - 50 - 60, 180, 60, 50);
    [clearBtn setTitle:@"Clear" forState:UIControlStateNormal];
    [clearBtn setTitle:@"" forState:UIControlStateSelected];
    [clearBtn setTitle:@"" forState:UIControlStateHighlighted];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clearBtn setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:clearBtn];
    [clearBtn addTarget:self action:@selector(clearButton) forControlEvents:UIControlEventTouchUpInside];
}
- (void)loginButton {
    
    [self.loginVM loginVerification:^(BOOL success, NSDictionary * _Nonnull data) {
        if (success) {
            ListViewController *listVc = [[ListViewController alloc] init];
            [self.navigationController pushViewController:listVc animated:YES];
        }
    } failure:^(NSError * _Nonnull failure) {
        
    }];
}
- (void)clearButton {
    [self.loginVM clearModelUsername];
}
- (void)_textfieldHandle:(UITextField *)tf {
    [self.loginVM setModelUsername:tf.text];
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
