//
//  LoginViewModel.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/2.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "LoginViewModel.h"
#import "LoginModel.h"
@implementation LoginViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.loginModel = [[LoginModel alloc] init];
    }
    return self;
}
- (void)loginVerification:(void (^) (BOOL success, NSDictionary *data))success failure:(void (^) (NSError *failure))failureBlock {
    if (self.loginModel.username.length) {
        if (success) {
            success(YES, @{});
        }
    } else {
        failureBlock([NSError errorWithDomain:@"username length <= 0" code:1 userInfo:@{}]);
    }
}
- (void)setModelUsername:(NSString *)username {
    self.loginModel.username = username;
}

- (void)clearModelUsername {
    self.loginModel.username = @"";
}
@end
