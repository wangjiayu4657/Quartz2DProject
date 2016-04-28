//
//  UIImage+ImageClip.h
//  Quartz2D
//
//  Created by fangjs on 16/4/28.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageClip)

/**
 *  剪切为圆形图片
 *
 *  @param image       需要剪切为圆形的图片
 *  @param borderWidth 边缘宽度
 *  @param borderColor 边缘颜色
 *
 *  @return  剪切后的image
 */
+(UIImage *) imageClipWithImage:(UIImage *) image borderWidth:(CGFloat) borderWidth borderColor:(UIColor *) borderColor;

/**
 *  水印图片
 *
 *  @param image     需要加水印标志的图片
 *  @param waterLogo 需要加的标志
 *
 *  @return  添加水印标志后的image
 */
+(UIImage *) imageWithWaterImage:(UIImage *) image waterLogo:(NSString *) waterLogo;

/**
 *  水印图片
 *
 *  @param image     需要加水印标志的图片
 *  @param logoColor 水印标志的颜色
 *  @param waterLogo 需要加的标志
 *
 *  @return  添加水印标志后的image
 */
+(UIImage *) imageWithWaterImage:(UIImage *) image logoCorlor:(UIColor *) logoColor waterLogo:(NSString *) waterLogo ;


/**
 *  水印图片
 *
 *  @param image      需要加水印标志的图片
 *  @param waterPoint 需要在什么位置添加水印标志
 *  @param waterLogo  需要加的标志
 *
 *  @return  添加水印标志后的image
 */
+(UIImage *)imageWithWaterImage:(UIImage *)image waterPoint:(CGPoint)waterPoint waterLogo:(NSString *)waterLogo;

@end
