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
/**
 [3分钟实现iOS语音本地化/国际化](https://www.jianshu.com/p/88c1b65e3ddb)
 [iOS 国际化详解以及自动化脚本](https://juejin.im/entry/593140442f301e006bdbdf05)
 [IOS开发之国际化localization多语言支持](http://www.hudongdong.com/ios/393.html#menu_index_4)
 */

/**
 * 注意:
 * 中英文翻译的strings文件中，不能出现#注释，如果出现，则#后的翻译都不会显示
 */
+ (NSString *)getLanguage {
    NSArray *languages = [[NSUserDefaults standardUserDefaults] valueForKey:Apple_Languages];
    NSString *localLanguage = [[NSUserDefaults standardUserDefaults] valueForKey:Save_Local_Language];
    NSString *currentLanguage;
    if (localLanguage && localLanguage.length) {
        currentLanguage = localLanguage;
    } else {
        currentLanguage = languages.firstObject;
    }
    return currentLanguage;
}
+ (void)setLocalLanguage:(NSString *)language {
    
    [NSBundle setLanguage:language];
    [[NSUserDefaults standardUserDefaults] setValue:@[language] forKey:Apple_Languages];
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:Save_Local_Language];
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
    DLog(@"修改后语言: %@ \n", [LanguageHandleTool getLanguage]);
}

+ (NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table {
    NSString *langu = [self getLanguage];
    if ([[langu lowercaseString] hasPrefix:Language_En]) {
        langu = @"en";
    } else {
        langu = @"zh-Hans";
    }
    NSString *bundlePath = [[NSBundle mainBundle]pathForResource:@"VastProject" ofType:@"bundle"];
    NSBundle *vastBundle = [NSBundle bundleWithPath:bundlePath];
    NSString *path = [vastBundle pathForResource:langu ofType:@"lproj"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    NSString *show = NSLocalizedStringFromTableInBundle(key, table, bundle, nil);
    return show;
}


@end

