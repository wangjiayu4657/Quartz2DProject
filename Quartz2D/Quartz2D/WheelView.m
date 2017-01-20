//
//  WheelView.m
//  Quartz2D
//
//  Created by fangjs on 16/5/5.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WheelView.h"
#import "WheelButton.h"


@interface WheelView ()

@property (weak , nonatomic) IBOutlet UIImageView *wheelView;

@property (strong , nonatomic) UIButton *selectBtn;
@property (strong , nonatomic) CADisplayLink *link;

@end



@implementation WheelView

- (CADisplayLink *)link {
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeChange)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _link;
}

- (void)awakeFromNib {
    self.wheelView.userInteractionEnabled = YES;
    UIImage *image = [UIImage imageNamed:@"LuckyAstrology"];
    
    UIImage *selectImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];

    //获取当前使用的图片像素和点的比例
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat imageW = image.size.width / 12 * scale;
    CGFloat imageH = image.size.height * scale;
    
    CGFloat btnWH = self.bounds.size.width / 2.0;
    
    for (int i = 0; i < 12; i++) {
        WheelButton *btn = [WheelButton buttonWithType:UIButtonTypeCustom];
        //设置锚点
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.layer.position = CGPointMake(btnWH, btnWH);
        btn.bounds = CGRectMake(0, 0, 68, 143);
        
        //按钮的旋转角度
        CGFloat angleA = (30 * i) / 180.0 * M_PI;
        btn.transform = CGAffineTransformMakeRotation(angleA);
       
        [self.wheelView addSubview:btn];
        
        //设置裁剪区域
        CGRect rect = CGRectMake(imageW * i, 0, imageW, imageH);
        
        //给按钮设置剪切后图片
        CGImageRef ref =  CGImageCreateWithImageInRect(image.CGImage, rect);
        UIImage *newImage = [UIImage imageWithCGImage:ref];
        [btn setImage:newImage forState:UIControlStateNormal];
        
        //给按钮设置剪切后的高亮图片
        ref = CGImageCreateWithImageInRect(selectImage.CGImage, rect);
        UIImage *selImage = [UIImage imageWithCGImage:ref];
        [btn setImage:selImage forState:UIControlStateSelected];
        
        //设置按钮的背景图片
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            [self btnClick:btn];
        }
    }
}

- (void) btnClick:(UIButton *) btn {
    self.selectBtn.selected = NO;
    btn.selected = YES;
    self.selectBtn = btn;
}

//开始
-(void)startRotating {
    self.link.paused = NO;
}

//暂停
-(void)pauseRotating {
     self.link.paused = YES;
}

//核心动画
- (void) animationStart {
    self.link.paused = YES;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.toValue = @(M_PI * 6);
    animation.duration = 0.5;
    animation.delegate = self;
    
    //无限循环
    //animation.repeatCount = MAXFLOAT;
    
    [self.wheelView.layer addAnimation:animation forKey:nil];
    
    // 根据选中的按钮获取旋转的度数(弧度转角度)
    // 通过transform获取角度
    CGFloat angle = atan2(self.selectBtn.transform.b, self.selectBtn.transform.a);
    
    //旋转转盘是选中的按钮回到初始位置
    self.wheelView.transform = CGAffineTransformMakeRotation(-angle);
    
}

- (void)timeChange {
    CGFloat angleA = (45 / 60.0) / 180.0 * M_PI;
    self.wheelView.transform = CGAffineTransformRotate(self.wheelView.transform, angleA);
}

- (IBAction)startPick:(UIButton *) btn {
    [self animationStart];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.link.paused = NO;
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
