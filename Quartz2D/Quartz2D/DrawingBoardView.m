//
//  DrawingBoardView.m
//  Quartz2D
//
//  Created by fangjs on 16/5/4.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "DrawingBoardView.h"
#import "DrawPath.h"

@interface DrawingBoardView ()

@property (strong , nonatomic) DrawPath *path;
@property (strong , nonatomic) NSMutableArray *pathArray;
@end

@implementation DrawingBoardView

-(NSMutableArray *)pathArray {
    if (_pathArray == nil) {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}

-(void)setImage:(UIImage *)image {
    _image = image;
    [self.pathArray addObject:image];
    [self setNeedsDisplay];
}

- (void)awakeFromNib {
    [self setUpDrawView];
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpDrawView];
    }
    return self;
}

- (void) setUpDrawView {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    self.pathColor = [UIColor blackColor];
    self.lineWidth = 1;
}

- (void) pan:(UIPanGestureRecognizer *) pan {
    //获取当前点
    CGPoint currentPoint = [pan locationInView:self];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        //创建贝塞尔路径
        self.path = [DrawPath bezierPath];
        //设置路径颜色
        self.path.pathColor = self.pathColor;
        self.path.lineWidth = self.lineWidth;
        //设置路径的起点
         [self.path moveToPoint:currentPoint];
        //保存描述好的路径
        [self.pathArray addObject:self.path];
    }
   
    if (pan.state == UIGestureRecognizerStateChanged) {
        //连接线到当前触摸点
        [self.path addLineToPoint:currentPoint];
    }
    //重绘
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    for (DrawPath *path in self.pathArray) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *) path;
            [image drawInRect:rect];
        }
        else {
            [path.pathColor set];
            [path stroke];
        }
       
    }
}

//清屏
- (void)clearContent {
    [self.pathArray removeAllObjects];
    [self setNeedsDisplay];
}

//撤销
-(void)Undo {
    [self.pathArray removeLastObject];
    [self setNeedsDisplay];
}


@end
