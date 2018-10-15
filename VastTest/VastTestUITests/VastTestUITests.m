//
//  VastTestUITests.m
//  VastTestUITests
//
//  Created by GoodSrc on 2018/10/10.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface VastTestUITests : XCTestCase

@end

@implementation VastTestUITests

- (void)setUp {
    [super setUp];
    
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
        
}

@end
