//
//  ShareViewController.m
//  VastTest
//
//  Created by GoodSrc on 2018/12/28.
//  Copyright © 2018 GoodSrc. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()
// 分享文本 按钮
@property (nonatomic, strong) UIButton *shareTextBtn;
// 分享图片 按钮
@property (nonatomic, strong) UIButton *shareImgBtn;
// 分享文件 按钮
@property (nonatomic, strong) UIButton *shareFileBtn;
@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self uiConfig];
}

- (void)uiConfig {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.shareTextBtn];
    [self.view addSubview:self.shareImgBtn];
    [self.shareImgBtn addTarget:self action:@selector(clickShareImg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shareFileBtn];
}
- (void)clickShareImg {
    UIImage *shareImage = [UIImage imageNamed:@"MVC1.png"];
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *imagePath = [docPath stringByAppendingString:[NSString stringWithFormat:@"shareImg.jpg"]];
    //把图片写进缓存，一定要先写入本地，不然会分享出错
    [UIImageJPEGRepresentation(shareImage, 1.0) writeToFile:imagePath atomically:YES];
    //把缓存图片的地址转成NSUrl格式
    NSURL *shareUrl = [NSURL fileURLWithPath:imagePath];
    //这个部分是自定义ActivitySource
    UIImage *shareImage1 = [UIImage imageWithData:UIImageJPEGRepresentation(shareImage, 0.1)];

    NSArray*activityItems = @[shareImage1,];
    [self shareData:activityItems];
}
- (void)shareData:(NSArray *)datas {
    if (!(datas && datas.count > 0)) {
        return;
    }
    //可以自定义
    UIActivity *activity = [[UIActivity alloc]init];
//    NSArray *activities =@[activity];
    UIActivityViewController*activityVC = [[UIActivityViewController alloc] initWithActivityItems:datas applicationActivities:nil];
    __weak typeof(activity) weakActivity = activity;
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0){
        //初始化回调方法
        UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(NSString *activityType,BOOL completed,NSArray *returnedItems,NSError *activityError) {
            
            DLog(@"activityType :%@", activityType);
            //分享结束需要调用
            [weakActivity activityDidFinish:YES];
            if(completed) {
                DLog(@"completed");
            }else{
                DLog(@"cancel");
            }
        };
        activityVC.completionWithItemsHandler = myBlock;
    }
    if(activityVC) {
        [self presentViewController:activityVC animated:YES completion:nil];
    }
}
- (void)clickShareFile {
    //获取Document路径
    NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //txt文件生成路径
    NSString *docPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"WChatlog.txt"];
    //生成txt文件
    NSString *log = @"1234567890";
    NSError *error;
    [log writeToFile:docPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        return;
    }
    //获取路径文件url
    NSURL*logUrl = [NSURL fileURLWithPath:docPath];
    
    NSArray*activityItems = @[logUrl];
    [self shareData:activityItems];
}
- (void)clickShareText {
    NSString *shareText = @"shareText123456787654321";
    NSArray *activityItems = @[shareText];
    [self shareData:activityItems];
}
- (UIButton *)shareTextBtn {
    if (_shareTextBtn == nil) {
        _shareTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareTextBtn.frame = CGRectMake(20, 100, SCREEN_WIDTH - 40, 45);
        _shareTextBtn.backgroundColor = [UIColor cyanColor];
        [_shareTextBtn setTitle:@"分享文本" forState:UIControlStateNormal];
        [_shareTextBtn addTarget:self action:@selector(clickShareText) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareTextBtn;
}
- (UIButton *)shareImgBtn {
    if (_shareImgBtn == nil) {
        _shareImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareImgBtn.frame = CGRectMake(20, 160, SCREEN_WIDTH - 40, 45);
        _shareImgBtn.backgroundColor = [UIColor cyanColor];
        [_shareImgBtn setTitle:@"分享图片" forState:UIControlStateNormal];
//        [_shareImgBtn addTarget:self action:@selector(clickShareImg) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareImgBtn;
}
- (UIButton *)shareFileBtn {
    if (_shareFileBtn == nil) {
        _shareFileBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareFileBtn.frame = CGRectMake(20, 220, SCREEN_WIDTH - 40, 45);
        _shareFileBtn.backgroundColor = [UIColor cyanColor];
        [_shareFileBtn setTitle:@"分享文件" forState:UIControlStateNormal];
        [_shareFileBtn addTarget:self action:@selector(clickShareFile) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareFileBtn;
}
@end
