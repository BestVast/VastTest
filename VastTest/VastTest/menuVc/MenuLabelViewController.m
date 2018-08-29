//
//  MenuLabelViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/6.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "MenuLabelViewController.h"

@interface MenuLabelViewController ()

@end

@implementation MenuLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self uiConfig];
}
- (void)uiConfig {
    UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, SCREEN_WIDTH - 20, 35)];
    menuLabel.backgroundColor = [UIColor cyanColor];
    menuLabel.userInteractionEnabled = YES;
    menuLabel.text = @"menu label show";
    menuLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:menuLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMenu:)];
    [menuLabel addGestureRecognizer:tap];
}

- (void)clickMenu:(UITapGestureRecognizer *)tap {
    //    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *view = (UILabel *)[tap view];
    CGPoint point = [tap locationInView:view];
    DLog(@"PointX->%f \nPointY->%f", point.x, point.y)
    [self becomeFirstResponder];
    UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"copy" action:@selector(clickCopy)];
    UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"delete" action:@selector(clickDelete)];
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    menuController.menuItems = [NSArray arrayWithObjects:item1, item2, nil];
    CGRect showRect = view.frame;//CGRectMake(view.frame.size.width/2 + view.frame.origin.x, view.frame.origin.y - 30, 100, 1);
    [menuController setTargetRect:showRect inView:self.view];
    [menuController setMenuVisible:YES animated:YES];
    //    menuController.menuVisible = YES;
    
}
//[简书-xiaoaihhh](https://www.jianshu.com/p/3e08d9ce201a)
//[简书-会跳舞的狮子](https://www.jianshu.com/p/a504c6a20808)
/**
 * 说明控制器可以成为第一响应者
 * 因为控制器是因为比较特殊的对象,它找控制器的方法,不找label的方法
 */
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    // 显示一个系统的paste以及自定义的a，b菜单
    if (action == @selector(paste:) ||
        action == @selector(clickCopy) ||
        action == @selector(clickDelete))
    {
        return YES;
    }
    else{
        return NO;
    }
}

- (void)clickCopy {
    DLog(@"clickCopy");
}
- (void)clickDelete {
    DLog(@"clickDelete");
}
- (void)paste:(UIMenuItem *)menuItem {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
