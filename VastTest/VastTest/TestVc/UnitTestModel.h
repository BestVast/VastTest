//
//  UnitTestModel.h
//  UnitTestDemo
//
//  Created by GoodSrc on 2018/9/13.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnitTestModel : NSObject
- (void)callbackDataSuccess:(void (^) (id data))success error:(void (^) (NSError *error))error1;
@end

NS_ASSUME_NONNULL_END
