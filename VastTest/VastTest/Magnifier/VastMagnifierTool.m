//
//  VastMagnifierTool.m
//  VastTest
//
//  Created by GoodSrc on 2018/10/25.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "VastMagnifierTool.h"
#define MagniKeyWindow     [UIApplication sharedApplication].keyWindow

@interface VastMagnifierTool()
/* 放大镜 */
@property (nonatomic, strong) UIImageView *cutImageView;
/* 全屏的截图 */
@property (nonatomic, strong) UIImage *cutScreenImage;
@end
@implementation VastMagnifierTool

+ (instancetype)sharedInstance {
    static VastMagnifierTool *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[VastMagnifierTool alloc] init];
    });
    return _instance;
}
- (instancetype)init {
    if (self = [super init]) {
        [self setParameter];
    }
    return self;
}
- (void)setParameter {
    self.magnStyle       = MagnifierStyle_Circle;
    self.magnifierWidth  = 90;
    self.magnifyMultiple = 1.5;
    self.magnShowDirection = MagnifierDirection_Center;
    self.imageCutLocation  = MagnifierDirection_Center;
}

- (void)magnifier_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.cutScreenImage = [self vastSnapshot:MagniKeyWindow];
    [self handleMagnifierImage:touches];
    [MagniKeyWindow addSubview:self.cutImageView];
}
- (void)magnifier_touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self handleMagnifierImage:touches];
}
- (void)magnifier_touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.cutImageView removeFromSuperview];
}
#pragma mark ==设置 放大镜展示位置，展示的图片==
- (void)handleMagnifierImage:(NSSet<UITouch *> *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:MagniKeyWindow];
    CGPoint center = [self getMagnifierShowViewPoint:point];
    self.cutImageView.center = center;
    CGRect rect = [self getMagnifierShowImageRect:point];
    UIImage *image = [self vastImageFromImage:self.cutScreenImage inRect:rect];
    self.cutImageView.image = image;
}
#pragma mark ==获取 放大镜中心位置==
- (CGPoint)getMagnifierShowViewPoint:(CGPoint)point {
    CGPoint magnCenter;
    MagnifierDirection magnDirection = self.magnShowDirection;
    if (point.x < self.magnifierWidth / 2
        && point.y < self.magnifierWidth / 2) {
        magnDirection = MagnifierDirection_RightBottom;
    } else if (point.x + self.magnifierWidth / 2 > SCREEN_WIDTH
               && point.y < self.magnifierWidth / 2) {
        magnDirection = MagnifierDirection_LeftBottom;
    } else if (point.x < self.magnifierWidth / 2
               && point.y + self.magnifierWidth / 2 > SCREEN_HEIGHT) {
        magnDirection = MagnifierDirection_RightTop;
    } else if (point.x + self.magnifierWidth / 2 > SCREEN_WIDTH
               && point.y + self.magnifierWidth / 2 > SCREEN_HEIGHT) {
        magnDirection = MagnifierDirection_LeftTop;
    } else if (point.x < self.magnifierWidth / 2) {
        magnDirection = MagnifierDirection_RightTop;
    } else if (point.x + self.magnifierWidth / 2 > SCREEN_WIDTH) {
        magnDirection = MagnifierDirection_LeftTop;
    } else if (point.y < self.magnifierWidth / 2) {
        magnDirection = MagnifierDirection_LeftBottom;
    } else if (point.y + self.magnifierWidth / 2 > SCREEN_HEIGHT) {
        magnDirection = MagnifierDirection_LeftTop;
    }
    switch (magnDirection) {
        case MagnifierDirection_Center:
            magnCenter = point;
            break;
        case MagnifierDirection_LeftTop:
            magnCenter = CGPointMake(point.x - self.magnifierWidth / 2, point.y - self.magnifierWidth / 2);
            break;
        case MagnifierDirection_Top:
            magnCenter = CGPointMake(point.x, point.y - self.magnifierWidth / 2);
            break;
        case MagnifierDirection_RightTop:
            magnCenter = CGPointMake(point.x + self.magnifierWidth / 2, point.y - self.magnifierWidth / 2);
            break;
        case MagnifierDirection_Right:
            magnCenter = CGPointMake(point.x + self.magnifierWidth / 2, point.y);
            break;
        case MagnifierDirection_RightBottom:
            magnCenter = CGPointMake(point.x + self.magnifierWidth / 2, point.y + self.magnifierWidth / 2);
            break;
        case MagnifierDirection_Bottom:
            magnCenter = CGPointMake(point.x, point.y + self.magnifierWidth / 2);
            break;
        case MagnifierDirection_LeftBottom:
            magnCenter = CGPointMake(point.x - self.magnifierWidth / 2, point.y + self.magnifierWidth / 2);
            break;
        case MagnifierDirection_Left:
            magnCenter = CGPointMake(point.x - self.magnifierWidth / 2, point.y);
            break;
        default:
            magnCenter = point;
            break;
    }
    return magnCenter;
}
#pragma mark ==获取 放大镜截取de图片范围==
- (CGRect)getMagnifierShowImageRect:(CGPoint)point {
    CGFloat pointX = 0, pointY = 0;
    switch (self.imageCutLocation) {
        case MagnifierDirection_Center:{
            pointX = point.x - self.magnifierWidth / self.magnifyMultiple / 2;
            pointY = point.y - self.magnifierWidth / self.magnifyMultiple / 2;
        }
            break;
        case MagnifierDirection_LeftTop:{
            pointX = point.x;
            pointY = point.y;
        }
            break;
        case MagnifierDirection_Top:{
            pointX = point.x - self.magnifierWidth / self.magnifyMultiple / 2;
            pointY = point.y;
        }
            break;
        case MagnifierDirection_RightTop:{
            pointX = point.x - self.magnifierWidth / self.magnifyMultiple;
            pointY = point.y;
        }
            break;
        case MagnifierDirection_Right:{
            pointX = point.x - self.magnifierWidth / self.magnifyMultiple;
            pointY = point.y - self.magnifierWidth / self.magnifyMultiple / 2;
        }
            break;
        case MagnifierDirection_RightBottom:{
            pointX = point.x - self.magnifierWidth / self.magnifyMultiple;
            pointY = point.y - self.magnifierWidth / self.magnifyMultiple;
        }
            break;
        case MagnifierDirection_Bottom:{
            pointX = point.x - self.magnifierWidth / self.magnifyMultiple / 2;
            pointY = point.y - self.magnifierWidth / self.magnifyMultiple;
        }
            break;
        case MagnifierDirection_LeftBottom:{
            pointX = point.x;
            pointY = point.y - self.magnifierWidth / self.magnifyMultiple;
        }
            break;
        case MagnifierDirection_Left:{
            pointX = point.x;
            pointY = point.y - self.magnifierWidth / self.magnifyMultiple / 2;
        }
            break;
        default: {
            pointX = point.x - self.magnifierWidth / self.magnifyMultiple / 2;
            pointY = point.y - self.magnifierWidth / self.magnifyMultiple / 2;
        }
            break;
    }
    CGRect rect = CGRectMake(pointX, pointY, self.magnifierWidth / self.magnifyMultiple, self.magnifierWidth / self.magnifyMultiple);
    return rect;
}
#pragma mark  ==截图==
- (UIImage *)vastSnapshot:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)vastImageFromImage:(UIImage *)image inRect:(CGRect)rect {
    // 把像素rect 转化为 点rect (如无转化则按原图像素取部分图片)
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x = rect.origin.x * scale,
    y = rect.origin.y * scale,
    w = rect.size.width * scale,
    h = rect.size.height * scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
}

