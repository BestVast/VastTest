//
//  VastCatchCrash.h
//  VastTest
//
//  Created by GoodSrc on 2018/8/13.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

// Crash 异常捕获
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VastCatchCrash : NSObject

void uncaughtExceptionHandler(NSException *exception);
void InstallSignalHandler(void);
@end

NS_ASSUME_NONNULL_END
