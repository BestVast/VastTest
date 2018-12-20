//
//  GMagnifierTool.m
//  VastTest
//
//  Created by GoodSrc on 2018/10/25.
//  Copyright © 2018年 GoodSrc. All rights reserved.
//

#import "GMagnifierTool.h"
#import "GKDDefine.h"
#import "GPaletteUtil.h"
#import "GPaletteManager.h"
#import "GCPoint.h"
#import "GShape.h"
#import "GNode.h"
#import "GText.h"
#import "GCBond.h"
#import "UITouch+GKDTouch.h"
#define MagniKeyWindow     [UIApplication sharedApplication].keyWindow

@interface GMagnifierTool()
/* 放大镜 */
@property (nonatomic, strong) UIImageView *cutImageView;
/* 全屏的截图 */
@property (nonatomic, strong) UIImage *cutScreenImage;

@end
@implementation GMagnifierTool

+ (instancetype)sharedInstance {
    static GMagnifierTool *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[GMagnifierTool alloc] init];
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
    self.magnStyle       = MagnifierStyle_Square;
    self.magnifierWidth  = Screen_Width / 4;
    self.magnifierHeight = Screen_Height / 4;
    self.magnifyMultiple = 1;
    self.magnShowDirection = MagnifierDirection_LeftTop;
    self.imageCutLocation  = MagnifierDirection_Center;
}

- (void)magnifier_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
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
    @autoreleasepool {
        UITouch *touch = [touches anyObject];
        GCPoint *point = [touch gLocationInView:[GPaletteManager getInstance].palette];
        self.cutScreenImage =[self drawMagnifierImage:point];//[GPaletteUtil savePaletteElementsToImage];
//        CGRect rect = [self getMagnifierShowImageRect:point];
//        UIImage *image = [self vastImageFromImage:self.cutScreenImage inRect:rect];
        self.cutImageView.image = self.cutScreenImage;
        
    }
    
    //    // 放大镜跟随触点移动
    //    CGPoint center = [self getMagnifierShowViewPoint:point];
    //    self.cutImageView.center = center;
}

- (UIImage *)drawMagnifierImage:(GCPoint *)point{
    
    CGFloat centerX=self.magnifierWidth/2;
    CGFloat centerY=self.magnifierHeight/2;
    
    CGRect selfBound=CGRectMake(point.x-centerX, point.y-centerY, point.x+centerX, point.y+centerY);
    
    
    NSArray *elements=[GPaletteManager getInstance].palette.elements;
    NSMutableArray *newElements=[NSMutableArray array];
    for (GElement *ele in elements) {
        if ([self isInArea:ele.getBound inRect:selfBound]) {
            [newElements addObject:ele];
        }
    };
    
    
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.magnifierWidth, self.magnifierHeight),NO,0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, TRUE);
    CGContextSetShouldAntialias(context, true);
    CGContextTranslateCTM(context, centerX-point.x, centerY-point.y);
    for (int i=(int)newElements.count-1; i>=0; i--) {
        GElement *ele=newElements[i];
        if (ele.selectState!=RELEASE || ele.gestureState!=TouchUp) {
            [ele drawWithSeletState:context];
        }
    }
    
    for (int i=(int)newElements.count-1; i>=0; i--) {
        GElement *ele=newElements[i];
        [ele draw:context];
    }
    GBaseTool *baseTool=[GPaletteManager getInstance].palette.baseTool;
    if (baseTool.selectState!=RELEASE || baseTool.gestureState!=TouchUp) {
        [baseTool drawWithSeletState:context];
    }
    [baseTool draw:context];
    
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return im;
    
}

- (BOOL)isInArea:(CGRect )bound inRect:(CGRect)rect{
    if ([self isRectInRect:bound inRect:rect] || [self isRectInRect:rect inRect:bound]) {
        return true;
    }
    return false;
}

