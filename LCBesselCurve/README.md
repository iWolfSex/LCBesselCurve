---
layout: post
title: 二次贝塞尔曲线
date: 2020-05-27
tag: iOS
---
### 圆盘扇形按钮实现思路

前段时间要写圆盘扇形等分类似转盘的，且点击每一个对应的弧形区域能响应不同的点击事件。如下图
![](/二次贝塞尔曲线/扇形圆盘.jpg)

点击不通的颜色响应不通的点击事件。

```
实现思路：就是画一个不规则的扇形按钮。让扇形部分能响应点击事件。扇形外不能点击。然后把圆均分成多个扇形按钮。不就实现了吗。

```

### CAShapeLayer 和 UIBezierPath

一 、CAShapeLayer介绍。网上找的

CAShapeLayer继承自CALayer，可使用CALayer的所有属性
CAShapeLayer需要和贝塞尔曲线配合使用才有意义。贝塞尔曲线可以为其提供形状，而单独使用CAShapeLayer是没有任何意义的。
使用CAShapeLayer与贝塞尔曲线可以实现不在view的DrawRect方法中画出一些想要的图形。用CGPath来定义想要绘制的图形，最后CAShapeLayer就自动渲染出来了。当然，也可以用Core Graphics直接向原始的CALyer的内容中绘制一个路径，相比之下，使用CAShapeLayer有以下一些优点：

1、染快速。CAShapeLayer使用了硬件加速，绘制同一图形会比用Core Graphics快很多。
2、高效使用内存。一个CAShapeLayer不需要像普通CALayer一样创建一个寄宿图形，所以无论有多大，都不会占用太多的内存。
3、不会被图层边界剪裁掉。一个CAShapeLayer可以在边界之外绘制。图层路径不会像在使用Core Graphics的普通CALayer一样被剪裁掉。
4、不会出现像素化。当把CAShapeLayer放大，或是用3D透视变换将其离相机更近时，它不像一个有寄宿图的普通图层一样变得像素化。

CAShapeLayer可以用来绘制所有能够通过CGPath来表示的形状。这个形状不一定要闭合，图层路径也不一定要不间断的，事实上可以在一个图层上绘制好几个不同的形状。

二、UIBezierPathjies。网上找的

UIBezierPath中文叫贝塞尔曲线，其作用是 UIBezierPath 类允许你在自定义的 View 中绘制和渲染由直线和曲线组成的路径. 你可以在初始化的时候, 直接为你的 UIBezierPath 指定一个几何图形. 路径可以是简单的几何图形例如: 矩形、椭圆、弧线之类的, 也可以是相对比较复杂的由直线和曲线组成的多边形. 当你定义完图形以后, 你可以使用额外的方法将你的路径直接绘制在当前的绘图上下文中.

### 二次贝塞尔曲线

一、二次贝塞尔曲线画弧形
二次贝塞尔曲线的概念自行百度。简单说一下要用二次贝塞尔曲线来绘制一个圆形。其实就是无数过与圆相切的的直线(即是和半径垂直和圆相交)。如果画曲线就是涉及到起点、锚点（又叫结束点）、控制点。如下图
![](/二次贝塞尔曲线/二次贝塞尔曲线.png)
起点即上图的p0
锚点即上图的p2
控制点即上图的P1

```
设P0、P02、P2是一条抛物线上顺序三个不同的点。过P0和P2点的两切线交于P1点

```
那么顶点P0、P1、P2三点就定义的一条二次Bezier曲线。找到这三个点就能绘制一条二次Bezier曲线。

### 结合二次贝塞尔曲线画弧形按钮

下图展示了画弧形按钮对应的点

![](/二次贝塞尔曲线/画弧形曲线.jpg)

图中x1, y1 对应了大圆的弧形所对应曲线的起点
图中x2, y2 对应了大圆的弧形所对应曲线的控制点
图中x3, y3 对于了大圆的弧形所对应曲线的锚点

图中x4, y4对应了小圆的弧形所对应曲线的起点
图中x5, y5 对应了小圆的弧形所对应曲线的控制点
图中x6, y6 对应了小圆的弧形所对应曲线的锚点

### 实现代码


