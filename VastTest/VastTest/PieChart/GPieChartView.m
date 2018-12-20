//
//  GPieChartView.m
//  Palette
//
//  Created by GoodSrc on 2018/12/19.
//  Copyright © 2018 BestVast. All rights reserved.
//

#import "GPieChartView.h"

@implementation GPieChartView
{
    CAShapeLayer   *_maskLayer;
    NSMutableArray *_paths;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _paths = [[NSMutableArray alloc] init];
        [self uicConfig];
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (_paths && _paths.count > 0) {
        int num = -1;
        for (int i = 0; i < _paths.count; i++) {
            UIBezierPath *path = _paths[i];
            if ([path containsPoint:point]) {
                num = i;
                break;
            }
        }
        if (num >= 0) {
            NSLog(@"%@ 在第%d个区域", NSStringFromCGPoint(point), num);
        } else {
            NSLog(@"%@ 不在区域内", NSStringFromCGPoint(point));
            [self stroke];
        }
    }
}
- (void)uicConfig {
    
    [self stroke];
    [self setNeedsDisplay];
}

// https://www.jianshu.com/p/97570c6cafa0
// https://juejin.im/entry/5885f383128fe10065e9c2ba
- (void)stroke{
    //通过mask来控制显示区域
    _maskLayer = [CAShapeLayer layer];
    CGPoint _center = CGPointMake(150, 150);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithArcCenter:_center radius:130 startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
    //设置边框颜色为不透明，则可以通过边框的绘制来显示整个view
    _maskLayer.strokeColor = [UIColor greenColor].CGColor;
    _maskLayer.lineWidth = 260;
    //设置填充颜色为透明，可以通过设置半径来设置中心透明范围
    _maskLayer.fillColor = [UIColor clearColor].CGColor;
    _maskLayer.path = maskPath.CGPath;
    _maskLayer.strokeEnd = 0;
    self.layer.mask = _maskLayer;
    
    // 动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.f;
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat:1.f];
    //禁止还原
    animation.autoreverses = NO;
    //禁止完成即移除
    animation.removedOnCompletion = NO;
    //让动画保持在最后状态
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_maskLayer addAnimation:animation forKey:@"strokeEnd"];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSArray *arry = @[@300,@232.233,@324.324,@34,@4352,@43.0];
    //    计算数组中所有数值之和
    CGFloat sumValue = [[arry valueForKeyPath:@"@sum.floatValue"] floatValue];
    
    //设定圆弧的圆点、起始弧度
    CGPoint origin = CGPointMake(150, 150);
    CGFloat startAngle = 0;
    CGFloat endAngle = 0;
    
    for (NSInteger i = 0 ; i < arry.count; i++) {
        //        每个数据的弧度
        CGFloat angle = [arry[i] floatValue] * M_PI * 2 / sumValue;
        //        计算这一段弧度的结束为止
        endAngle = startAngle + angle;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:origin radius:130 startAngle:startAngle endAngle:endAngle clockwise:YES];
        //        计算下一段弧度开始的位置
        startAngle = endAngle;
        //        从弧边，绘制到原点。用于封闭路径，可以绘制扇形
        [path addLineToPoint:origin];
        //        给扇形添加随机色
        [[self randomUIColor] set];
        [path fill];
        
        [_paths addObject:path];
    }
}

- (UIColor *)randomUIColor{
    UIColor *color = [UIColor colorWithRed:(arc4random_uniform(256) / 255.0) green:(arc4random_uniform(256) / 255.0) blue:(arc4random_uniform(256) / 255.0) alpha:(arc4random_uniform(256) / 255.0)];
    return color;
}



//- (void)uicConfig {
//    NSArray *datas = @[@(90), @(90), @(90), @(90)];
//    NSArray *colors = @[[UIColor redColor],
//                        [UIColor yellowColor],
//                        [UIColor blueColor],
//                        [UIColor greenColor]];
//    [self setDatas:datas colors:colors];
//    [self setNeedsDisplay];
//}
//
//- (void)setDatas:(NSArray <NSNumber *>*)datas
//          colors:(NSArray <UIColor *>*)colors{
//    NSArray *newDatas = datas;//[self getPersentArraysWithDataArray:datas];
//    CGFloat start = 0.f;
//    CGFloat end = 0.f;
//    CGPoint _center = CGPointMake(180, 240);
//    CGFloat _radius = 50;
//    CGFloat Hollow_Circle_Radius = 0;
//    UIColor *kPieRandColor = [UIColor redColor];
//
//    for (int i = 0; i < newDatas.count; i ++) {
//        NSNumber *number = newDatas[i];
//        end =  start + number.floatValue;
//        UIBezierPath *piePath = [UIBezierPath bezierPathWithArcCenter:_center radius:_radius + Hollow_Circle_Radius startAngle:start endAngle:end clockwise:YES];
//        CAShapeLayer *pieLayer = [CAShapeLayer layer];
//        pieLayer.strokeStart = start;
//        pieLayer.strokeEnd = end;
//        pieLayer.lineWidth = _radius*2 - Hollow_Circle_Radius;
//        pieLayer.strokeColor = [colors[i] CGColor];
//        pieLayer.fillColor = [UIColor clearColor].CGColor;
//        pieLayer.path = piePath.CGPath;
//
//        [self.layer addSublayer:pieLayer];
//        start = end;
//    }
//}
// https://www.jianshu.com/p/97570c6cafa0
@end
