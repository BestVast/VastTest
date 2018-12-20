//
//  GpaletteView.m
//  Palette
//
//  Created by BestVast on 2018/12/18.
//  Copyright © 2018年 BestVast. All rights reserved.
//

#import "GpaletteView.h"

@implementation GpaletteView
{
    UIBezierPath   *bezierPath;
}
//https://www.jianshu.com/p/6130b51a0b71
//http://ios.jobbole.com/83323/
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        
        bezierPath = [UIBezierPath bezierPath];
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:self]; //返回触摸点在视图中的当前坐标
    [bezierPath moveToPoint:point];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:self]; //返回触摸点在视图中的当前坐标
    
    [bezierPath addLineToPoint:point];
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:self]; //返回触摸点在视图中的当前坐标
    [bezierPath addLineToPoint:point];
    [bezierPath closePath];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    bezierPath.lineWidth = 2;
    [[UIColor orangeColor] set];
    CGFloat length[] = {5, 5};
    [bezierPath setLineDash:length count:2 phase:0];
    
    [[UIColor colorWithRed:0.4 green:0.8 blue:0.6 alpha:0.4] setFill];
    [bezierPath fill];
    [bezierPath stroke];
}

//绘图只能在此方法中调用，否则无法得到当前图形上下文
-(void)drawRect1 {
    NSLog(@"1");
    //1.取得图形上下文对象
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2.创建路径对象
    CGMutablePathRef pathRef = CGPathCreateMutable();
    //3.添加路径到图形上下文
    CGContextAddPath(context, pathRef);
    //4.设置图形上下文状态属性
    CGContextSetRGBStrokeColor(context, 1.0, 1, 1, 1);//设置笔触颜色
    CGContextSetRGBFillColor(context, 0, 1.0, 0, 1);//设置填充色
    CGContextSetLineWidth(context, 5.0);//设置线条宽度
    CGContextSetLineCap(context, kCGLineCapRound);//设置顶点样式,（20,50）和（300,100）是顶点
    CGContextSetLineJoin(context, kCGLineJoinRound);//设置连接点样式，(20,100)是连接点
    /*设置线段样式
     phase:虚线开始的位置    lengths:虚线长度间隔（例如下面的定义说明第一条线段长度8，然后间隔3重新绘制8点的长度线段，当然这个数组可以定义更多元素）
     count:虚线数组元素个数
     */
    CGFloat lengths[2] = { 18, 18 };
    CGContextSetLineDash(context, 0, lengths, 2);
    /*设置阴影
     context:图形上下文
     offset:偏移量
     blur:模糊度
     color:阴影颜色
     */
    CGColorRef color = [UIColor blackColor].CGColor;//颜色转化，由于Quartz 2D跨平台，所以其中不能使用UIKit中的对象，但是UIkit提供了转化方法
    CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 0.8, color);
    
    //5.绘制图像到指定图形上下文
    /*CGPathDrawingMode是填充方式,枚举类型
     kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
     kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
     kCGPathStroke:只有边框
     kCGPathFillStroke：既有边框又有填充
     kCGPathEOFillStroke：奇偶填充并绘制边框
     */
    CGContextDrawPath(context, kCGPathEOFillStroke);//最后一个参数是填充类型
    //6.释放对象
    CGPathRelease(pathRef);
    CGContextRelease(context);
}

@end
