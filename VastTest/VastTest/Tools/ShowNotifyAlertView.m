//
//  ShowNotifyAlertView.m
//  KingDraw
//
//  Created by GoodSrc on 2018/8/27.
//  Copyright © 2018年 Mask. All rights reserved.
//

#import "ShowNotifyAlertView.h"
#import <WebKit/WebKit.h>
@interface ShowNotifyAlertView() <WKNavigationDelegate, UIScrollViewDelegate>
@end
@implementation ShowNotifyAlertView
{
    // 居中view 包含label，web等
    UIView *_middleView;
    // 标题 label
    UILabel *_titleLabel;
    // 详情 label - 暂不使用
    // UILabel *_detailLabel;
    // webview展示内容
    WKWebView *_showWeb;
    // 分割线
    UIView *_breakLine;
    // “我知道了”按钮
    UIButton *_knowButton;
}
#pragma mark ==UI布局==
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self uiConfig];
    }
    return self;
}
- (void)uiConfig {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickKnow)];
    [self addGestureRecognizer:tapGesture];
    //
    _middleView = [[UIView alloc] initWithFrame:CGRectMake(18, 312 / 2, SCREEN_WIDTH - 36, SCREEN_HEIGHT - 312)];
    _middleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_middleView];
    _middleView.layer.borderColor = UIColorFromRGBA(0xd9d9d9, 1.0).CGColor;
    _middleView.layer.borderWidth = 1;
    _middleView.layer.cornerRadius = 10;
    _middleView.layer.masksToBounds = YES;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, _middleView.frame.size.width, 32)];
    _titleLabel.font = Font(16);
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_middleView addSubview:_titleLabel];
    
    //创建网页配置对象
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 创建设置对象
//    WKPreferences *preference = [[WKPreferences alloc]init];
//    // 设置字体大小(最小的字体大小)
//    preference.minimumFontSize = 14;
//    // 设置偏好设置对象
//    config.preferences = preference;
    // 创建WKWebView
    _showWeb = [[WKWebView alloc] initWithFrame:CGRectMake(0, 44, _middleView.frame.size.width, _middleView.frame.size.height - 88) configuration:config];
    _showWeb.navigationDelegate = self;
    _showWeb.allowsLinkPreview = NO;
    _showWeb.scrollView.showsHorizontalScrollIndicator = NO;
    _showWeb.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _showWeb.allowsBackForwardNavigationGestures = YES;
    [_middleView addSubview:_showWeb];
    
    _breakLine = [[UIView alloc] initWithFrame:CGRectMake(0, _middleView.frame.size.height - 45, _middleView.frame.size.width, 1)];
    _breakLine.backgroundColor = UIColorFromRGBA(0xd9d9d9, 1.0);
    [_middleView addSubview:_breakLine];
    
    _knowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _knowButton.frame = CGRectMake(0, _middleView.frame.size.height - 44, _middleView.frame.size.width, 44);
    _knowButton.backgroundColor = [UIColor whiteColor];
    _knowButton.titleLabel.font = Font(16);
    [_knowButton setTitle:@"我知道了" forState:UIControlStateNormal];
    [_knowButton setTitleColor:UIColorFromRGBA(0xe13e3f, 1.0f) forState:UIControlStateNormal];
    [_knowButton addTarget:self action:@selector(clickKnow) forControlEvents:UIControlEventTouchUpInside];
    [_middleView addSubview:_knowButton];
}
#pragma mark ==点击“我知道了”按钮，回调==
- (void)clickKnow {
    [self callbackUrl:@""];
}
#pragma mark ==点击「按钮/打开网站」回调
- (void)callbackUrl:(NSString *)urlStr {
    [self removeFromSuperview];
    if (self.clickButtonCallback) {
        self.clickButtonCallback(urlStr);
    }
}
- (void)setDetails:(NSString *)details {
    _details = details;
    [_showWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:details]]];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}
- (void)setBtnText:(NSString *)btnText {
    [_knowButton setTitle:btnText forState:UIControlStateNormal];
}

#pragma mark ==WKNavigationDelegate==
#pragma mark ==动态设置 webview 高度
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.hidden = NO;
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        CGFloat documentHeight = [result doubleValue];
        DLog(@"%f", documentHeight);
        if (documentHeight > SCREEN_HEIGHT - 312 - 88) {
            documentHeight = SCREEN_HEIGHT - 312 - 88;
        }
        DLog(@"%f", documentHeight);
        CGRect middleFrame = self->_middleView.frame;
        if (documentHeight + 88 != middleFrame.size.height) {
            middleFrame.size.height = documentHeight + 88;
            middleFrame.origin.y = (SCREEN_HEIGHT - documentHeight - 88) / 2;
            self->_middleView.frame = middleFrame;
            
            CGRect webFrame = webView.frame;
            webFrame.size.height = documentHeight;
            webView.frame = webFrame;
            
            self->_breakLine.frame = CGRectMake(0, self->_middleView.frame.size.height - 45, self->_middleView.frame.size.width, 1);
            self->_knowButton.frame = CGRectMake(0, self->_middleView.frame.size.height - 44, self->_middleView.frame.size.width, 44);
        }
    }];
}
#pragma mark ==判断不允许加载web中url
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    DLog(@"%@", navigationAction.request.URL.absoluteString);
    if (![navigationAction.request.URL.absoluteString isEqualToString:_details]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        [self callbackUrl:navigationAction.request.URL.absoluteString];
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

@end
