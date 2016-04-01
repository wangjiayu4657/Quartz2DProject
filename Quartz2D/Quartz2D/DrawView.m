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
    SHAPE_IS_ELLIPSE,
    SHAPE_IS_PAINTINGFAN,
    SHAPE_IS_DOWNLOADPROGRESS,
    SHAPE_IS_HISTOGRAM,
    SHAPE_IS_PIECHART,
    SHAPE_IS_PAINTEDYELLOWPEOPLE,
    SHAPE_IS_DOWNSNOWY,
    SHAPE_IS_COUNT
};

@interface DrawView ()
{
    CGFloat centerX;
    CGFloat centerY;
}

- (void) WhatShapeNeedToDraw: (NSInteger) shape ;
- (void) drawLine;
- (void) drawTriangle;
- (void) drawRectangular;
- (void) drawCurved;
- (void) drawRound;
- (void) drawEllipse;
- (void) drawPaintingFan;
- (void) downloadProgress;
- (void) drawPieChart;
- (void) drawPaintedYellowPeople;

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
        } break;
        
        case SHAPE_IS_TRIANGLE: {
             [self drawTriangle];
        } break;
            
        case SHAPE_IS_RECTANGULAR:{
            [self drawRectangular];
        } break;
           
        case SHAPE_IS_ROUND: {
            [self drawRound];
        } break;
            
        case SHAPE_IS_ELLIPSE: {
            [self drawEllipse];
        } break;
            
        case SHAPE_IS_CURVED: {
            [self drawCurved];
        } break;
           
        case SHAPE_IS_PAINTINGFAN:{
            [self drawPaintingFan];
        } break;
          
        case SHAPE_IS_DOWNLOADPROGRESS: {
            [self downloadProgress];
        } break;
           
        case SHAPE_IS_HISTOGRAM: {
            [self drawHistogram];
        } break;
           
        case SHAPE_IS_PIECHART: {
            [self drawPieChart];
        } break;
           
        case SHAPE_IS_PAINTEDYELLOWPEOPLE:{
            [self drawPaintedYellowPeople];
        } break;
        case SHAPE_IS_DOWNSNOWY:{
            [self snowAnimation];
        } break;
        default:
            break;
    }
}


#pragma mark - 画直线
- (void)drawLine {
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

#pragma mark - 画椭圆
- (void) drawEllipse {
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(centerX - 100, centerY - 50, 100, 50)];
    [[UIColor magentaColor] set];
    
    //缩放
    //CGContextScaleCTM(context, 1.5, 1.5);
    
    //旋转
    //CGContextRotateCTM(context, M_PI_4);
    
    //平移
    //CGContextTranslateCTM(context, 0, -50);
    
    CGContextAddPath(context, path.CGPath);
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

#pragma mark - 画柱状图
- (void) drawHistogram {
    NSLog(@"画柱状图");
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSArray *array = @[@75,@25,@50,@80,@65];
    
    CGFloat startX = 0;
    CGFloat startY = 0;
    CGFloat histogramHeight = 0;
    CGFloat histogramWidth = self.bounds.size.width / (2 * array.count - 1);
   
    for (int i = 0; i < array.count; i++) {
        
        startX = i * histogramWidth * 2;
        histogramHeight = [array[i] floatValue] / 100.0 * self.bounds.size.height;
        startY = self.bounds.size.height - histogramHeight;
        
        [[self colorRandom] set];
        CGContextAddRect(context, CGRectMake(startX, startY, histogramWidth, histogramHeight));

//        使用UIBezierPath绘制
//        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(startX, startY, histogramWidth, histogramHeight)];
//        [path fill];
        
        CGContextFillPath(context);
    }
    
    
}

#pragma mark - 画饼状图
- (void)drawPieChart {
    NSLog(@"画饼状图");
    
    NSArray *arr = [self arrRandom];
    CGFloat radius = self.bounds.size.width * 0.5;
    CGPoint center = CGPointMake(radius, radius);
    
    CGFloat startA = 0;//起始角度
    CGFloat angle = 0;//角度
    CGFloat endA = 0;//结束角度
    
    for (int i = 0; i < arr.count; i++) {
        
        startA = endA;
        angle = [arr[i] integerValue] / 100.0 * M_PI * 2;
        endA = startA + angle;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        
        [path addLineToPoint:center];        
        [[self colorRandom] set];
        
        [path fill];
    }
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

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setNeedsDisplay];
}

-(void)setProgress:(float)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

//随机数组
- (NSArray *)arrRandom
{
    int totoal = 100;
    
    NSMutableArray *arrM = [NSMutableArray array];
    
    int temp = 0; // 30 40 30
    for (int i = 0; i < arc4random_uniform(10) + 1; i++) {
        temp = arc4random_uniform(totoal) + 1;
        
        // 100 1~100
        // 随机出来的临时值等于总值，直接退出循环，因为已经把总数分配完毕，没必要在
        [arrM addObject:@(temp)];
        // 解决方式：当随机出来的数等于总数直接退出循环。
        if (temp == totoal) {
            break;
        }
        totoal -= temp;
    }
    // 100 30 1~100
    // 70 40 0 ~ 69 1 ~ 70
    // 30 25
    // 5
    
    if (totoal) {
        [arrM addObject:@(totoal)];
    }
    return arrM;
}

//随机颜色
- (UIColor *)colorRandom
{
    // 0 ~ 255 / 255
    // OC:0 ~ 1
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


- (void) snowAnimation {
    
//    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshScreen)];
//    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
   static CGFloat startY = 0;
    UIImage *image = [UIImage imageNamed:@"雪花"];
    [image drawAtPoint:CGPointMake(centerX, startY)];
    startY += 10;
    if (startY >= self.bounds.size.height) {
        startY = 0;
    }
}

- (void)awakeFromNib {
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshScreen)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}


- (void) refreshScreen {
    [self setNeedsDisplay];
}

- (void)draw
{
    CGFloat radius = self.bounds.size.width * 0.5;
    CGPoint center = CGPointMake(radius, radius);
    
    
    CGFloat startA = 0;
    CGFloat angle = 0;
    CGFloat endA = 0;
    
    
    // 第一个扇形
    angle = 25 / 100.0 * M_PI * 2;
    endA = startA + angle;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    // 添加一根线到圆心
    [path addLineToPoint:center];
    
    // 描边和填充通用
    [[UIColor redColor] set];
    
    [path fill];
    
    // 第二个扇形
    startA = endA;
    angle = 25 / 100.0 * M_PI * 2;
    endA = startA + angle;
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    // 添加一根线到圆心
    [path1 addLineToPoint:center];
    
    // 描边和填充通用
    [[UIColor greenColor] set];
    
    [path1 fill];
    
    // 第二个扇形
    startA = endA;
    angle = 50 / 100.0 * M_PI * 2;
    endA = startA + angle;
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    // 添加一根线到圆心
    [path2 addLineToPoint:center];
    
    // 描边和填充通用
    [[UIColor blueColor] set];
    
    [path2 fill];
    
}




- (void) function {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //平移
    CGContextTranslateCTM(context, 100, 100);
    
    //缩放
    CGContextScaleCTM(context, 1.5, 1.5);
    
    //旋转
    CGContextRotateCTM(context, M_PI_4);
}


@end