- (BOOL)isRectInRect:(CGRect)bound inRect:(CGRect)rect{
    /*
     首先取四个点
     */
    CGPoint p1=CGPointMake(bound.origin.x, bound.origin.y);
    CGPoint p2=CGPointMake(bound.origin.x, bound.size.height);
    CGPoint p3=CGPointMake(bound.size.width, bound.size.height);
    CGPoint p4=CGPointMake(bound.size.width, bound.origin.y);
    if (p1.x>=rect.origin.x && p1.x<=rect.size.width && p1.y>=rect.origin.y && p1.y<=rect.size.height) {
        return true;
    }else if (p2.x>=rect.origin.x && p2.x<=rect.size.width && p2.y>=rect.origin.y && p2.y<=rect.size.height){
        return true;
    }else if (p3.x>=rect.origin.x && p3.x<=rect.size.width && p3.y>=rect.origin.y && p3.y<=rect.size.height){
        return true;
    }else if (p4.x>=rect.origin.x && p4.x<=rect.size.width && p4.y>=rect.origin.y && p4.y<=rect.size.height){
        return true;
    }
    return false;
}

#pragma mark ==获取 放大镜中心位置==
- (CGPoint)getMagnifierShowViewPoint:(CGPoint)point {
    CGPoint magnCenter;
    MagnifierDirection magnDirection = self.magnShowDirection;
    if (point.x < self.magnifierWidth / 2
        && point.y < self.magnifierHeight / 2) {
        magnDirection = MagnifierDirection_RightBottom;
    } else if (point.x + self.magnifierWidth / 2 > Screen_Width
               && point.y < self.magnifierHeight / 2) {
        magnDirection = MagnifierDirection_LeftBottom;
    } else if (point.x < self.magnifierWidth / 2
               && point.y + self.magnifierHeight / 2 > Screen_Height) {
        magnDirection = MagnifierDirection_RightTop;
    } else if (point.x + self.magnifierWidth / 2 > Screen_Width
               && point.y + self.magnifierHeight / 2 > Screen_Height) {
        magnDirection = MagnifierDirection_LeftTop;
    } else if (point.x < self.magnifierWidth / 2) {
        magnDirection = MagnifierDirection_RightTop;
    } else if (point.x + self.magnifierWidth / 2 > Screen_Width) {
        magnDirection = MagnifierDirection_LeftTop;
    } else if (point.y < self.magnifierHeight / 2) {
        magnDirection = MagnifierDirection_LeftBottom;
    } else if (point.y + self.magnifierHeight / 2 > Screen_Height) {
        magnDirection = MagnifierDirection_LeftTop;
    }
    switch (magnDirection) {
        case MagnifierDirection_Center:
            magnCenter = point;
            break;
        case MagnifierDirection_LeftTop:
            magnCenter = CGPointMake(point.x - self.magnifierWidth / 2, point.y - self.magnifierHeight / 2);
            break;
        case MagnifierDirection_Top:
            magnCenter = CGPointMake(point.x, point.y - self.magnifierHeight / 2);
            break;
        case MagnifierDirection_RightTop:
            magnCenter = CGPointMake(point.x + self.magnifierWidth / 2, point.y - self.magnifierHeight / 2);
            break;
        case MagnifierDirection_Right:
            magnCenter = CGPointMake(point.x + self.magnifierWidth / 2, point.y);
            break;
        case MagnifierDirection_RightBottom:
            magnCenter = CGPointMake(point.x + self.magnifierWidth / 2, point.y + self.magnifierWidth / 2);
            break;
        case MagnifierDirection_Bottom:
            magnCenter = CGPointMake(point.x, point.y + self.magnifierHeight / 2);
            break;
        case MagnifierDirection_LeftBottom:
            magnCenter = CGPointMake(point.x - self.magnifierWidth / 2, point.y + self.magnifierHeight / 2);
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
            pointY = point.y - self.magnifierHeight / self.magnifyMultiple / 2;
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
            pointY = point.y - self.magnifierHeight / self.magnifyMultiple / 2;
        }
            break;
        case MagnifierDirection_RightBottom:{
            pointX = point.x - self.magnifierWidth / self.magnifyMultiple;
            pointY = point.y - self.magnifierHeight / self.magnifyMultiple;
        }
            break;
        case MagnifierDirection_Bottom:{
            pointX = point.x - self.magnifierWidth / self.magnifyMultiple / 2;
            pointY = point.y - self.magnifierHeight / self.magnifyMultiple;
        }
            break;
        case MagnifierDirection_LeftBottom:{
            pointX = point.x;
            pointY = point.y - self.magnifierHeight / self.magnifyMultiple;
        }
            break;
        case MagnifierDirection_Left:{
            pointX = point.x;
            pointY = point.y - self.magnifierHeight / self.magnifyMultiple / 2;
        }
            break;
        default: {
            pointX = point.x - self.magnifierWidth / self.magnifyMultiple / 2;
            pointY = point.y - self.magnifierHeight / self.magnifyMultiple / 2;
        }
            break;
    }
    CGRect rect = CGRectMake(pointX, pointY, self.magnifierWidth / self.magnifyMultiple, self.magnifierHeight / self.magnifyMultiple);
    return rect;
}

