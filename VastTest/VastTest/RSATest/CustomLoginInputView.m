//
//  CustomLoginInputView.m
//  Initiative
//
//  Created by GoodSrc on 2018/5/16.
//  Copyright © 2018年 Mask. All rights reserved.
//

#import "CustomLoginInputView.h"
#define RedColor 0xE13E3F
#define DisableColor 0xDEDEDE
#define Disable_Bottom_Color 0xd9d9d9
#define Navi_Bar_Height (SCREEN_HEIGHT == 812 ? 88 : 64)
@implementation CustomLoginInputView
- (instancetype)getLoginPageTextFieldFrame:(CGRect)frame withLeftImageName:(NSString *)imageName withPlaceholder:(NSString *)placeholder callbackText:(CallbackText)callbackText {
    if (self == [super initWithFrame:frame]) {
        [self setTextFieldField:frame withLeftImageName:imageName withPlaceholder:placeholder];
        self.callbackText = callbackText;
    }
    return self;
}
- (void)setTextFieldField:(CGRect)frame withLeftImageName:(NSString *)imageName withPlaceholder:(NSString *)placeholder {
    _textField = [[UITextField alloc] initWithFrame:self.bounds];
    UIImageView *leftIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    leftIv.frame = CGRectMake(0, 0, 28, 28);
    _textField.leftView = leftIv;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *rightIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_clear_nor.pdf"]];
    rightIv.frame = CGRectMake(0, 0, 24, 24);
    rightIv.userInteractionEnabled = YES;
    _textField.rightView = rightIv;
    _textField.rightViewMode = UITextFieldViewModeAlways;
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    _textField.placeholder = placeholder;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickClearText)];
    [rightIv addGestureRecognizer:tap];
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.delegate = self;
    _textField.font = Font(16);
    _textField.textColor = UIColorFromRGBA(0x666666, 1.0);
    _textField.returnKeyType = UIReturnKeyDone;
    [self addSubview:_textField];
    
    _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1)];
    _bottomLine.backgroundColor = UIColorFromRGBA(Disable_Bottom_Color, 1.0);
    [self addSubview:_bottomLine];
}
- (void)clickClearText {
    _textField.text = @"";
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    _bottomLine.backgroundColor = UIColorFromRGBA(Disable_Bottom_Color, 0.5);
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _bottomLine.backgroundColor = UIColorFromRGBA(RedColor, 1.0);
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.callbackText) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.callbackText(textField.text);
        });
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end

@implementation KCustomSearchInputView
- (instancetype)getSearchPageTextFieldFrame:(CGRect)frame withPlaceholder:(NSString *)placeholder callbackText:(CallbackText)callbackText {
    if (self == [super initWithFrame:frame]) {
        [self setTextFieldField:frame withPlaceholder:placeholder];
        self.callbackText = callbackText;
    }
    return self;
}
- (void)setTextFieldField:(CGRect)frame withPlaceholder:(NSString *)placeholder {
    _textField = [[UITextField alloc] initWithFrame:self.bounds];
    UIImageView *rightIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_clear_nor.pdf"]];
    rightIv.frame = CGRectMake(0, 0, 24, 24);
    rightIv.userInteractionEnabled = YES;
    _textField.rightView = rightIv;
    _textField.rightViewMode = UITextFieldViewModeAlways;
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    _textField.placeholder = placeholder;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickClearText)];
    [rightIv addGestureRecognizer:tap];
    _textField.textAlignment = NSTextAlignmentLeft;
//     [_textField setValue:[UIFont systemFontOfSize:14]forKeyPath:@"_placeholderLabel.font"];//修改字体
    _textField.delegate = self;
    _textField.font = Font(14);
    _textField.textColor = UIColorFromRGBA(0x666666, 1.0);
    [self addSubview:_textField];
    
    _textField.layer.borderColor = UIColorFromRGBA(Disable_Bottom_Color, 0.5).CGColor;
    _textField.layer.borderWidth = 1;
}
- (void)clickClearText {
    _textField.text = @"";
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.layer.borderColor = UIColorFromRGBA(Disable_Bottom_Color, 0.5).CGColor;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.layer.borderColor = UIColorFromRGBA(RedColor, 1.0).CGColor;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.callbackText) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.callbackText(textField.text);
        });
    }
    return YES;
}
@end



@implementation KCustomSearchDateInputView
- (instancetype)getSearchPageTextFieldFrame:(CGRect)frame withPlaceholder:(NSString *)placeholder callbackText:(CallbackText)callbackText {
    if (self == [super initWithFrame:frame]) {
        
    }
    return self;
}

@end
