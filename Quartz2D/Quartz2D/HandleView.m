//
//  HandleView.m
//  Quartz2D
//
//  Created by fangjs on 16/5/4.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "HandleView.h"
#import "UIImage+ImageClip.h"

@interface HandleView() <UIGestureRecognizerDelegate>

@property (strong , nonatomic) UIImageView *imageView;

@end

@implementation HandleView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.userInteractionEnabled = YES;
        [self addSubview:self.imageView];
        
        [self addGesture];
    }
    return self;
}

//设置图片
- (void) setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

//添加手势
- (void) addGesture {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.imageView addGestureRecognizer:pan];
    
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinAction:)];
    pin.delegate = self;
    [self.imageView addGestureRecognizer:pin];
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAction:)];
    rotation.delegate = self;
    [self.imageView addGestureRecognizer:rotation];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.imageView addGestureRecognizer:longPress];
}

//滑动手势响应
- (void) panAction:(UIPanGestureRecognizer *) pan {
    //获取偏移量
    CGPoint currentP = [pan translationInView:self.imageView];
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, currentP.x, currentP.y);
    
    //复位
    [pan setTranslation:CGPointZero inView:self.imageView];
}

//缩放手势响应
- (void) pinAction:(UIPinchGestureRecognizer *) pin {
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pin.scale, pin.scale);
    
    //复位
    pin.scale = 1;
}

//旋转手势响应
- (void) rotationAction:(UIRotationGestureRecognizer *) rotation {
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotation.rotation);
    
    //复位
    rotation.rotation = 0;
}

//长安手势响应
- (void) longPressAction:(UILongPressGestureRecognizer *) longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.25 animations:^{
            self.imageView.alpha = 0.5;
            [UIView animateWithDuration:0.25 animations:^{
                self.imageView.alpha = 1.0;
            } completion:^(BOOL finished) {
                UIImage *image = [UIImage imageWithCaputureView:self];
                if (self.callBack) {
                    self.callBack(image);
                }
                //移除
                [self removeFromSuperview];
            }];
        }];
    }
}

//是否允许其它手势同时响应
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}









/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
