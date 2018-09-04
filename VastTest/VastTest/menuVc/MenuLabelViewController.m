//
//  MenuLabelViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/6.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "MenuLabelViewController.h"
#import "Masonry.h"
@interface MenuLabelViewController ()
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIImageView *pasteIv; // 粘贴图片
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
    [self addStackView];
}
- (void)addStackView {
    if (self.stackView) {
        [self.stackView removeFromSuperview];
        [self.view addSubview:self.stackView];
        [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY);
            make.leading.equalTo(self.view.mas_leading).offset(20);
            make.trailing.equalTo(self.view.mas_trailing).offset(-20);
            make.height.equalTo(@100);
        }];
    }
    NSInteger count = 3;
    if (_stackView.arrangedSubviews.count > 0) {
        count = _stackView.arrangedSubviews.count;
        for (UIView *view in _stackView.arrangedSubviews) {
            [_stackView removeArrangedSubview:view];
        }
    }
    count ++;
    for (NSInteger i = 0; i < count; i++) {
        UIView * newView = [[UIView alloc]init];
        newView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        [newView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@100);
            make.width.equalTo(@50);
        }];
        [self.stackView addArrangedSubview:newView];
    }
}

- (void)injected {
     [self addStackView];
}
- (void)clickMenu:(UITapGestureRecognizer *)tap {
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
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
//    [paste setString:@"clickCopy"]; 
    [paste setImage:[UIImage imageNamed:@"MVC1.png"]];
}
- (void)clickDelete {
    DLog(@"clickDelete");
    if (_pasteIv) {
        [_pasteIv removeFromSuperview];
        _pasteIv = nil;
    }
}
- (void)paste:(UIMenuItem *)menuItem {
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    if ([paste image]) {
        if (!_pasteIv) {
            [self.view addSubview:self.pasteIv];
        }
        self.pasteIv.image = [paste image];
    }
}

// https://blog.csdn.net/GGGHub/article/details/49251449
- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
                      //WithFrame:CGRectMake(0, 185 + 30, SCREEN_WIDTH, 120)];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.distribution = UIStackViewDistributionFillEqually;
        _stackView.spacing = 10;
        _stackView.alignment = UIStackViewAlignmentCenter;
        _stackView.backgroundColor = [UIColor cyanColor];
    }
    return _stackView;
}
- (UIImageView *)pasteIv {
    if (!_pasteIv) {
        _pasteIv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 190, 200, 150)];
        
    }
    return _pasteIv;
}
@end
