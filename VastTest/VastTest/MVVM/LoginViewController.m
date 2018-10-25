//
//  LoginViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/8/1.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "LoginModel.h"
#import "FBKVOController.h"
#import "ListViewController.h"
#import "VastMagnifierTool.h"

@interface LoginViewController ()
@property (nonatomic, strong) LoginViewModel *loginVM;
@property (nonatomic, strong) FBKVOController *kvo;
@end

@implementation LoginViewController
{
    UITextField *userTf;
    UIButton *btn;
    UIButton *clearBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.kvo = [FBKVOController controllerWithObserver:self];
    self.loginVM = [LoginViewModel new];
    [self uiConfig];
    [self setNavigationBar];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
}
- (void)deviceOrientationDidChange
{
    NSLog(@"deviceOrientationDidChange:%ld",(long)[UIDevice currentDevice].orientation);
    DLog(@"width->%f,\n self.view.width->%f", SCREEN_WIDTH, (self.view.bounds.size.width));
    if([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait
       || [UIDevice currentDevice].orientation == UIDeviceOrientationPortraitUpsideDown) {
//        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        [self orientationChange:NO];
        //注意： UIDeviceOrientationLandscapeLeft 与 UIInterfaceOrientationLandscapeRight
    } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft
               || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        [self orientationChange:YES];
    }
}

- (void)orientationChange:(BOOL)landscapeRight {
    [self viewRefreshByWidth];
}

- (void)viewRefreshByWidth {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.1f animations:^{
            //            self.view.transform = CGAffineTransformMakeRotation(0);
            //            self.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH*2/3, SCREEN_HEIGHT);
            CGFloat viewWidth = [self viewWidth];
            self->userTf.frame = CGRectMake(50, 100, viewWidth - 100, 40);
            self->clearBtn.frame = CGRectMake(viewWidth - 50 - 60, 180, 60, 50);
        }];
    });
}
    

- (void)setNavigationBar {
    self.navigationItem.title = @"Login";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
}

