//
//  EraseImageViewController.m
//  Quartz2D
//
//  Created by fangjs on 16/4/29.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "EraseImageViewController.h"

@interface EraseImageViewController ()
@property (strong, nonatomic)  UIImageView *imageView;

@end

@implementation EraseImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageV.image = [UIImage imageNamed:@"2B"];
    self.imageView.image = [UIImage imageNamed:@"2A"];
    [self.view addSubview:imageV];
    [self.view addSubview:self.imageView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
    
}


- (void) panAction:(UIPanGestureRecognizer *) pan {
    
    //获取当前点
    CGPoint currentPoint = [pan locationInView:self.view];
    
    //获取擦出的范围
    CGFloat wh = 30;
    CGFloat x = currentPoint.x - wh * 0.5;
    CGFloat y = currentPoint.y - wh * 0.5;
    CGRect clipRect = CGRectMake(x, y, wh, wh);
    
    //获取位图上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    
    //获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //渲染图片
    [self.imageView.layer renderInContext:ctx];
    
    //擦除图片
    CGContextClearRect(ctx, clipRect);
    
    self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
