//
//  NSBundle+Language.m
//  VastTest
//
//  Created by GoodSrc on 2018/10/15.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

// [掘金:Frankie](https://juejin.im/post/5aa69e9c6fb9a028e52d7e23)
#import "NSBundle+Language.h"
#import <objc/runtime.h>
static const char _bundle = 0;

@interface BundleEx : NSBundle

@end

@implementation BundleEx

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSBundle *bundle = objc_getAssociatedObject(self, &_bundle);
    return bundle ? [bundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}

@end

@implementation NSBundle (Language)

+ (void)setLanguage:(NSString *)language {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle], [BundleEx class]);
    });
    if ([language isEqualToString:@"en"]) {
        language = @"en";
    } else {
        language = @"zh-Hans";
    }
    objc_setAssociatedObject([NSBundle mainBundle], &_bundle, language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
