//
//  EncryptionViewController.m
//  Internationale
//
//  Created by GoodSrc on 2018/5/22.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "EncryptionViewController.h"
#import "CustomView.h"
#import "CustomLoginInputView.h"
#import "RSAEncryptor.h"
@interface EncryptionViewController ()

@end

@implementation EncryptionViewController
{
    CustomLoginInputView *input;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:@[@"1", @"2", @"3", @"4", @"5"]];
    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < 3) {
            [tempArray removeObjectAtIndex:idx];
            NSLog(@"%@", tempArray);
        }
    }];
    
    
    
    [self uiConfigure];
}

- (void)uiConfigure {
    input = [[CustomLoginInputView alloc] getLoginPageTextFieldFrame:CGRectMake(10, 100, SCREEN_WIDTH - 20, 30) withLeftImageName:nil withPlaceholder:@"test" callbackText:^(NSString *tfString) {
        
    }];
    [self.view addSubview:input];
    UIButton *btn = [CustomView getButtonFrame:CGRectMake(30, CGRectGetMaxY(input.frame) + 30, SCREEN_WIDTH - 60, 40) title:@"encryption" titleColor:[UIColor blackColor] backGroundColor:[UIColor whiteColor] cornerRadius:5];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(testEncryption) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [CustomView getButtonFrame:CGRectMake(30, CGRectGetMaxY(input.frame) + 100, SCREEN_WIDTH - 60, 40) title:@"encryption2" titleColor:[UIColor blackColor] backGroundColor:[UIColor whiteColor] cornerRadius:5];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(testDecord) forControlEvents:UIControlEventTouchUpInside];
}
- (void)testEncryption {
    //原始数据
    NSString *originalString = @"这是一段将要使用'.der'文件加密的字符串!";

    //使用.der和.p12中的公钥私钥加密解密
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];
    
    NSString *encryptStr = [RSAEncryptor encryptString:originalString publicKeyWithContentsOfFile:public_key_path];
    NSLog(@"加密前:%@", originalString);
    NSLog(@"加密后:%@", encryptStr);
    NSLog(@"解密后2:%@", [RSAEncryptor decryptString:encryptStr privateKeyWithContentsOfFile:private_key_path password:@"good"]);

}
- (void)testDecord {
    //使用.der和.p12中的公钥私钥加密解密
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];
    //原始数据
    NSString *originalString = @"这是第二段将要使用'.der'文件加密的字符串!";
    if (input.textField.text.length > 0) {
        originalString = input.textField.text;
    }
    NSString *encryptStr = [RSAEncryptor encryptString:originalString publicKeyWithContentsOfFile:public_key_path];
    NSLog(@"加密前:%@", originalString);
    NSLog(@"加密后:%@", encryptStr);
    NSLog(@"解密后2:%@", [RSAEncryptor decryptString:encryptStr privateKeyWithContentsOfFile:private_key_path password:@"good"]);
}
@end
