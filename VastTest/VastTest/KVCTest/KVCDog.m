//
//  KVCDog.m
//  VastTest
//
//  Created by GoodSrc on 2018/10/16.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "KVCDog.h"
#import <objc/runtime.h>

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

- (void)test {
    NSMutableArray * keys = [NSMutableArray array];
    NSMutableArray * attributes = [NSMutableArray array];
    unsigned int outCount;
    objc_property_t * properties = class_copyPropertyList([UITextField class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        //通过property_getName函数获得属性的名字
        NSString * propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
        //通过property_getAttributes函数可以获得属性的名字和@encode编码
        NSString * propertyAttribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        [attributes addObject:propertyAttribute];
    }
    //立即释放properties指向的内存
    free(properties);
    DLog(@"%@", keys);
    DLog(@"%@", attributes);
}


@end
