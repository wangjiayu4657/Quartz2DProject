//
//  DrawView.m
//  Quartz2D
//
//  Created by fangjs on 16/3/31.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "DrawView.h"

typedef NS_ENUM(NSInteger, SHAPE_IS) {
    SHAPE_IS_LINE,
    SHAPE_IS_TRIANGLE,
    SHAPE_IS_RECTANGULAR,
    SHAPE_IS_CURVED,
    SHAPE_IS_ROUND,
    SHAPE_IS_PAINTINGFAN,
    SHAPE_IS_DOWNLOADPROGRESS,
    SHAPE_IS_PIECHART,
    SHAPE_IS_PAINTEDYELLOWPEOPLE,
    SHAPE_IS_COUNT
};

@interface DrawView ()
{
    CGFloat centerX;
    CGFloat centerY;
}

@end


@implementation DrawView


- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    centerX = rect.size.width * 0.5;
    centerY = rect.size.height * 0.5;
    [self WhatShapeNeedToDraw:self.shape];
}

- (void) WhatShapeNeedToDraw: (NSInteger) shape {
    switch (shape) {
        case SHAPE_IS_LINE:{
            [self drawLine];
        }
            break;
        case SHAPE_IS_TRIANGLE: {
             [self drawTriangle];
        }
            break;
        case SHAPE_IS_RECTANGULAR:{
            [self drawRectangular];
        }
            break;
        case SHAPE_IS_ROUND: {
            [self drawRound];
        }
            break;
        case SHAPE_IS_CURVED: {
            [self drawCurved];
        }
            break;
        case SHAPE_IS_PAINTINGFAN:{
            [self drawPaintingFan];
        }
            break;
        case SHAPE_IS_DOWNLOADPROGRESS: {
            [self downloadProgress];
        }
            break;
        case SHAPE_IS_PAINTEDYELLOWPEOPLE:{
            [self drawPaintedYellowPeople];
        }
            break;
        default:
            break;
    }
}


#pragma mark - 画直线
- (void)drawLine{
    NSLog(@"画直线");
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, 50, 50);
    CGContextAddLineToPoint(context, 250, 250);
    
    CGContextMoveToPoint(context, 250, 50);
    CGContextAddLineToPoint(context, 50, 250);
    
    CGContextStrokePath(context);
}

#pragma mark - 画三角形
- (void)drawTriangle {
    NSLog(@"画三角形");
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //镂空
    CGContextMoveToPoint(context, 60, 50);
    CGContextAddLineToPoint(context, 160, 250);
    CGContextAddLineToPoint(context, 260, 50);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
     //填充
    CGContextMoveToPoint(context, 110, 60);
    CGContextAddLineToPoint(context, 160, 230);
    CGContextAddLineToPoint(context, 210, 60);
    CGContextClosePath(context);

    [[UIColor orangeColor] set];
    CGContextFillPath(context);
}

#pragma mark - 画矩形
- (void) drawRectangular {
    NSLog(@"画矩形");
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //镂空
    CGContextAddRect(context, CGRectMake(50, 50, 200, 200));
    CGContextStrokePath(context);
    
    //填充
    [[UIColor magentaColor] set];
    CGContextFillRect(context, CGRectMake(70, 70, 160, 160));
}

#pragma mark - 画弧
- (void) drawCurved {
    NSLog(@"画弧");
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 3.0f);
    CGContextAddArc(context, centerX, centerY, 150, -M_PI_4, -M_PI_4 * 3, 1);
    CGContextStrokePath(context);
}

#pragma mark - 画圆
- (void)drawRound {
    NSLog(@"画圆");
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(context, centerX, centerY, 150, 0, M_PI * 2, 0);
    CGContextStrokePath(context);

    [[UIColor purpleColor] set];
    CGContextAddArc(context, centerX, centerY, 100, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    
    //另一种画圆的方法
    [[UIColor yellowColor] set];
    CGContextAddEllipseInRect(context, CGRectMake(centerX - 50, centerY - 50, 100, 100));
    CGContextFillPath(context);
}

#pragma mark - 画扇形
- (void) drawPaintingFan {
    NSLog(@"画扇形");
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //镂空
    CGContextMoveToPoint(context, centerX, centerY);
    CGContextAddArc(context, centerX, centerY, 150, -M_PI_4, -M_PI_4 * 3, 1);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    //填充
    [[UIColor brownColor] set];
    CGContextMoveToPoint(context, centerX, centerY);
    CGContextAddArc(context, centerX, centerY, 100, -M_PI_4, -M_PI_4 * 3, 1);
    CGContextFillPath(context);
    
}


#pragma mark - download Progress
- (void) downloadProgress {
    NSLog(@"下载进度条");
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat endAngle = M_PI * 2 * self.progress - M_PI_4;
    CGContextAddArc(context, centerX, centerY, centerX - 3, -M_PI_4, endAngle, 0);

    NSString *text = [NSString stringWithFormat:@"%.2lf",self.progress];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:30],NSFontAttributeName, nil];
    [text drawInRect:CGRectMake(centerX - 40, centerY - 30, 80, 60) withAttributes:dic];
    
    CGContextStrokePath(context);
}

