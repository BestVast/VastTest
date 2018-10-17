//
//  KVCTestViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/10/16.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "KVCTestViewController.h"
#import "KVCDog.h"
#import <objc/runtime.h>
@interface KVCTestViewController ()
@property (weak, nonatomic) IBOutlet UIButton *kvcTestBtn;

@end

@implementation KVCTestViewController
{
    KVCDog *_dog;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dog = [[KVCDog alloc] init];
    
    id i = [self performSelector:@selector(foo:) withObject:@"123"];
    DLog(@"%@", i);
}
- (IBAction)clickKVCTestButton:(id)sender {
    UIButton *btn = sender;
    DLog(@"currentTitle-%@", btn.currentTitle);
    
    [_dog setValue:@"name" forKey:@"name"];
    
    DLog(@"%@", [_dog valueForKey:@"name"]);
    DLog(@"%@", [_dog valueForKey:@"_name"]);
    DLog(@"%@", [_dog valueForKey:@"isName"]);
    DLog(@"%@", [_dog valueForKey:@"_isName"]);
    DLog(@"%@", [_dog dictionaryWithValuesForKeys:@[@"isName", @"_isName"]]);
}


+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(foo:)) {
        class_addMethod([self class], sel, (IMP)foo1, "");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
id foo1(id obj, SEL _cmd, NSString *aaa) {
    NSLog(@"22222-%@, %@", obj, aaa);
    return @(5);
}

@end