- (void)uiConfig {
    CGFloat viewWidth = [self viewWidth];
    userTf = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, viewWidth - 100, 40)];
    userTf.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:userTf];
    userTf.text = self.loginVM.loginModel.username;
    [userTf addTarget:self action:@selector(_textfieldHandle:) forControlEvents:UIControlEventEditingChanged];
    @WeakObj(userTf);
    [self.kvo observe:self.loginVM.loginModel keyPath:@"username" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
            userTfWeak.text = change[NSKeyValueChangeNewKey];
    }];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 180, 60, 50);
    [btn setTitle:@"Login" forState:UIControlStateNormal];
    [btn setTitle:@"" forState:UIControlStateSelected];
    [btn setTitle:@"" forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(loginButton) forControlEvents:UIControlEventTouchUpInside];
    
    clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(viewWidth - 50 - 60, 180, 60, 50);
    [clearBtn setTitle:@"Clear" forState:UIControlStateNormal];
    [clearBtn setTitle:@"" forState:UIControlStateSelected];
    [clearBtn setTitle:@"" forState:UIControlStateHighlighted];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clearBtn setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:clearBtn];
    [clearBtn addTarget:self action:@selector(clearButton) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 330, SCREEN_WIDTH, 600)];
    label.text = @"汉皇重色思倾国，御宇多年求不得。杨家有女初长成，养在深闺人未识。天生丽质难自弃，一朝选在君王侧。回眸一笑百媚生，六宫粉黛无颜色。春寒赐浴华清池，温泉水滑洗凝脂。侍儿扶起娇无力，始是新承恩泽时。云鬓花颜金步摇，芙蓉帐暖度春宵。春宵苦短日高起，从此君王不早朝。承欢侍宴无闲暇，春从春游夜专夜。后宫佳丽三千人，三千宠爱在一身。金屋妆成娇侍夜，玉楼宴罢醉和春。姊妹弟兄皆列土，可怜光彩生门户。遂令天下父母心，不重生男重生女。骊宫高处入青云，仙乐风飘处处闻。缓歌谩舞凝丝竹，尽日君王看不足。渔阳鼙鼓动地来，惊破霓裳羽衣曲。九重城阙烟尘生，千乘万骑西南行。翠华摇摇行复止，西出都门百余里。六军不发无奈何，宛转蛾眉马前死。花钿委地无人收，翠翘金雀玉搔头。君王掩面救不得，回看血泪相和流。黄埃散漫风萧索，云栈萦纡登剑阁。峨嵋山下少人行，旌旗无光日色薄。蜀江水碧蜀山青，圣主朝朝暮暮情。行宫见月伤心色，夜雨闻铃肠断声。天旋地转回龙驭，到此踌躇不能去。马嵬坡下泥土中，不见玉颜空死处。君臣相顾尽沾衣，东望都门信马归。\n 汉皇重色思倾国，御宇多年求不得。杨家有女初长成，养在深闺人未识。天生丽质难自弃，一朝选在君王侧。回眸一笑百媚生，六宫粉黛无颜色。春寒赐浴华清池，温泉水滑洗凝脂。侍儿扶起娇无力，始是新承恩泽时。云鬓花颜金步摇，芙蓉帐暖度春宵。春宵苦短日高起，从此君王不早朝。承欢侍宴无闲暇，春从春游夜专夜。后宫佳丽三千人，三千宠爱在一身。金屋妆成娇侍夜，玉楼宴罢醉和春。姊妹弟兄皆列土，可怜光彩生门户。遂令天下父母心，不重生男重生女。骊宫高处入青云，仙乐风飘处处闻。缓歌谩舞凝丝竹，尽日君王看不足。渔阳鼙鼓动地来，惊破霓裳羽衣曲。九重城阙烟尘生，千乘万骑西南行。翠华摇摇行复止，西出都门百余里。六军不发无奈何，宛转蛾眉马前死。花钿委地无人收，翠翘金雀玉搔头。君王掩面救不得，回看血泪相和流。黄埃散漫风萧索，云栈萦纡登剑阁。峨嵋山下少人行，旌旗无光日色薄。蜀江水碧蜀山青，圣主朝朝暮暮情。行宫见月伤心色，夜雨闻铃肠断声。天旋地转回龙驭，到此踌躇不能去。马嵬坡下泥土中，不见玉颜空死处。君臣相顾尽沾衣，东望都门信马归。\n 汉皇重色思倾国，御宇多年求不得。杨家有女初长成，养在深闺人未识。天生丽质难自弃，一朝选在君王侧。回眸一笑百媚生，六宫粉黛无颜色。春寒赐浴华清池，温泉水滑洗凝脂。侍儿扶起娇无力，始是新承恩泽时。云鬓花颜金步摇，芙蓉帐暖度春宵。春宵苦短日高起，从此君王不早朝。承欢侍宴无闲暇，春从春游夜专夜。后宫佳丽三千人，三千宠爱在一身。金屋妆成娇侍夜，玉楼宴罢醉和春。姊妹弟兄皆列土，可怜光彩生门户。遂令天下父母心，不重生男重生女。骊宫高处入青云，仙乐风飘处处闻。缓歌谩舞凝丝竹，尽日君王看不足。渔阳鼙鼓动地来，惊破霓裳羽衣曲。九重城阙烟尘生，千乘万骑西南行。翠华摇摇行复止，西出都门百余里。六军不发无奈何，宛转蛾眉马前死。花钿委地无人收，翠翘金雀玉搔头。君王掩面救不得，回看血泪相和流。黄埃散漫风萧索，云栈萦纡登剑阁。峨嵋山下少人行，旌旗无光日色薄。蜀江水碧蜀山青，圣主朝朝暮暮情。行宫见月伤心色，夜雨闻铃肠断声。天旋地转回龙驭，到此踌躇不能去。马嵬坡下泥土中，不见玉颜空死处。君臣相顾尽沾衣，东望都门信马归。";
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    [self.view addSubview:label];
}
- (void)loginButton {
    
    [self.loginVM loginVerification:^(BOOL success, NSDictionary * _Nonnull data) {
        if (success) {
            ListViewController *listVc = [[ListViewController alloc] init];
            [self.navigationController pushViewController:listVc animated:YES];
        }
    } failure:^(NSError * _Nonnull failure) {
        
    }];
}
- (void)clearButton {
    [self.loginVM clearModelUsername];
}
- (void)_textfieldHandle:(UITextField *)tf {
    [self.loginVM setModelUsername:tf.text];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[VastMagnifierTool sharedInstance] magnifier_touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[VastMagnifierTool sharedInstance] magnifier_touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[VastMagnifierTool sharedInstance] magnifier_touchesEnded:touches withEvent:event];
}

@end
