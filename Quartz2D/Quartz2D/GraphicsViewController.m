//
//  GraphicsViewController.m
//  Quartz2D
//
//  Created by fangjs on 16/4/29.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "GraphicsViewController.h"
#import "UIImage+ImageClip.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


@interface GraphicsViewController ()
@property (strong, nonatomic)  UIImageView *imageView;
@property (strong, nonatomic) UIView *clipView;

@property (assign, nonatomic) CGPoint startPoint;

@end



@implementation GraphicsViewController

- (UIView *)clipView {
    if (!_clipView) {
        _clipView = [[UIView alloc] init];
        _clipView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self.imageView addSubview:_clipView];
    }
    return _clipView;
}

-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2 - 300/2, ScreenHeight/2 - 300/2, 300, 300)];
        _imageView.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self.imageView addGestureRecognizer:pan];
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self clipOvalImage];
    
    [self addWaterMark];
    
    
}

//剪切圆形图片
- (void) clipOvalImage {
    UIImage *image = [UIImage imageClipWithImage:[UIImage imageNamed:@"image5"] borderWidth:3 borderColor:[UIColor whiteColor]];
    self.imageView.image = image;
}

//添加水印标志
- (void) addWaterMark {
    UIImage *image = [UIImage imageWithWaterImage:[UIImage imageNamed:@"image5"] waterMark:@"你好啊"];
    self.imageView.image = image;
}

//在指定位置添加水印标志
- (void) addWaterMarkInSpecifiedLocation {
    UIImage *image = [UIImage imageWithWaterImage:[UIImage imageNamed:@"image5"] waterPoint:CGPointMake(150,  60) waterMark:@"你好啊"];
    self.imageView.image = image;
}

//在剪切完后的图片上添加水印标志
- (void) addWaterMarkInClipOvalImage {
    UIImage *image = [UIImage imageClipWithImage:[UIImage imageNamed:@"image5"] borderWidth:1 borderColor:[UIColor greenColor]];
    UIImage *image1 = [UIImage imageWithWaterImage:image waterPoint:CGPointMake(100, 100) waterMark:@"HELLO"];
    self.imageView.image = image1;
}

//屏幕截图
- (void) screenshots {
    UIImage *image = [UIImage imageWithCaputureView:self.view];
    NSData *data = UIImagePNGRepresentation(image);
    NSFileManager *manger = [NSFileManager defaultManager];
    if (![manger fileExistsAtPath:@"/Users/wujue/Desktop/截图"]) {
        static NSInteger index = 2;
        NSString *str = @"/Users/wujue/Desktop/截图";
        NSString *locationPath = [NSString stringWithFormat:@"%@/newImage%ld.png",str,(long)index];
        [data writeToFile:locationPath atomically:YES];
        index++;
    }
}

//根据需求截图
- (void) panAction:(UIPanGestureRecognizer *) pan {
    CGPoint endPoint = CGPointZero;
    if (pan.state == UIGestureRecognizerStateBegan) {
        //获取起始点的位置
        self.startPoint = [pan locationInView:self.imageView];
    }
    else if (pan.state == UIGestureRecognizerStateChanged) {
        //获取结束点的位置
        endPoint = [pan locationInView:self.imageView];
        CGFloat w = endPoint.x - self.startPoint.x;
        CGFloat h = endPoint.y - self.startPoint.y;
        CGRect rect = CGRectMake(self.startPoint.x, self.startPoint.y, w, h);
        self.clipView.frame = rect;
    }else if (pan.state == UIGestureRecognizerStateEnded) {
        self.clipView.alpha = 0;
        
        //获取位图上下文
        UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0);
        
        //设置裁剪区域
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:_clipView.frame];
        [clipPath addClip];
        
        //获取上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        //把空间上的内容渲染到上下文
        [self.imageView.layer renderInContext:ctx];
        
        //生成一张新图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        //关闭上下文
        UIGraphicsEndImageContext();
        
        [self.clipView removeFromSuperview];
        self.clipView = nil;
    }
}

//截取全屏图
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self screenshots];
}

////擦除图片
//- (void)eraseTheImage {
//    
//}

















/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
