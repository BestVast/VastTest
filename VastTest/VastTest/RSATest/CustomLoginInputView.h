//
//  CustomLoginInputView.h
//  Initiative
//
//  Created by GoodSrc on 2018/5/16.
//  Copyright © 2018年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>
//登录页面 输入框
typedef void (^CallbackText) (NSString *tfString);
@interface CustomLoginInputView : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, copy) CallbackText callbackText;

- (instancetype)getLoginPageTextFieldFrame:(CGRect)frame withLeftImageName:(NSString *)imageName withPlaceholder:(NSString *)placeholder callbackText:(CallbackText)callbackText;
@end

@interface KCustomSearchInputView: UIView <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) CallbackText callbackText;

- (instancetype)getSearchPageTextFieldFrame:(CGRect)frame withPlaceholder:(NSString *)placeholder callbackText:(CallbackText)callbackText;
@end


@interface KCustomSearchDateInputView: UIView
- (instancetype)getSearchPageTextFieldFrame:(CGRect)frame withPlaceholder:(NSString *)placeholder callbackText:(CallbackText)callbackText;

@end
