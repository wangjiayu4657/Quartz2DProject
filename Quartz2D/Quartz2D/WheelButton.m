//
//  WheelButton.m
//  Quartz2D
//
//  Created by fangjs on 16/5/5.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WheelButton.h"

@implementation WheelButton


//寻找最合适的 view
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGFloat x = 0;
    CGFloat y = self.bounds.size.height / 2.0;
    CGFloat w = self.bounds.size.width;
    CGFloat h = y;
    
    CGRect rect = CGRectMake(x, y, w, h);
    
    if (CGRectContainsPoint(rect, point)) {
        return nil;
    }else {
        return [super hitTest:point withEvent:event];
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat imageW = 40;
    CGFloat imageH = 46;
    CGFloat imageX = (contentRect.size.width - imageW) / 2.0;
    CGFloat imageY = 25;
    
    CGRect rect = CGRectMake(imageX, imageY, imageW, imageH);
    return rect;
}


- (void)setHighlighted:(BOOL)highlighted {
    
}














/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
