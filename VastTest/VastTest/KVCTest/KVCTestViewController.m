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
#import "UIButton+VastRepeatClick.h"
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
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((SCREEN_WIDTH - 200) / 2, 260, 200, 50);
    [btn setTitle:@"5s防重复点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor cyanColor];
    btn.timeInterval = 5;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickRepeat:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)clickRepeat:(UIButton *)btn {
    DLog(@"clickRepeat");
    NSString *title = btn.titleLabel.text;
    [btn setTitle:[title stringByAppendingString:@"-1"] forState:UIControlStateNormal];
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

// [掘金: iOS Runtime详解](https://juejin.im/post/5ac0a6116fb9a028de44d717)
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
