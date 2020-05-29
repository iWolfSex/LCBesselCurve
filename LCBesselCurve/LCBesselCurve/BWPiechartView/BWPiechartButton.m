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
