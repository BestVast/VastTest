//
//  VastTestTests.m
//  VastTestTests
//
//  Created by GoodSrc on 2018/10/10.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UnitTestModel.h"
@interface VastTestTests : XCTestCase

@end

@implementation VastTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    int a = 6, b = 7;
    int c = a + b;
    NSLog(@"%d", a + b);
//    XCTAssertEqual(13, c, @"add方法错误！");
}
- (void)testabc {
    int a =6, b= 7;
    XCTAssertFalse(a+b);
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        int a =6, b= 7;
        NSLog(@"%d", a + b);
        XCTAssertTrue(a+b);
        XCTAssertFalse(a+b);
    }];
}
- (void)testNetwork {
    UnitTestModel *model = [UnitTestModel new];
    [model callbackDataSuccess:^(id  _Nonnull data) {
        NSLog(@"%@", [NSString stringWithFormat:@"%@", data]);
    } error:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription) ;
    }];
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
@end