- (UIImage *)vastImageFromImage:(UIImage *)image inRect:(CGRect)rect {
    // 把像素rect 转化为 点rect (如无转化则按原图像素取部分图片)
//    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x = rect.origin.x,
    y = rect.origin.y,
    w = rect.size.width,
    h = rect.size.height;
    CGRect dianRect = CGRectMake(x, y, w, h);
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    CGImageRelease(newImageRef);
    return newImage;
}

#pragma mark ==Set  Get==
- (void)setMagnifierWidth:(float)magnifierWidth {
    _magnifierWidth = magnifierWidth;
//    NSInteger image_X = [self getViewOriginX];
//    _cutImageView.frame = CGRectMake(image_X, 0, magnifierWidth, magnifierWidth);
//    _cutImageView.layer.cornerRadius = magnifierWidth / 2;
}
- (void)setMagnifierHeight:(float)magnifierHeight {
    _magnifierHeight = magnifierHeight;
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
        NSInteger image_X = [self getViewOriginX];
        _cutImageView = [[UIImageView alloc] initWithFrame:CGRectMake(image_X, 44, self.magnifierWidth / self.magnifyMultiple, self.magnifierHeight / self.magnifyMultiple)];
        if (self.magnStyle == MagnifierStyle_Circle) {
            _cutImageView.layer.masksToBounds = YES;
            _cutImageView.layer.cornerRadius = self.magnifierWidth/2;
        }
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_cutImageView.bounds];
        _cutImageView.layer.masksToBounds = NO;
        _cutImageView.layer.backgroundColor=[UIColor whiteColor].CGColor;
        _cutImageView.layer.shadowColor = [UIColor grayColor].CGColor;
        _cutImageView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
        _cutImageView.layer.shadowOpacity = 0.5f;
        _cutImageView.layer.shadowPath = shadowPath.CGPath;
    }
    return _cutImageView;
}

#pragma mark ==获取放大镜x轴坐标==
- (NSInteger)getViewOriginX {
    NSInteger image_X = 44;
    if (IS_IPHONEX) {
        image_X += 35;
    }
    return image_X;
}


#pragma mark  ==截图==
/**
 针对有用过OpenGL渲染过的视图截图
 
 @return 截取的图片
 */
- (UIImage *)openglSnapshotImage:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/**
 普通的截图
 该API仅可以在未使用layer和OpenGL渲染的视图上使用
 
 @return 截取的图片
 */
- (UIImage *)nomalSnapshotImage:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}
/**
 截图
 以UIView 的形式返回(_UIReplicantView)
 
 @return 截取出来的图片转换的视图
 */
- (UIView *)snapshotView {
    UIView *snapView = [MagniKeyWindow snapshotViewAfterScreenUpdates:YES];
    return snapView;
}
@end