```
//
//  BWPiechartButton.m
//  bwin
//
//  Created by iWolf on 2020/3/20.
//  Copyright © 2020 iWolf. All rights reserved.
//

#import "BWPiechartButton.h"
#include <math.h>
#define PI 3.1415926


@interface BWPiechartButton()

@property(nonatomic,strong)CAShapeLayer * drawLayer;
@property(nonatomic,strong)UIBezierPath * path;



@end


@implementation BWPiechartButton


-(instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)drawSectorLayerForIndex:(NSInteger)index{
       CGFloat outerRadius = self.frame.size.width/2;
       CGFloat innerRadius = 100;
       NSInteger count = 10;
       CGFloat angle = M_PI * 2 / count;
       CGFloat centerX = self.frame.size.width/2;
       CGFloat r1 = outerRadius / cos(angle / 2);
       CGFloat r2 = innerRadius / cos(angle / 2);
       for (int i = 0; i <= 10; i++) {
           if (index == i) {
               self.path = [UIBezierPath bezierPath]; // 创建路径
               self.drawLayer= [[CAShapeLayer alloc] init];
               CGFloat x1 = sin(i * angle) * outerRadius + centerX;
               CGFloat y1 = - cos(i * angle) * outerRadius + centerX;
               
               
               CGFloat x2 = sin(i * angle + angle / 2) * r1 + centerX;
               CGFloat y2 = - cos(i * angle + angle / 2) * r1 + centerX;
               
               
               CGFloat x3 = sin(i * angle + angle) * outerRadius + centerX;
               CGFloat y3 = - cos(i * angle + angle) * outerRadius + centerX;
               
               
               CGFloat x4 = sin(i * angle + angle) * innerRadius + centerX;
               CGFloat y4 = - cos(i * angle + angle) * innerRadius + centerX;
               
               
               
               CGFloat x5 = sin(i * angle + angle / 2) * r2 + centerX;
               CGFloat y5 = - cos(i * angle + angle / 2) * r2 + centerX;
               
               CGFloat x6 = sin(i * angle) * innerRadius + centerX;
               CGFloat y6 = - cos(i * angle) * innerRadius + centerX;

                [self.path moveToPoint:CGPointMake(x1, y1)];
                [self.path addQuadCurveToPoint:CGPointMake(x3, y3) controlPoint:CGPointMake(x2, y2)];
                [self.path addLineToPoint:CGPointMake(x4, y4)];
                [self.path addQuadCurveToPoint:CGPointMake(x6, y6) controlPoint:CGPointMake(x5, y5)];
                if (i%2 == 0) {
                    self.drawLayer.fillColor = [UIColor redColor].CGColor;
                   
                }else{
                    self.drawLayer.fillColor = [UIColor greenColor].CGColor;
                }
                [self.path closePath];//当构建子路径数>=2条时,可以调用`closePath`方法来闭合路径.
                [self.path stroke];
                self.drawLayer.path = self.path.CGPath;
                [self.layer addSublayer:self.drawLayer];
                [self setNeedsDisplay];
           }
       }
}



-(void)drawSectorLayerForBWPieBtnType:(BWPieBtnType)pieBtnType{
    if (self) {
        self.path = [UIBezierPath bezierPath]; // 创建路径
        self.drawLayer= [[CAShapeLayer alloc] init];
        
        CGFloat outerRadius = self.frame.size.width/2;
        CGFloat innerRadius = 99/2;
        
        CGFloat centerX = self.frame.size.width/2;
        CGFloat centerY = self.frame.size.width/2;
        if (pieBtnType== BW_PIEBTNTYPE_TOP) {
            [self.path moveToPoint:CGPointMake(outerRadius-innerRadius,outerRadius)];
            [self.path addLineToPoint:CGPointMake(self.frame.origin.x, outerRadius)];
            [self.path addArcWithCenter:CGPointMake(centerX,  centerY) radius:outerRadius startAngle:PI endAngle:2*PI clockwise:YES];
            [self.path addLineToPoint:CGPointMake(outerRadius+innerRadius, outerRadius)];
            [self.path addArcWithCenter:CGPointMake(centerX,  centerY) radius:innerRadius startAngle:2*PI endAngle:PI clockwise:NO];
           
        }else if (pieBtnType== BW_PIEBTNTYPE_BOTTOM) {
            
            [self.path moveToPoint:CGPointMake(outerRadius-innerRadius,outerRadius)];
            [self.path addLineToPoint:CGPointMake(self.frame.origin.x, outerRadius)];
            [self.path addArcWithCenter:CGPointMake(centerX,  centerY) radius:outerRadius startAngle: PI endAngle: 2*PI clockwise:NO];
            [self.path addLineToPoint:CGPointMake(outerRadius+innerRadius,outerRadius)];
            [self.path addArcWithCenter:CGPointMake(centerX,  centerY) radius:innerRadius startAngle:2*PI endAngle:PI clockwise:YES];

        }
          [self.path closePath];
          [self.path stroke];
          self.drawLayer.path = self.path.CGPath;
        if (pieBtnType== BW_PIEBTNTYPE_TOP) {
            self.drawLayer.fillColor =[UIColor yellowColor].CGColor;

        }else if (pieBtnType== BW_PIEBTNTYPE_BOTTOM) {
            self.drawLayer.fillColor =[UIColor blueColor].CGColor;
        }
          [self.layer addSublayer:self.drawLayer];

          [self setNeedsDisplay];


    }

}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if ([self.path containsPoint:point]) {
        return YES;
    }else{
        return NO;
    }

}

@end

```
<br>
转载请注明：[iWolf的博客](https://iwolfsex.github.io/) » [二次贝塞尔曲线](http://iWolf.com/2020/05/二次贝塞尔曲线/)  
