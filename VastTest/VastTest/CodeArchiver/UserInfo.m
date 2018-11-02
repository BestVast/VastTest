//
//  UserInfo.m
//  VastTest
//
//  Created by GoodSrc on 2018/11/2.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "UserInfo.h"
#define NAME        @"name"
#define AGE         @"age"
#define INTRODUCE   @"introduce"
@implementation UserInfo

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:NAME];
    [aCoder encodeObject:@(self.age) forKey:AGE];
    [aCoder encodeObject:self.introduce forKey:INTRODUCE];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:NAME];
        self.age = [[aDecoder decodeObjectForKey:AGE] integerValue];
        self.introduce = [aDecoder decodeObjectForKey:INTRODUCE];
    }
    return self;
}
- (nonnull id)copyWithZone:(nullable NSZone *)zone { 
    UserInfo *user = [[UserInfo alloc] init];
    user.name = self.name;
    user.age  = self.age;
    user.introduce = self.introduce;
    return user;
}
- (NSString *)description {
    return [NSString stringWithFormat:@"UserInfo \name: %@ \nage: %ld \nintroduce: %@", self.name, self.age, self.introduce];
}

@end
