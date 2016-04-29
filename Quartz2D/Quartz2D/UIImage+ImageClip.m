//
//  UIImage+ImageClip.m
//  Quartz2D
//
//  Created by fangjs on 16/4/28.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "UIImage+ImageClip.h"

@implementation UIImage (ImageClip)

+(UIImage *)imageClipWithImage:(UIImage *)clipImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    CGFloat imageW = clipImage.size.width ;
    CGFloat OvalWH = imageW + borderWidth * 2;
    
    /**开启位图上下文*/
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(OvalWH, OvalWH), NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, OvalWH, OvalWH)];
    [borderColor set];
    /**填充*/
    [path fill];
    /**设置裁剪区域*/
    UIBezierPath *pathClip = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, imageW, imageW)];
    /**把路径设置为裁剪区域*/
    [pathClip addClip];
    /**绘制图片*/
    [clipImage drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    /**从上下文中获取图片*/
    UIImage *imageClip = UIGraphicsGetImageFromCurrentImageContext();
    /**关闭上下文*/
    UIGraphicsEndImageContext();

    return imageClip;
}

+(UIImage *)imageWithWaterImage:(UIImage *)image waterMark:(NSString *)waterLogo {
    UIImage *waterImage = [self imageWithWaterImage:image markCorlor:nil waterMark:waterLogo];
    return waterImage;
}

+(UIImage *) imageWithWaterImage:(UIImage *)image markCorlor:(UIColor *)logoColor waterMark:(NSString *)waterLogo {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    [image drawAtPoint:CGPointZero];
    if (logoColor == nil) {
        [waterLogo drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30],NSForegroundColorAttributeName:[UIColor redColor]}];
    }else {
        [waterLogo drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30],NSForegroundColorAttributeName:logoColor}];
    }
    
    UIImage *waterImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return waterImage;
}

+(UIImage *)imageWithWaterImage:(UIImage *)image waterPoint:(CGPoint)waterPoint waterMark:(NSString *)waterLogo {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    [image drawAtPoint:CGPointZero];
    [waterLogo drawAtPoint:waterPoint withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIImage *waterImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return waterImage;
}


+(UIImage *)imageWithCaputureView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}






























@end
