//
//  LoginViewModel.h
//  VastTest
//
//  Created by GoodSrc on 2018/8/2.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LoginModel;
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject
@property (nonatomic, strong) LoginModel *loginModel;

- (void)loginVerification:(void (^) (BOOL success, NSDictionary *data))success failure:(void (^) (NSError *failure))failureBlock;
- (void)setModelUsername:(NSString *)username;
- (void)clearModelUsername;

@end

NS_ASSUME_NONNULL_END
