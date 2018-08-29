//
//  VastCatchCrash.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/13.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "VastCatchCrash.h"
#include <execinfo.h>
@implementation VastCatchCrash

// iOS异常捕获
// http://www.iosxxx.com/blog/2015-08-29-iosyi-chang-bu-huo.html
// https://github.com/m18210875071/signalException
// https://blog.csdn.net/shishaobo/article/details/78532915
// http://www.cocoachina.com/ios/20180726/24320.html

//1.信号量
//导致SIGABRT的错误，因为内存中根本就没有这个空间，哪来的free，就在栈中的对象而已

//2.ios崩溃
//NSArray *array= @[@"tom",@"xxx",@"ooo"];
//[array objectAtIndex:5];

//系统异常捕获
void uncaughtExceptionHandler(NSException *exception)
{
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@",name, reason, stackArray];
    DLog(@"%@", exceptionInfo);
    
    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:stackArray];
    [tmpArr insertObject:reason atIndex:0];
    
    
    DLog(@"%@", NSHomeDirectory());
    //保存到本地  --  当然你可以在下次启动的时候，上传这个log
    [exceptionInfo writeToFile:[NSString stringWithFormat:@"%@/Documents/OCCrash%lu.log",NSHomeDirectory(), fileCountByDocuments() + 1]  atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

NSInteger fileCountByDocuments() {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *files = [fileManager subpathsAtPath:[NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()]];
    return files.count;
}
//信号量截断
void SignalExceptionHandler(int signal)
{
    NSMutableString *mstr = [[NSMutableString alloc] init];
    [mstr appendString:@"Stack:\n"];
    void* callstack[128];
    int i, frames = backtrace(callstack, 128);
    char** strs = backtrace_symbols(callstack, frames);
    for (i = 0; i <frames; ++i) {
        [mstr appendFormat:@"%s\n", strs[i]];
    }

    //保存到本地  --  当然你可以在下次启动的时候，上传这个log
    [mstr writeToFile:[NSString stringWithFormat:@"%@/Documents/SignalCrash%lu.log",NSHomeDirectory(), fileCountByDocuments() + 1]  atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

void InstallSignalHandler(void)
{
    signal(SIGHUP, SignalExceptionHandler);
    signal(SIGINT, SignalExceptionHandler);
    signal(SIGQUIT, SignalExceptionHandler);
    
    signal(SIGABRT, SignalExceptionHandler);
    signal(SIGILL, SignalExceptionHandler);
    signal(SIGSEGV, SignalExceptionHandler);
    signal(SIGFPE, SignalExceptionHandler);
    signal(SIGBUS, SignalExceptionHandler);
    signal(SIGPIPE, SignalExceptionHandler);
}

@end