#pragma mark - 画饼状图
- (void)drawPieChart {
    NSLog(@"花饼状图");
    
}

#pragma mark - 画小黄人
- (void) drawPaintedYellowPeople {
   NSLog(@"画小黄人");
    
    CGFloat radius = 80;//半径
    CGFloat startX = centerX - radius;
    CGFloat startY = centerY - 60;
    CGFloat bodyH = 120;
    CGFloat bodyW = radius * 2;
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画头
    CGContextAddArc(context, centerX, startY, radius, 0, -M_PI, 1);
    [[UIColor yellowColor] set];
    CGContextFillPath(context);
    
    //画头发
    [[UIColor blackColor] set];
    CGContextMoveToPoint(context, centerX, startY - radius - 15);
    CGContextAddLineToPoint(context, centerX, startY - radius + 15);
    
    CGContextMoveToPoint(context, centerX - 15, startY - radius - 15);
    CGContextAddLineToPoint(context, centerX - 8, startY - radius + 15);
    
    CGContextMoveToPoint(context, centerX - 30, startY - radius - 15);
    CGContextAddLineToPoint(context, centerX - 20, startY - radius + 15);
    
    CGContextMoveToPoint(context, centerX + 15, startY - radius - 15);
    CGContextAddLineToPoint(context, centerX + 8, startY - radius + 15);
    
    CGContextMoveToPoint(context, centerX + 30, startY - radius - 15);
    CGContextAddLineToPoint(context, centerX + 20, startY - radius + 15);
    
    CGContextStrokePath(context);
    
    //画身体
    [[UIColor yellowColor] set];
    CGContextAddRect(context, CGRectMake(startX, startY, radius * 2, bodyH ));
    CGContextFillPath(context);
    
    //画底部
    CGContextAddArc(context, centerX, startY + bodyH - 1, radius, 0, M_PI, 0);
    CGContextFillPath(context);
    
    //画黑色矩形
    [[UIColor blackColor] set];
    CGContextAddRect(context, CGRectMake(startX - 5, startY, bodyW + 10, 30));
    CGContextFillPath(context);
    
    //画白色的圆
    [[UIColor whiteColor] set];
    CGContextAddArc(context, centerX - 30, startY + 15, 30, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    
    CGContextAddArc(context, centerX + 30, startY + 15, 30, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    
    //画黑色的圆
    [[UIColor blackColor] set];
    CGContextSetLineWidth(context, 10);
    CGContextAddArc(context, centerX - 30, startY + 15, 30, 0, M_PI * 2, 0);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 10);
    CGContextAddArc(context, centerX + 30, startY + 15, 30, 0, M_PI * 2, 0);
    CGContextStrokePath(context);
    
    //画眼睛
    [[UIColor colorWithRed:99/255.0 green:29/255.0 blue:10/255.0 alpha:1] set];
    CGContextAddArc(context, centerX - 25, startY + 15, 13, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    
    CGContextAddArc(context, centerX + 25, startY + 15, 13, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    
    //画黑眼睛
    [[UIColor blackColor] set];
    CGContextAddArc(context, centerX - 25, startY + 15, 6, 0, M_PI * 2, 0);
    CGContextFillPath(context);

    CGContextAddArc(context, centerX + 25, startY + 15, 6, 0, M_PI * 2, 0);
    CGContextFillPath(context);

    //画白眼睛
    [[UIColor whiteColor] set];
    CGContextAddArc(context, centerX - 25 - 3 , startY + 12 , 2, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    
    CGContextAddArc(context, centerX + 25 - 3 , startY + 12 , 2, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    
    //画嘴巴
    [[UIColor blackColor] set];
    CGContextSetLineWidth(context, 1);
    CGContextAddArc(context, centerX, startY + 50, 50, M_PI / 3, M_PI * 2 / 3, 0);
    CGContextStrokePath(context);
}

-(void)setProgress:(float)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

@end
