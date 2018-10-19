//
//  UIButton+VastRepeatClick.m
//  VastTest
//
//  Created by GoodSrc on 2018/10/17.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "UIButton+VastRepeatClick.h"
#import <objc/runtime.h>
@implementation UIButton (VastRepeatClick)
// [按钮防止被重复点击(ios)](https://www.jianshu.com/p/3c94e8cd21ab)
static const char *UIButton_RepeatTimeInterval = "UIButton_RepeatTimeInterval";
- (NSTimeInterval)timeInterval {
    return [objc_getAssociatedObject(self, UIButton_RepeatTimeInterval) doubleValue];
}
- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    objc_setAssociatedObject(self, UIButton_RepeatTimeInterval, @(timeInterval), OBJC_ASSOCIATION_ASSIGN);
}
static const char *UIButton_IsIgnoreEvent = "UIButton_IsIgnoreEvent";
- (BOOL)isIgnoreEvent {
    return [objc_getAssociatedObject(self, UIButton_IsIgnoreEvent) boolValue];
}
- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent {
    objc_setAssociatedObject(self, UIButton_IsIgnoreEvent, @(isIgnoreEvent), OBJC_ASSOCIATION_ASSIGN);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sel = @selector(sendAction:to:forEvent:);
        SEL vastSel = @selector(vast_sendAction:to:forEvent:);
        Method method = class_getInstanceMethod(self, sel);
        Method vastMethod = class_getInstanceMethod(self, vastSel);
        //将methodB的实现添加到系统方法中也就是说将methodA方法指针添加成方法methodB的返回值表示是否添加成功
        BOOL isSuccess = class_addMethod(self, sel, method_getImplementation(vastMethod), method_getTypeEncoding(vastMethod));
        if (isSuccess) {
            //添加成功了说明本类中不存在methodB所以此时必须将方法b的实现指针换成方法A的，否则b方法将没有实现。
            class_replaceMethod(self, vastSel, method_getImplementation(method), method_getTypeEncoding(method));
        } else {
            //添加失败了说明本类中有methodB的实现，此时只需要将methodA和methodB的IMP互换一下即可。
            method_exchangeImplementations(method, vastMethod);
        }
    });
}

- (void)vast_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (self.isIgnoreEvent) {
        return;
    } else if (self.timeInterval > 0) {
        [self performSelector:@selector(resetIgnoreEvent) withObject:nil afterDelay:self.timeInterval];
    }
    self.isIgnoreEvent = YES;
    //此处methodA和methodB方法IMP互换了，实际上执行sendAction；所以不会死循环
    [self vast_sendAction:action to:target forEvent:event];
}

- (void)resetIgnoreEvent {
    self.isIgnoreEvent = NO;
}


@end