#pragma mark ==Set  Get==
- (void)setMagnifierWidth:(float)magnifierWidth {
    _magnifierWidth = magnifierWidth;
    _cutImageView.frame = CGRectMake(0, 0, magnifierWidth, magnifierWidth);
    _cutImageView.layer.cornerRadius = magnifierWidth / 2;
}
- (void)setMagnifyMultiple:(float)magnifyMultiple {
    if (magnifyMultiple < 1) return;
    _magnifyMultiple = magnifyMultiple;
}
- (void)setMagnStyle:(MagnifierStyle)magnStyle {
    _magnStyle = magnStyle;
}
- (void)setMagnBackImg:(UIImage *)magnBackImg {
    _magnBackImg = magnBackImg;
    _cutImageView.image = magnBackImg;
}
- (void)setMagnShowDirection:(MagnifierDirection)magnShowDirection {
    _magnShowDirection = magnShowDirection;
}
- (void)setImageCutLocation:(MagnifierDirection)imageCutLocation {
    _imageCutLocation = imageCutLocation;
}
- (UIImageView *)cutImageView {
    if (!_cutImageView) {
        _cutImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.magnifierWidth, self.magnifierWidth)];
        _cutImageView.layer.masksToBounds = YES;
        _cutImageView.layer.borderColor = [[UIColor grayColor] CGColor];
        _cutImageView.layer.borderWidth = 1;
        _cutImageView.layer.cornerRadius = self.magnifierWidth/2;
    }
    return _cutImageView;
}
@end
