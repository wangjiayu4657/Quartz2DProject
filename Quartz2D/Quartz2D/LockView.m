//
//  LockView.m
//  Quartz2D
//
//  Created by fangjs on 16/4/29.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "LockView.h"

@interface LockView ()

@property (assign , nonatomic) CGPoint currentPoint;
@property (strong , nonatomic) NSMutableArray *btnSelected;

@end


@implementation LockView

-(NSMutableArray *)btnSelected {
    if (_btnSelected == nil) {
        _btnSelected = [NSMutableArray array];
    }
    return _btnSelected;
}

-(void)awakeFromNib {
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        
        [self addSubview:btn];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    //获取子控件的个数
    NSUInteger count = self.subviews.count;
    //总行数
    int cols = 3;
    //行数
    NSInteger col = 0;
    //列数
    NSInteger row = 0;
   
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 74;
    CGFloat h = 74;
    
    //间距
    CGFloat margin = (self.bounds.size.width - cols * w) / (cols + 1);
    
    
    for (NSInteger i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        
        col = i % cols;
        row = i / cols;
        
        x = margin + col * (margin + w);
        y = row * (margin + h);
        
        btn.frame = CGRectMake(x, y, w, h);
    }
}

- (IBAction)pan:(UIPanGestureRecognizer *)pan {
    self.currentPoint = [pan locationInView:self];
    for (UIButton *btn in self.subviews) {
        // 点在某个范围内,并且按钮没有被选中的状态下才可以被装进数组
        if (CGRectContainsPoint(btn.frame, self.currentPoint) && btn.selected == NO) {
            btn.selected = YES;
            [self.btnSelected addObject:btn];
        }
    }
    
    //重绘
    [self setNeedsDisplay];
    if (pan.state == UIGestureRecognizerStateEnded) {
        //保存密码
        NSMutableString *password = [NSMutableString string];
        [self.btnSelected enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = obj;
            //取消 btn 的选中状态
            btn.selected = NO;
            [password appendFormat:@"%ld",btn.tag];

        }];
        NSLog(@"密码 :%@",password);
        //清除连线
        [self.btnSelected removeAllObjects];
    }
}

- (void)drawRect:(CGRect)rect {
    // 没有选中按钮，不需要连线
    if (self.btnSelected.count == 0) return;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [[UIColor greenColor] set];
    path.lineWidth = 10;
   
    for (int i = 0;i< self.btnSelected.count;i++) {
        UIButton *btn = self.btnSelected[i];
        if (i == 0) {
             [path moveToPoint:btn.center];
        }else {
             [path addLineToPoint:btn.center];
        }
    }
    
    [path addLineToPoint:self.currentPoint];
     path.lineJoinStyle = kCGLineJoinRound;
    
    [path stroke];
}


@end
