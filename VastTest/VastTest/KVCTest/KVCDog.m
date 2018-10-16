//
//  KVCDog.m
//  VastTest
//
//  Created by GoodSrc on 2018/10/16.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "KVCDog.h"


@implementation KVCDog
{
//    NSString *name;
    NSString *_name;
    NSString *_isName;
    NSString *isName;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}
// [iOS开发技巧系列---详解KVC](https://mp.weixin.qq.com/s/7nCG7v7-n-gqfrepsejWMQ)
// [来自简书](https://www.jianshu.com/p/45cbd324ea65)
+ (BOOL)accessInstanceVariablesDirectly{
    // 默认返回YES，表示如果没有找到Set<Key>方法的话，会按照key, _key，_is<Key>，is<Key>的顺序搜索成员，设置成NO就不这样搜索-必须写setter、getter方法使用
    return NO;
}
- (void)setName:(NSString *)name {
    _name = name;
}
- (NSString *)getName {
    return _name;
}
- (id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"出现异常，该key不存在%@",key);
    return nil;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"出现异常，该key不存在%@",key);
}
- (void)setNilValueForKey:(NSString *)key {
    NSLog(@"不能将「%@」设成nil",key);
}
@end
