//
//  HandleView.h
//  Quartz2D
//
//  Created by fangjs on 16/5/4.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HandleView : UIView

@property (strong , nonatomic) UIImage *image;

@property (strong , nonatomic) void (^callBack)(UIImage *image);

@end
