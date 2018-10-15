//
//  LanguageHandleTool.m
//  VastTest
//
//  Created by GoodSrc on 2018/10/12.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "LanguageHandleTool.h"
#import "ViewController.h"
#import "FlowCollectionViewController.h"
#import "NSBundle+Language.h"
@implementation LanguageHandleTool

+ (NSString *)getLanguage {
    NSArray *languages = [[NSUserDefaults standardUserDefaults] valueForKey:@"AppleLanguages"];
    NSString *currentLanguage = languages.firstObject;
    return currentLanguage;
}

+ (void)setLocalLanguage:(NSString *)language {
    
    [NSBundle setLanguage:language];
    [[NSUserDefaults standardUserDefaults] setValue:@[language] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray *)allLanguage {
    // 获取系统当前支持的语言代号：
    NSArray *localeIdentifiers = [NSLocale availableLocaleIdentifiers];
    return localeIdentifiers;
}

+ (void)resetRootViewController {
    ViewController *vc = [[ViewController alloc] init];
    [UIApplication sharedApplication].delegate.window.rootViewController = vc;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[[FlowCollectionViewController alloc] init]];
    [vc presentViewController:navi animated:YES completion:nil];
    DLog(@"%@ \n", [LanguageHandleTool getLanguage]);
}

+ (NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table {
    NSString *langu = [self getLanguage];
    if ([langu isEqualToString:Language_Chinese]) {
        langu = @"zh-Hans";
    }
    NSString *path = [[NSBundle mainBundle]pathForResource:langu ofType:@"lproj"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    return NSLocalizedStringFromTableInBundle(key, table, bundle, nil);
}


@end

