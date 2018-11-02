//
//  UserInfo.h
//  VastTest
//
//  Created by GoodSrc on 2018/11/2.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject <NSCoding, NSCopying>
/**
 *  姓名、年龄、简介
 */
@property (nonatomic, copy)     NSString *name;
@property (nonatomic, assign)   NSInteger age;
@property (nonatomic, copy)     NSString *introduce;
@end

NS_ASSUME_NONNULL_END
