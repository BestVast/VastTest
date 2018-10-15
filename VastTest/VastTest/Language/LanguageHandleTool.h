//
//  LanguageHandleTool.h
//  VastTest
//
//  Created by GoodSrc on 2018/10/12.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, LanguageSelect) {
    Language_Chinese, // zh-Hans-US
    Language_Engulish,// en
};
#define Langu_En      @"en"
#define Langu_Chinese @"zh-Hans-US"
@interface LanguageHandleTool : NSObject
+ (NSString *)getLanguage;

+ (void)setLocalLanguage:(LanguageSelect)language;

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
