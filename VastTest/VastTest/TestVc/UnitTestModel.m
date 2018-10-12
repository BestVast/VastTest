//
//  UnitTestModel.m
//  UnitTestDemo
//
//  Created by GoodSrc on 2018/9/13.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "UnitTestModel.h"

@implementation UnitTestModel

- (void)callbackDataSuccess:(void (^) (id data))success error:(void (^) (NSError *error))error1 {
    NSURL *url = [NSURL URLWithString:@"http://bpgg.bpbro.cn/home/index/showBroadcast"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"1->%@", error.localizedDescription);
            error1(error);
        }
        if (data) {
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                NSLog(@"2-%@", error.localizedDescription);
                error1(error);
            } else {
                NSLog(@"%@", result);
                success(result);
            }
        }
    }];
    [task resume];
}
@end

// 测试网址: http://www.weather.com.cn/adat/sk/101110101.html
