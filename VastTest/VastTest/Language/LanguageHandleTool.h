//
//  LanguageHandleTool.h
//  VastTest
//
//  Created by GoodSrc on 2018/10/12.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define Language_En      @"en"
#define Language_Chinese @"zh-Hans-US"
#define Apple_Languages  @"AppleLanguages"
@interface LanguageHandleTool : NSObject
+ (NSString *)getLanguage;

+ (void)setLocalLanguage:(NSString *)language;

+ (NSArray *)allLanguage;

+ (void)resetRootViewController;

/**
 *  返回table中指定的key的值
 *
 *  @param key   key
 *  @param table table
 *
 *  @return 返回table中指定的key的值
 */
+ (NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table;


@end

NS_ASSUME_NONNULL_END
