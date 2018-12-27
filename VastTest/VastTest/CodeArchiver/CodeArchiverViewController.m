//
//  CodeArchiverViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/11/2.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "CodeArchiverViewController.h"
#import "UserInfo.h"
@interface CodeArchiverViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *ageTf;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTf;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@end

@implementation CodeArchiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self uiConfig];
    [self dataConfig];
}
#define USER_INFO @"userInfo"
- (IBAction)saveUserInfo:(UIButton *)sender {
    if (self.nameTf.text.length
        && self.ageTf.text.length
        && self.descriptionTf.text.length) {
        UserInfo *user = [[UserInfo alloc] init];
        user.name = self.nameTf.text;
        user.age = [self.ageTf.text integerValue];
        user.introduce = self.descriptionTf.text;
        NSMutableData *mutableData = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
        [archiver encodeObject:user forKey:USER_INFO];
        [archiver finishEncoding];
        [[NSUserDefaults standardUserDefaults] setValue:mutableData forKey:USER_INFO];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    } else {
        [SVProgressHUD showErrorWithStatus:@"请完善信息"];
    }
}

- (void)uiConfig {
    self.navigationItem.title = @"解归档";
    // [https://www.jianshu.com/p/187681b031b1](简书: kvo修改tf的placeholder字体颜色字体大小)
    [self.nameTf setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.nameTf setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
}
- (void)dataConfig {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USER_INFO];
    if (data != nil) {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        UserInfo *user = [unarchiver decodeObjectForKey:USER_INFO];
        [unarchiver finishDecoding];
        self.nameTf.text = user.name;
        self.ageTf.text = [NSString stringWithFormat:@"%ld", user.age];
        self.descriptionTf.text = user.introduce;
        
        UserInfo *copyUser = [user copy];
        DLog(@"%@", copyUser);
        DLog(@"%p %p", user, copyUser);
    }
}
@end
