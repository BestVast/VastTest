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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.kvo = [FBKVOController controllerWithObserver:self];
    self.loginVM = [LoginViewModel new];
    [self uiConfig];
    [self setNavigationBar];
}
- (void)setNavigationBar {
    self.navigationItem.title = @"Login";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
}

- (void)uiConfig {
    UITextField *userTf = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, SCREEN_WIDTH - 100, 40)];
    userTf.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:userTf];
    userTf.text = self.loginVM.loginModel.username;
    [userTf addTarget:self action:@selector(_textfieldHandle:) forControlEvents:UIControlEventEditingChanged];
    [self.kvo observe:self.loginVM.loginModel keyPath:@"username" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        userTf.text = change[NSKeyValueChangeNewKey];
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 180, 60, 50);
    [btn setTitle:@"Login" forState:UIControlStateNormal];
    [btn setTitle:@"" forState:UIControlStateSelected];
    [btn setTitle:@"" forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(loginButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(SCREEN_WIDTH - 50 - 60, 180, 60, 50);
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
